# Evaluate par()

    Code
      par()
    Output
      $xlog
      [1] FALSE
      
      $ylog
      [1] FALSE
      
      $adj
      [1] 0.5
      
      $ann
      [1] TRUE
      
      $ask
      [1] FALSE
      
      $bg
      [1] "transparent"
      
      $bty
      [1] "o"
      
      $cex
      [1] 1
      
      $cex.axis
      [1] 1
      
      $cex.lab
      [1] 1
      
      $cex.main
      [1] 1.2
      
      $cex.sub
      [1] 1
      
      $cin
      [1] 0.15 0.20
      
      $col
      [1] "black"
      
      $col.axis
      [1] "black"
      
      $col.lab
      [1] "black"
      
      $col.main
      [1] "black"
      
      $col.sub
      [1] "black"
      
      $cra
      [1] 10.8 14.4
      
      $crt
      [1] 0
      
      $csi
      [1] 0.2
      
      $cxy
      [1] 0.02604 0.03876
      
      $din
      [1] 7 7
      
      $err
      [1] 0
      
      $family
      [1] ""
      
      $fg
      [1] "black"
      
      $fig
      [1] 0 1 0 1
      
      $fin
      [1] 7 7
      
      $font
      [1] 1
      
      $font.axis
      [1] 1
      
      $font.lab
      [1] 1
      
      $font.main
      [1] 2
      
      $font.sub
      [1] 1
      
      $lab
      [1] 5 5 7
      
      $las
      [1] 0
      
      $lend
      [1] "round"
      
      $lheight
      [1] 1
      
      $ljoin
      [1] "round"
      
      $lmitre
      [1] 10
      
      $lty
      [1] "solid"
      
      $lwd
      [1] 1
      
      $mai
      [1] 1.02 0.82 0.82 0.42
      
      $mar
      [1] 5.1 4.1 4.1 2.1
      
      $mex
      [1] 1
      
      $mfcol
      [1] 1 1
      
      $mfg
      [1] 1 1 1 1
      
      $mfrow
      [1] 1 1
      
      $mgp
      [1] 3 1 0
      
      $mkh
      [1] 0.001
      
      $new
      [1] FALSE
      
      $oma
      [1] 0 0 0 0
      
      $omd
      [1] 0 1 0 1
      
      $omi
      [1] 0 0 0 0
      
      $page
      [1] TRUE
      
      $pch
      [1] 1
      
      $pin
      [1] 5.76 5.16
      
      $plt
      [1] 0.1171 0.9400 0.1457 0.8829
      
      $ps
      [1] 12
      
      $pty
      [1] "m"
      
      $smo
      [1] 1
      
      $srt
      [1] 0
      
      $tck
      [1] NA
      
      $tcl
      [1] -0.5
      
      $usr
      [1] 0 1 0 1
      
      $xaxp
      [1] 0 1 5
      
      $xaxs
      [1] "r"
      
      $xaxt
      [1] "s"
      
      $xpd
      [1] FALSE
      
      $yaxp
      [1] 0 1 5
      
      $yaxs
      [1] "r"
      
      $yaxt
      [1] "s"
      
      $ylbias
      [1] 0.2
      

