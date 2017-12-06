**WARNING: This package is under construction. Use with care.**

<%
## Reuse the main vignette
md <- R.rsp::rstring(file="vignettes/future.apply-1-overview.md.rsp", postprocess=FALSE)

## Drop the header
md <- unlist(strsplit(md, split="\n", fixed=TRUE))
md <- md[-seq_len(grep("^## ", md)[1]-1)]

## Drop the footer
md <- md[seq_len(grep("^---", md)[1]-1)]

## Turn otherwise local links to CRAN for README.md
md <- gsub(": (future-.*[.]html)",
           ": https://cran.r-project.org/web/packages/future.apply/vignettes/\\1", md)

## Output
cat(md, sep="\n")
%>
