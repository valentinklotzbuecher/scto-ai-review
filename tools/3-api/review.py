"""One call per product through the API, with the Anthropic Python SDK.

The same review prompt (prompt.md) and the same answer format (schema.json) for every
product: a table of issues (issues.csv), each answer in full (<name>.review.json) and a
log of every run with tokens and cost (runs.csv).

    pip install anthropic
    export ANTHROPIC_API_KEY=...     # an API key: billed per use, not your subscription
    python tools/3-api/review.py demo/sse/DEMO-TKA_SSE.pdf
    python tools/3-api/review.py --dry-run demo/sse/DEMO-TKA_SSE.pdf   # shows the request, sends nothing

Each PDF is reviewed together with the Quarto source of the same name beside it, if
there is one. Only send documents your data rules allow; never patient-level data.
"""
import argparse
import base64
import csv
import datetime
import hashlib
import json
import pathlib
import sys

MODEL = "claude-opus-5-5"
EFFORT = "max"  # low | medium | high | xhigh | max: "max" is the talk's "maximum effort"
MAX_TOKENS = 64000  # thinking plus the answer; the request streams, so long runs don't time out
PRICE_PER_MILLION = {"input": 4.00, "output": 20.00}  # US$, Claude Opus 5.5 list price, November 2026

HERE = pathlib.Path(__file__).resolve().parent
PROMPT = (HERE / "prompt.md").read_text(encoding="utf-8")
PROMPT_MD5 = hashlib.md5((HERE / "prompt.md").read_bytes()).hexdigest()[:12]  # which prompt a run used
SCHEMA = json.loads((HERE / "schema.json").read_text(encoding="utf-8"))


def build_request(pdf: pathlib.Path) -> dict:
    """The request for one product: the PDF as a document, the Quarto source as text."""
    content = [{
        "type": "document",
        "source": {
            "type": "base64",
            "media_type": "application/pdf",
            "data": base64.standard_b64encode(pdf.read_bytes()).decode("ascii"),
        },
    }]
    qmd = pdf.with_suffix(".qmd")
    if qmd.exists():
        content.append({"type": "text", "text": f"Quarto source ({qmd.name}):\n\n{qmd.read_text(encoding='utf-8')}"})
    content.append({"type": "text", "text": f"Review {pdf.name} as instructed."})
    return {
        "model": MODEL,
        "max_tokens": MAX_TOKENS,
        "system": PROMPT,
        "messages": [{"role": "user", "content": content}],
        "thinking": {"type": "adaptive"},  # the model decides how much to think; EFFORT sets how hard
        "output_config": {"effort": EFFORT, "format": {"type": "json_schema", "schema": SCHEMA}},
        # If the model declines on a policy ground, the API re-runs the request on a fallback model.
        "betas": ["server-side-fallback-2026-07-01"],
        "fallbacks": "default",
    }


def describe(request: dict) -> str:
    """The request without the PDF's bytes, for --dry-run."""
    shown = json.loads(json.dumps(request))
    for block in shown["messages"][0]["content"]:
        if block["type"] == "document":
            block["source"]["data"] = f"<{len(block['source']['data'])} base64 characters>"
        elif len(block.get("text", "")) > 300:
            block["text"] = block["text"][:300] + " …"
    shown["system"] = shown["system"][:300] + " …"
    shown["output_config"]["format"]["schema"] = "<schema.json>"
    return json.dumps(shown, indent=2, ensure_ascii=False)


def review(client, pdf: pathlib.Path, out: pathlib.Path) -> None:
    request = build_request(pdf)
    with client.beta.messages.stream(**request) as stream:
        final = stream.get_final_message()
    if final.stop_reason == "refusal":
        sys.exit(f"{pdf.name}: the model declined the request.")
    if final.stop_reason == "max_tokens":
        sys.exit(f"{pdf.name}: the answer hit max_tokens and is incomplete; raise MAX_TOKENS or lower EFFORT.")
    text = next(block.text for block in final.content if block.type == "text")
    answer = json.loads(text)

    (out / f"{pdf.stem}.review.json").write_text(json.dumps(answer, indent=2, ensure_ascii=False), encoding="utf-8")
    table = out / "issues.csv"
    fields = ["product", "severity", "area", "location", "problem", "consequence", "fix", "verified"]
    new_table = not table.exists()
    with table.open("a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        if new_table:
            writer.writeheader()
        for issue in answer["issues"]:
            writer.writerow({"product": pdf.name, **issue})

    usage = final.usage
    cost = (usage.input_tokens * PRICE_PER_MILLION["input"] + usage.output_tokens * PRICE_PER_MILLION["output"]) / 1e6
    log = {
        "time": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds"),
        "product": pdf.name,
        "model": final.model,  # the model that answered: a fallback model if it took over
        "effort": EFFORT,
        "prompt_md5": PROMPT_MD5,
        "input_tokens": usage.input_tokens,
        "output_tokens": usage.output_tokens,
        "cost_usd_list_price": round(cost, 2),
        "decision": answer["decision"],
        "issues": len(answer["issues"]),
    }
    runs = out / "runs.csv"
    new_runs = not runs.exists()
    with runs.open("a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(log))
        if new_runs:
            writer.writeheader()
        writer.writerow(log)
    print(f"{pdf.name}: {answer['decision']}; issues: {len(answer['issues'])}; about ${cost:.2f}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("pdfs", nargs="+", type=pathlib.Path, help="rendered products (PDF)")
    parser.add_argument("--out", type=pathlib.Path, default=pathlib.Path("review-results"), help="output folder")
    parser.add_argument("--dry-run", action="store_true", help="show the request for each product and send nothing")
    args = parser.parse_args()

    if args.dry_run:
        for pdf in args.pdfs:
            print(f"--- {pdf}\n{describe(build_request(pdf))}")
        return

    import anthropic  # only needed for a real run

    args.out.mkdir(parents=True, exist_ok=True)
    client = anthropic.Anthropic()  # reads ANTHROPIC_API_KEY
    for pdf in args.pdfs:
        review(client, pdf, args.out)


if __name__ == "__main__":
    main()
