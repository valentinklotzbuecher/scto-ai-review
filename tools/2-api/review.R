# One call per product through the API, in R with ellmer.
#
# The same review prompt (prompt.md) and the same answer format (schema.json) for every
# product: a table of issues (issues.csv), each answer in full (<name>.review.json) and a
# log of every run with tokens and cost (runs.csv).
#
#   install.packages(c("ellmer", "jsonlite"))   # ellmer 0.5.2 or later
#   Sys.setenv(ANTHROPIC_API_KEY = "...")        # an API key: billed per use, not your subscription
#   Rscript tools/2-api/review.R demo/sse/DEMO-TKA_SSE.pdf
#   Rscript tools/2-api/review.R --dry-run demo/sse/DEMO-TKA_SSE.pdf   # shows the request, sends nothing
#
# Each PDF is reviewed together with the Quarto source of the same name beside it, if
# there is one. Only send documents your data rules allow; never patient-level data.

library(ellmer)

model  <- "claude-opus-5-5"
effort <- "max"   # low | medium | high | xhigh | max: "max" is the talk's "maximum effort"
price  <- c(input = 4, output = 20)   # US$ per million tokens, Claude Opus 5.5 list price, November 2026
out    <- "review-results"
options(ellmer_timeout_s = 30 * 60)   # a review at maximum effort can outlast ellmer's 5-minute default

args    <- commandArgs(trailingOnly = TRUE)
dry_run <- "--dry-run" %in% args
pdfs    <- setdiff(args, "--dry-run")
if (!length(pdfs)) stop("Give one or more rendered products (PDF), e.g. demo/sse/DEMO-TKA_SSE.pdf")

file_arg <- grep("^--file=", commandArgs(), value = TRUE)
here <- if (length(file_arg)) dirname(normalizePath(sub("^--file=", "", file_arg))) else "tools/2-api"
prompt <- paste(readLines(file.path(here, "prompt.md"), warn = FALSE), collapse = "\n")
prompt_md5 <- substr(unname(tools::md5sum(file.path(here, "prompt.md"))), 1, 12)   # which prompt a run used
answer_type <- type_from_schema(path = file.path(here, "schema.json"))

if (dry_run) {
  # Intercept the request: print what would be sent and answer with an empty review.
  Sys.setenv(ANTHROPIC_API_KEY = Sys.getenv("ANTHROPIC_API_KEY", "dry-run"))
  options(httr2_mock = function(req) {
    body <- req$body$data
    blocks <- vapply(body$messages[[1]]$content, function(b) b$type, character(1))
    cat("model:", body$model, "| max_tokens:", body$max_tokens,
        "| thinking:", body$thinking$type, "| effort:", body$output_config$effort,
        "| answer format:", body$output_config$format$type, "\n")
    cat("system prompt:", nchar(body$system[[1]]$text), "characters | content blocks:",
        paste(blocks, collapse = ", "), "\n")
    empty <- list(decision = "no changes", summary = "dry run", issues = list(), needs_code_run = list())
    httr2::response_json(body = list(
      id = "dry-run", type = "message", role = "assistant", model = body$model,
      content = list(list(type = "text", text = as.character(jsonlite::toJSON(empty, auto_unbox = TRUE)))),
      stop_reason = "end_turn", usage = list(input_tokens = 0, output_tokens = 0)
    ))
  })
}

if (!dry_run) dir.create(out, showWarnings = FALSE)
for (pdf in pdfs) {
  qmd <- sub("\\.pdf$", ".qmd", pdf)
  inputs <- list(content_pdf_file(pdf))
  if (file.exists(qmd)) {
    source_text <- paste(readLines(qmd, warn = FALSE), collapse = "\n")
    inputs <- c(inputs, paste0("Quarto source (", basename(qmd), "):\n\n", source_text))
  }
  inputs <- c(inputs, paste("Review", basename(pdf), "as instructed."))

  chat <- chat_anthropic(
    model = model,
    system_prompt = prompt,
    params = params(max_tokens = 64000, reasoning_effort = effort)   # thinking plus the answer
  )
  # Streams on a real run, so a long review keeps its connection open; prints the answer as it arrives.
  answer <- do.call(chat$chat_structured, c(inputs, list(type = answer_type, echo = if (dry_run) "none" else "output")))
  if (dry_run) next

  name <- tools::file_path_sans_ext(basename(pdf))
  jsonlite::write_json(answer, file.path(out, paste0(name, ".review.json")), auto_unbox = TRUE, pretty = TRUE)

  issues <- answer$issues
  if (length(issues) && !is.data.frame(issues)) issues <- do.call(rbind, lapply(issues, as.data.frame))
  if (length(issues) && nrow(issues)) {
    issues <- cbind(product = basename(pdf), issues)
    table <- file.path(out, "issues.csv")
    write.table(issues, table, sep = ",", row.names = FALSE, qmethod = "double",
                append = file.exists(table), col.names = !file.exists(table))
  }

  tokens <- chat$get_tokens()
  input  <- sum(tokens$input, na.rm = TRUE)
  output <- sum(tokens$output, na.rm = TRUE)
  cost   <- (input * price[["input"]] + output * price[["output"]]) / 1e6
  log <- data.frame(
    time = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"), product = basename(pdf), model = model,
    effort = effort, prompt_md5 = prompt_md5, input_tokens = input, output_tokens = output,
    cost_usd_list_price = round(cost, 2), decision = answer$decision,
    issues = if (is.data.frame(issues)) nrow(issues) else length(issues)
  )
  runs <- file.path(out, "runs.csv")
  write.table(log, runs, sep = ",", row.names = FALSE, append = file.exists(runs), col.names = !file.exists(runs))
  cat(basename(pdf), ": ", answer$decision, "; issues: ", log$issues, "; about $", sprintf("%.2f", cost), "\n", sep = "")
}
