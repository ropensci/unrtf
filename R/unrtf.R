#' Convert rtf
#'
#' Converts a document in 'rtf' format to other formats
#'
#' @export
#' @param file path or url to the 'rtf' file
#' @param format output format, must be "text", "html" or "latex"
#' @param verbose print some output to stderr
#' @examples library(unrtf)
#' text <- unrtf("http://www-igm.univ-mlv.fr/~mac/ENS/01-projets/XMLV/pelleas/exemples/Sample.rtf")
#' cat(text)
unrtf <- function(file = NULL, format = c("text", "html", "latex"), verbose = FALSE){
  format <- match.arg(format)
  args <- if(length(file)){
    if(grepl("^https?://", file)){
      tmp <- tempfile(fileext = ".rtf")
      utils::download.file(file, tmp, mode = "wb")
      file <- tmp
    }
    file <- normalizePath(file, mustWork = TRUE)
    # Path with spaces need shQuote() on Windows, see https://github.com/jeroen/sys/issues/4
    c(
      if(verbose) "--verbose",
      paste0("--", format),
      ifelse(is_windows(), shQuote(file), file)
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
