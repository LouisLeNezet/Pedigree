# This file is part of the standard setup for testthat.
# It is recommended that you do not modify it.
#
# Where should you do additional test configuration?
# Learn more about the roles of various files in:
# * https://r-pkgs.org/tests.html
# * https://testthat.r-lib.org/reference/test_package.html#special-files

## Beware when testing with shinytest2
## the package version used will be the one avalailable through
## `library(Pedixplorer)` as an independant R session is launched
## To do so you need to `unload("Pedixplorer")`, `build()`
## and `install("../Pedixplorer*.tar.gz")` the package before running the tests

library(Pedixplorer)
library(shinytest2)
library(R.devices)
library(rlang)

## Set up the environment

Sys.setenv(
    CHROMOTE_CHROME = Sys.getenv("CHROMOTE_CHROME"),
    CHROMOTE_HEADLESS = Sys.getenv("CHROMOTE_HEADLESS"),
    SKIP_SHINY_TESTS = Sys.getenv("SKIP_SHINY_TESTS"),
    CHROMOTE_ARGS = Sys.getenv("CHROMOTE_ARGS"),
    R_TESTS = ""
)

print(Sys.getenv("CHROMOTE_CHROME"))

## Clean up any open devices
all_dev <- dev.list()
for (devi in all_dev) {
    dev.off(devi)
}

## Set up the plotting device
par_lst <- list(
    "pin" = c(8, 8), "cex" = 1,
    "fin" = c(6, 6), "bg" = "white", "family" = "HersheySans",
    "usr" = c(0, 1, 0, 1), "xaxp" = c(0, 1, 5), "yaxp" = c(0, 1, 5),
    "fig" = c(0, 1, 0, 1), "mar" = rep(1, 4), "xpd" = TRUE,
    "lwd" = 1, "oma" = rep(1, 4)
)

op <- par(par_lst)

R.devices::devNew("pdf", width = 10, height = 10, par = par_lst)

## Set up the environment
options(
    shiny.testmode = TRUE,
    shinytest2.load_timeout = 120000,
    shiny.fullstacktrace = TRUE,
    shiny.port = 3929,
    chromote.verbose = TRUE,
    digits = 4, width = 150,
    browser = Sys.getenv("CHROMOTE_CHROME"),
    keep.source = TRUE,
    pager = "internal",
    papersize = "a4",
    pkgType = "source",
    showErrorCalls = TRUE,
    timeout = 600,
    unzip = "internal",
    error = rlang::entrace,
    rlang_backtrace_on_error_report = "full",
    rlang_backtrace_on_warning_report = "full"
)

## Run the tests
test_check("Pedixplorer")

dev.off()
par(op)
