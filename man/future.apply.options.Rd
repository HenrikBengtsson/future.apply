% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/options.R
\name{future.apply.options}
\alias{future.apply.options}
\alias{future.apply.debug}
\alias{R_FUTURE_APPLY_DEBUG}
\title{Options used for future.apply}
\description{
Below are the \R options and environment variables that are used by the
\pkg{future.apply} package and packages enhancing it.\cr
\cr
\emph{WARNING: Note that the names and the default values of these options may
change in future versions of the package.  Please use with care until
further notice.}
}
\details{
For settings specific to the \pkg{future} package, see
\link[future:future.options]{future::future.options} page.
}
\section{Options for debugging future.apply}{

\describe{
\item{\option{future.apply.debug}:}{(logical) If \code{TRUE}, extensive debug messages are generated. (Default: \code{FALSE})}
}
}

\section{Environment variables that set R options}{

All of the above \R \option{future.apply.*} options can be set by
corresponding environment variable \env{R_FUTURE_APPLY_*} \emph{when the
\pkg{future.apply} package is loaded}.
For example, if \code{R_FUTURE_APPLY_DEBUG=TRUE}, then option
\option{future.apply.debug} is set to \code{TRUE} (logical).
}

\examples{
\dontrun{
options(future.apply.debug = TRUE)
}

}
\seealso{
To set \R options or environment variables when \R starts (even before the \pkg{future} package is loaded), see the \link[base]{Startup} help page.  The \href{https://cran.r-project.org/package=startup}{\pkg{startup}} package provides a friendly mechanism for configuring \R's startup process.
}
