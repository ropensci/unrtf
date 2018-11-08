#' Convert rtf Documents
#'
#' Converts an rtf document to html, text or latex. Output in html is recommended 
#' because `unrtf` has limited support for converting between character encodings
#' which is problematic for non-ascii text.
#' 
#' Output can be customized via a set of `.conf` files which serve as templates for
#' the various formats. The default conf files are located in `system.file("share", package = "unrtf")`
#' To modify the output, copy these files to a custom location and set pass the 
#' directory as the `conf_dir` argument in `unrtf`.
#'
#' @export
#' @param file path or url to the 'rtf' file
#' @param format output format, must be "text", "html" or "latex"
#' @param verbose print some output to stderr
#' @param conf_dir use a custom dir with `.conf` files which serve as output templates. 
#' @examples library(unrtf)
#' text <- unrtf("https://jeroen.github.io/files/sample.rtf", format = "text")
#' html <- unrtf("https://jeroen.github.io/files/sample.rtf", format = "html")
#' cat(text)
unrtf <- function(file = NULL, format = c("html", "text", "latex"), verbose = FALSE, conf_dir = NULL){
  format <- match.arg(format)
  args <- if(length(file)){
    if(grepl("^https?://", file)){
      tmp <- tempfile(fileext = ".rtf")
      utils::download.file(file, tmp, mode = "wb", quiet = !verbose)
      file <- tmp
    }
    file <- normalizePath(file, mustWork = TRUE)
    # Path with spaces need shQuote() on Windows, see https://github.com/jeroen/sys/issues/4
    c(
      if(verbose) 
        "--verbose",
      if(length(conf_dir))
        c("-P", normalizePath(conf_dir, mustWork = TRUE)),
      paste0("--", format), file
    )
  }
  if(is_windows()){
    old_path <- Sys.getenv("PATH")
    on.exit(Sys.setenv(PATH = old_path), add = TRUE)
    Sys.setenv(PATH = paste(R.home("bin"), old_path, sep = ";"))
  }
  wd <- getwd()
  on.exit(setwd(wd), add = TRUE)
  bindir <- system.file("bin", package = "unrtf")
  sharedir <- system.file("share", package = "unrtf")
  setwd(bindir)
  postfix <- if(is_windows()) .Machine$sizeof.pointer * 8
  path <- file.path(bindir, paste0("unrtf", postfix))
  outcon <- rawConnection(raw(0), "r+")
  on.exit(close(outcon), add = TRUE)
  if(verbose)
    cat(sprintf("Calling: %s %s\n", path, paste(args, collapse = " ")), file = stderr())
  status <- sys::exec_wait(path, args, std_out = outcon)
  if(status != 0)
    stop("System call to 'unrtf' failed", call. = FALSE)
  
  # Unclear what encoding 'unrtf' uses. The html output is simply escaped.
  out <- rawToChar(rawConnectionValue(outcon))
  Encoding(out) <- "latin1"
  enc2utf8(out)
}

is_windows <- function(){
  identical(.Platform$OS.type, "windows")
}