# Evaluate options()

    Code
      opts
    Output
      $CBoundsCheck
      [1] FALSE
      
      $OutDec
      [1] "."
      
      $PCRE_limit_recursion
      [1] NA
      
      $PCRE_study
      [1] FALSE
      
      $PCRE_use_JIT
      [1] TRUE
      
      $`R.methodsS3:useSearchPath`
      [1] TRUE
      
      $add.smooth
      [1] TRUE
      
      $ambiguousMethodSelection
      function (cond) 
      NULL
      <environment: R_EmptyEnv>
      
      $catch.script.errors
      [1] FALSE
      
      $check.bounds
      [1] FALSE
      
      $chromote.verbose
      [1] TRUE
      
      $citation.bibtex.max
      [1] 1
      
      $cli.condition_width
      [1] Inf
      
      $cli.dynamic
      [1] FALSE
      
      $cli.hyperlink
      [1] FALSE
      
      $cli.hyperlink_help
      [1] FALSE
      
      $cli.hyperlink_run
      [1] FALSE
      
      $cli.hyperlink_vignette
      [1] FALSE
      
      $cli.num_colors
      [1] 1
      
      $cli.unicode
      [1] FALSE
      
      $cli.width
      [1] 80
      
      $continue
      [1] "+ "
      
      $contrasts
              unordered           ordered 
      "contr.treatment"      "contr.poly" 
      
      $crayon.enabled
      [1] FALSE
      
      $defaultPackages
      [1] "datasets"  "utils"     "grDevices" "graphics"  "stats"     "methods"  
      
      $demo.ask
      [1] "default"
      
      $deparse.cutoff
      [1] 60
      
      $devOptions
      $devOptions$`*`
      $devOptions$`*`$sep
      [1] ","
      
      $devOptions$`*`$path
      [1] "figures"
      
      $devOptions$`*`$force
      [1] TRUE
      
      
      
      $digits
      [1] 4
      
      $dplyr.show_progress
      [1] TRUE
      
      $echo
      [1] TRUE
      
      $encoding
      [1] "native.enc"
      
      $error
      (function (cnd, ..., top = NULL, bottom = NULL) 
      {
          check_dots_empty0(...)
          if (!missing(cnd) && inherits(cnd, "rlang_error")) {
              poke_last_error(cnd)
              return()
          }
          if (is_null(bottom)) {
              if (missing(cnd)) {
                  bottom <- current_env()
              }
              else {
                  bottom <- caller_env()
              }
          }
          if (is_environment(bottom)) {
              nframe <- eval_bare(quote(base::sys.nframe()), bottom) - 
                  1
              info <- signal_context_info(nframe)
              bottom <- sys.frame(info[[2]])
          }
          if (!has_new_cmd_frame() && the$n_conditions >= max_entracing()) {
              trace <- NULL
          }
          else {
              trace <- trace_back(top = top, bottom = bottom)
          }
          if (missing(cnd)) {
              return(entrace_handle_top(trace))
          }
          if (is_warning(cnd)) {
              wrn <- as_rlang_warning(cnd, trace)
              push_warning(wrn)
              if (!is_null(findRestart("muffleWarning"))) {
                  if (identical(peek_option("warn"), 2L)) {
                      return()
                  }
                  else {
                      warning(wrn)
                      invokeRestart("muffleWarning")
                  }
              }
              else {
                  return()
              }
          }
          if (is_message(cnd)) {
              push_message(as_rlang_message(cnd, trace))
              return()
          }
          if (is_error(cnd)) {
              if (has_recover()) {
                  return()
              }
              entraced <- error_cnd(message = conditionMessage(cnd) %||% 
                  "", call = conditionCall(cnd), error = cnd, trace = trace, 
                  use_cli_format = FALSE)
              poke_last_error(entraced)
              cnd_signal(entraced)
          }
          NULL
      })()
      
      $example.ask
      [1] "default"
      
      $expressions
      [1] 5000
      
      $help.search.types
      [1] "vignette" "demo"     "help"    
      
      $help.try.all.packages
      [1] FALSE
      
      $httr_oauth_cache
      [1] NA
      
      $httr_oob_default
      [1] FALSE
      
      $internet.info
      [1] 2
      
      $keep.parse.data
      [1] TRUE
      
      $keep.parse.data.pkgs
      [1] FALSE
      
      $keep.source
      [1] TRUE
      
      $keep.source.pkgs
      [1] FALSE
      
      $lifecycle_verbosity
      [1] "warning"
      
      $locatorBell
      [1] TRUE
      
      $mailer
      [1] "mailto"
      
      $matprod
      [1] "default"
      
      $max.contour.segments
      [1] 25000
      
      $max.print
      [1] 99999
      
      $menu.graphics
      [1] TRUE
      
      $na.action
      [1] "na.omit"
      
      $nwarnings
      [1] 50
      
      $pager
      [1] "internal"
      
      $papersize
      [1] "a4"
      
      $pkgType
      [1] "source"
      
      $prompt
      [1] "> "
      
      $repos
          CRAN 
      "@CRAN@" 
      
      $rlang_backtrace_on_error_report
      [1] "full"
      
      $rlang_backtrace_on_warning_report
      [1] "full"
      
      $rlang_interactive
      [1] FALSE
      
      $scipen
      [1] 0
      
      $shiny.fullstacktrace
      [1] TRUE
      
      $shiny.port
      [1] 3929
      
      $shiny.testmode
      [1] TRUE
      
      $shinytest2.load_timeout
      [1] 120000
      
      $show.coef.Pvalues
      [1] TRUE
      
      $show.error.messages
      [1] TRUE
      
      $show.signif.stars
      [1] TRUE
      
      $showErrorCalls
      [1] TRUE
      
      $showNCalls
      [1] 50
      
      $showWarnCalls
      [1] FALSE
      
      $str
      $str$strict.width
      [1] "no"
      
      $str$digits.d
      [1] 3
      
      $str$vec.len
      [1] 4
      
      $str$list.len
      [1] 99
      
      $str$deparse.lines
      NULL
      
      $str$drop.deparse.attr
      [1] TRUE
      
      $str$formatNum
      [1] NA
      
      
      $str.dendrogram.last
      [1] "`"
      
      $testthat_path
      [1] "test-parameters.R"
      
      $timeout
      [1] 600
      
      $ts.S.compat
      [1] FALSE
      
      $ts.eps
      [1] 1e-05
      
      $unzip
      [1] "internal"
      
      $useFancyQuotes
      [1] FALSE
      
      $verbose
      [1] FALSE
      
      $warn
      [1] 0
      
      $warnPartialMatchArgs
      [1] FALSE
      
      $warnPartialMatchAttr
      [1] FALSE
      
      $warnPartialMatchDollar
      [1] FALSE
      
      $warning.length
      [1] 1000
      
      $width
      [1] 80
      

