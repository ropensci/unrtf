# unrtf

[![Build Status](https://travis-ci.org/ropensci/unrtf.svg?branch=master)](https://travis-ci.org/ropensci/unrtf)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/unrtf?branch=master&svg=true)](https://ci.appveyor.com/project/jeroen/unrtf)
[![Coverage Status](https://codecov.io/github/ropensci/unrtf/coverage.svg?branch=master)](https://codecov.io/github/ropensci/unrtf?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/unrtf)](http://cran.r-project.org/package=unrtf)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/unrtf)](http://cran.r-project.org/web/packages/unrtf/index.html)

> Extract Text from Rich Text Format (rtf) Documents

Wraps the [unrtf](https://www.gnu.org/software/unrtf/) utility to extract text from rtf files. 

## Installation

```
devtools::install_github("ropensci/unrtf")
```

## Hello World

The function has only a single function `unrtf()`. It takes either a local 
file path or a URL to a word document:

```r
library(unrtf)
text <- unrtf("http://www-igm.univ-mlv.fr/~mac/ENS/01-projets/XMLV/pelleas/exemples/Sample.rtf")
cat(text)
```
