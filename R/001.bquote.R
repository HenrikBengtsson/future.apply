#' @importFrom utils globalVariables
globalVariables(c(".", ".."))

## bquote_compile() and bquote_apply() are available in future (>= 1.22.0)
bquote_compile <- import_future("bquote_compile")
bquote_apply <- import_future("bquote_apply")

