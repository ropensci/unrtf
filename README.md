# rOpenSci: The *unrtf* package <img src="hexlogo.png" align="right" height="134.5" />

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/ropensci/unrtf.svg?branch=master)](https://travis-ci.org/ropensci/unrtf)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/unrtf?branch=master&svg=true)](https://ci.appveyor.com/project/jeroen/unrtf)
[![Coverage Status](https://codecov.io/github/ropensci/unrtf/coverage.svg?branch=master)](https://codecov.io/github/ropensci/unrtf?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/unrtf)](http://cran.r-project.org/package=unrtf)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/unrtf)](http://cran.r-project.org/web/packages/unrtf/index.html)

> Extract Text from Rich Text Format (rtf) Documents

Wraps the [unrtf](https://www.gnu.org/software/unrtf/) utility to extract text from rtf files. 

## Installation

```r
install.packages("unrtf")
```

## Hello World

The function has only a single function `unrtf()`. It takes either a local 
file path or a URL to a word document:

```r
library(unrtf)
text <- unrtf("https://jeroen.github.io/files/sample.rtf", format = "text")
html <- unrtf("https://jeroen.github.io/files/sample.rtf", format = "html")
cat(text)
```

```
###  Translation from RTF performed by UnRTF, version 0.21.9 
### font table contains 11 fonts total

TITLE: It is an example test rtf-file to RTF2XML bean for testing

AUTHOR: kissj
### creation date: 17 April 2000 15:34 
### revision date: 19 April 2000 09:34 
### total pages: 2
### total words: 217
### total chars: 1240

-----------------
It is an example test rtf-file to RTF2XML bean for testing

Font size 10, plain text;
Font size 12, bold text. Underline,bold text.
 Underline,italic,bold text. 
Font size 22, plain text.
 Bold text.
```

