if (Sys.getenv("SKIP_SHINY_TESTS") == "TRUE") {
    skip("Skipping shiny test")
}

test_that("color_picker works", {
    app <- shinytest2::AppDriver$new(
        color_picker_demo(), name = "color_picker",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    # Check the initial values
    app$expect_values(export = TRUE)
    # Update output value
    app$set_inputs(`colors-select_Val1` = "#060A24")
    # Update output value
    app$set_inputs(`colors-select_Val2` = "#FF00DD")
    # Check the exported values
    app$expect_values(export = TRUE)
})

test_that("data_col_sel works", {
    app <- shinytest2::AppDriver$new(
        data_col_sel_demo(), name = "data_col_sel",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    # Check the initial values
    app$expect_values(export = TRUE)
    # Update output value
    app$set_inputs(`datafile-select_Need2` = "hp")
    # Update output value
    app$set_inputs(`datafile-select_Supl1` = "drat")
    # Check the exported values
    app$expect_values(export = TRUE)
})

test_that("data_download works", {
    app <- shinytest2::AppDriver$new(
        data_download_demo(), name = "data_download",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    # Check download
    app$expect_download("data_download-data_dwld")
})

test_that("data_import with default data", {
    app <- shinytest2::AppDriver$new(
        data_import_demo(), name = "data_import",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    # Uploaded file outside of: ./tests/testthat
    df_path <- paste0(testthat::test_path(), "/testdata/sampleped.tab")
    app$upload_file(`my_data_import-fileinput` = df_path)
    # Update output value
    app$set_inputs(`my_data_import-sep` = " ")
    # Update output value
    app$click("my_data_import-options")
    app$set_inputs(`my_data_import-heading` = FALSE)
    app$set_inputs(`my_data_import-to_char` = TRUE)
    app$set_inputs(`my_data_import-quote` = "'")
    app$click("my_data_import-close")
    app$wait_for_idle()
    # Update output value
    app$expect_values(export = TRUE)
    app$click("my_data_import-testdf")
    # Update output value
    app$wait_for_idle()
    app$expect_values(export = TRUE)
})

test_that("health_sel works", {
    app <- shinytest2::AppDriver$new(
        health_sel_demo(), name = "health_sel",
        variant = shinytest2::platform_variant()
    )
    # Check initial values
    app$set_window_size(width = 1611, height = 956)
    app$expect_values(export = TRUE)
    # Update output value
    app$set_inputs(`healthsel-health_var_sel` = "num")
    app$wait_for_idle()
    app$set_inputs(`healthsel-health_threshold_val` = 1.22)
    app$set_inputs(`healthsel-health_threshold_sup` = FALSE)
    app$expect_values(export = TRUE)
    # Update output value
    app$set_inputs(`healthsel-health_as_num` = FALSE)
    app$set_inputs(
        `healthsel-health_aff_mods_open` = TRUE,
        allow_no_input_binding_ = TRUE
    )
    app$set_inputs(`healthsel-health_aff_mods` = "2")
    app$set_inputs(
        `healthsel-health_aff_mods_open` = FALSE,
        allow_no_input_binding_ = TRUE
    )
    app$expect_values(export = TRUE)
})

test_that("inf_sel works", {
    data_env <- new.env(parent = emptyenv())
    data("sampleped")
    pedi <- shiny::reactive({
        Pedigree(sampleped[sampleped$famid == "1", ])
    })

    app <- shinytest2::AppDriver$new(
        inf_sel_demo(pedi), name = "inf_sel",
        variant = shinytest2::platform_variant()
    )

    # Update output value
    app$set_window_size(width = 1611, height = 956)
    app$expect_values(export = TRUE)
    app$wait_for_idle()

    app$set_inputs(`infsel-inf_selected` = "Af")
    # Update output value
    app$set_inputs(`infsel-kin_max` = 2)
    # Update output value
    app$set_inputs(`infsel-keep_parents` = FALSE)
    # Update output value
    app$expect_values(export = TRUE)
    app$wait_for_idle()

    app$set_inputs(`infsel-inf_selected` = "Cust")
    # Update output value
    app$set_inputs(`infsel-inf_custvar_sel` = "affected")
    app$set_inputs(`infsel-inf_custvar_val` = "TRUE")
    app$set_inputs(`infsel-keep_parents` = TRUE)
    app$wait_for_idle()
    # Update output value
    app$expect_values(export = TRUE)
})

test_that("ped_avaf_infos works", {
    app <- shinytest2::AppDriver$new(
        ped_avaf_infos_demo(), name = "ped_avaf_infos",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    app$wait_for_idle()
    app$expect_values(export = TRUE)
})

test_that("plot_download works", {
    app <- shinytest2::AppDriver$new(
        plot_download_demo(), name = "plot_download",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    # Download plot sp
    app$click("dwld_sp-download")
    app$wait_for_idle(500)
    path <- app$get_download("dwld_sp-plot_dwld")
    expect_true(file.exists(path))
    expect_equal(tools::file_ext(path), "png")
    app$click("dwld_sp-close")
    app$wait_for_idle(500)
    # Download plot ped
    app$click("dwld_ped-download")
    app$wait_for_idle(500)
    # Update output value
    app$set_inputs(`dwld_ped-width` = 1500)
    app$set_inputs(`dwld_ped-ext` = "pdf")
    path <- app$get_download("dwld_ped-plot_dwld")
    expect_true(file.exists(path))
    expect_equal(tools::file_ext(path), "pdf")
    app$click("dwld_ped-close")
    app$wait_for_idle(500)
    # Download plot ggplot
    app$click("dwld_ggplot-download")
    app$wait_for_idle(500)
    app$set_inputs(`dwld_ggplot-ext` = "html")
    path <- app$get_download("dwld_ggplot-plot_dwld")
    expect_true(file.exists(path))
    expect_equal(tools::file_ext(path), "html")
    app$click("dwld_ggplot-close")
})

test_that("plot_ped works", {
    pedi <- shiny::reactive({
        data_env <- new.env(parent = emptyenv())
        data("sampleped", envir = data_env)
        Pedigree(data_env[["sampleped"]])
    })
    app <- shinytest2::AppDriver$new(
        plot_ped_demo(
            pedi = pedi,
            precision = 4,
            tips = c("id", "momid", "num")
        ), name = "plotped",
        variant = shinytest2::platform_variant()
    )
    app$set_window_size(width = 1611, height = 956)
    app$set_inputs(`plotped-interactive` = TRUE)
    app$wait_for_idle()
    app$click("saveped-download")
    app$wait_for_idle()
    app$set_inputs(`saveped-ext` = "html")
    app$wait_for_idle()
    path <- app$get_download("saveped-plot_dwld")
    app$wait_for_idle()
    expect_true(file.exists(path))
    expect_equal(tools::file_ext(path), "html")
    app$click("saveped-close")
})
