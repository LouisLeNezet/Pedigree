#' Create the server logic for the ped_shiny application
#' @include app_health_sel.R
#' @include app_family_sel.R
#' @include app_inf_sel.R
#' @include app_ped_avaf_infos.R
#' @include app_plot_ped.R
#' @include app_data_import.R
#' @include app_data_col_sel.R
#' @include app_data_download.R
#' @include app_utils.R
#' @include app_plot_download.R
#' @include app_plot_legend.R
#' @importFrom utils data
#' @importFrom shiny shinyServer req observeEvent reactive stopApp
#' @importFrom shiny exportTestValues stopApp
#' @importFrom shinytoastr toastr_warning toastr_error
#' @param input The input object from a Shiny app.
#' @param output The output object from a Shiny app.
#' @param session The session object from a Shiny app.
#' @param precision Number of decimal for the position of the boxes
#' in the plot.
#' @returns `shiny::shinyServer()`
#' @examples
#' if (interactive()) {
#'     ped_shiny()
#' }
#' @keywords internal
ped_server <- function(
    input, output, session, precision = 6
) {
    shiny::shinyServer(function(input, output, session) {

        height_family_infos <- "auto"

        data_env <- new.env(parent = emptyenv())
        utils::data("sampleped", envir = data_env, package = "Pedixplorer")
        utils::data("relped", envir = data_env, package = "Pedixplorer")

        ## Ped data import ----------------------------------------------------
        ped_df <- data_import_server(
            id = "data_ped_import",
            label = "Select pedigree file :",
            dftest = data_env[["sampleped"]]
        )
        ped_df_rename <- data_col_sel_server(
            "data_ped_col_sel", ped_df,
            list(
                "id" = list(alternate = c("indid"), mandatory = TRUE),
                "dadid" = list(alternate = c("fatherid"), mandatory = TRUE),
                "momid" = list(alternate = c("motherid"), mandatory = TRUE),
                "sex" = list(alternate = c("gender"), mandatory = TRUE),
                "famid" = list(alternate = c("family"), mandatory = FALSE),
                "fertility" = list(
                    alternate = c("steril", "sterilization"), mandatory = FALSE
                ),
                "miscarriage" = list(
                    alternate = c("aborted"), mandatory = FALSE
                ),
                "deceased" = list(
                    alternate = c("status", "vitalstatus", "death"),
                    mandatory = FALSE
                ),
                "avail" = list(alternate = c("available"), mandatory = FALSE),
                "evaluated" = list(alternate = c("eval"), mandatory = FALSE),
                "consultand" = list(
                    alternate = c(NA_character_), mandatory = FALSE
                ),
                "proband" = list(
                    alternate = c(NA_character_), mandatory = FALSE
                ),
                "carrier" = list(
                    alternate = c(NA_character_), mandatory = FALSE
                ),
                "asymptomatic" = list(
                    alternate = c("presymptomatic"), mandatory = FALSE
                ),
                "adopted" = list(alternate = c("adoption"), mandatory = FALSE),
                "dateofbirth" = list(
                    alternate = c("dob", "birth"), mandatory = FALSE
                ),
                "dateofdeath" = list(
                    alternate = c("dod"), mandatory = FALSE
                )
            ),
            title = "Select columns :", na_omit = TRUE,
            ui_col_nb = 3, by_row = FALSE
        )
        ## Rel data import ----------------------------------------------------
        rel_df <- data_import_server(
            id = "data_rel_import",
            label = "Select relationship file :",
            dftest = data_env[["relped"]]
        )
        rel_df_rename <- data_col_sel_server(
            "data_rel_col_sel", rel_df,
            list(
                "id1" = list(alternate = c("indId1"), mandatory = TRUE),
                "id2" = list(alternate = c("indId2"), mandatory = TRUE),
                "code" = list(alternate = c(NA_character_), mandatory = TRUE),
                "famid" = list(alternate = c("family"), mandatory = FALSE)
            ),
            "Select columns :", na_omit = TRUE, ui_col_nb = 1, by_row = FALSE
        )

        ## Ped families object creation ---------------------------------------
        ped_df_norm <- shiny::reactive({
            shiny::req(ped_df_rename())
            if (is.null(ped_df_rename())) {
                return(NULL)
            }
            ped_df <- ped_df_rename()
            if (!"famid" %in% colnames(ped_df_rename())) {
                ped_df$famid <- make_famid(
                    as.character(ped_df$id),
                    as.character(ped_df$dadid),
                    as.character(ped_df$momid)
                )
            }
            withCallingHandlers({
                norm_ped(
                    ped_df, cols_used_del = TRUE, na_strings = c(NA, "0", 0)
                )
            }, warning = function(w) {
                shinytoastr::toastr_warning(
                    title = "Warnings during pedigree normalization",
                    conditionMessage(w)
                )
                invokeRestart("muffleWarning")
            })
        })
        rel_df_norm <- shiny::reactive({
            if (is.null(rel_df_rename())) {
                return(NULL)
            }
            norm_rel(rel_df_rename())
        })

        ped_all <- shiny::reactive({
            shiny::req(ped_df_norm())
            ped_df <- ped_df_norm()
            if (any(!is.na(ped_df_norm()$error))) {
                shinytoastr::toastr_warning(
                    title = "Errors are present in the data given.",
                    paste(
                        "Please check the data and try again.",
                        "Only the data without errors will be used."
                    )
                )
                ped_df <- ped_df_norm()[is.na(ped_df_norm()$error), ]
            }
            tryCatch({
                withCallingHandlers({
                    ped_df <- fix_parents(ped_df)
                    Pedigree(
                        ped_df, rel_df_norm(),
                        cols_ren_ped = list(),
                        cols_ren_rel = list(),
                        normalize = FALSE
                    )
                }, warning = function(w) {
                    shinytoastr::toastr_warning(
                        title = "Warnings during pedigree creation",
                        conditionMessage(w)
                    )
                    invokeRestart("muffleWarning")
                })
            }, error = function(e) {
                shinytoastr::toastr_error(
                    title = "Couldn't create pedigree object",
                    conditionMessage(e)
                )
                NULL
            })
        })

        ## Errors download ----------------------------------------------------
        shiny::observeEvent(ped_df_norm(), {
            data_download_server("ped_norm_errors",
                shiny::reactive({
                    ped_df_norm()[!is.na(ped_df_norm()$error), ]
                }), "Pedigree data errors", title = "Pedigree data errors"
            )
        })

        shiny::observeEvent(rel_df_norm(), {
            data_download_server("rel_norm_errors",
                shiny::reactive({
                    rel_df_norm()[!is.na(rel_df_norm()$error), ]
                }), "Relationship data errors",
                title = "Relationship data errors"
            )
        })
        output$ped_errors <- renderUI({
            shiny::req(ped_df_norm()[!is.na(ped_df_norm()$error), ])
            data_download_ui(id = "ped_norm_errors")
        })
        output$rel_errors <- renderUI({
            shiny::req(rel_df_norm()[!is.na(rel_df_norm()$error), ])
            data_download_ui(id = "rel_norm_errors")
        })

        output$download_errors <- renderUI({
            shiny::req(ped_df_norm())
            if (nrow(ped_df_norm()[!is.na(ped_df_norm()$error), ]) == 0) {
                if (is.null(rel_df_norm())) {
                    return(NULL)
                } else if (
                    nrow(rel_df_norm()[!is.na(rel_df_norm()$error), ]) == 0
                ) {
                    return(NULL)
                }
            }
            fluidRow(
                h3("Download errors"),
                column(6, align = "center",
                    uiOutput("ped_errors")
                ),
                column(6, align = "center",
                    uiOutput("rel_errors")
                )
            )
        })

        ## Health selection ---------------------------------------------------
        lst_health <- health_sel_server(
            "health_sel", ped_all, var = "affection"
        )

        ## Generate colors creation -------------------------------------------
        output$health_full_scale_box <- renderUI({
            checkboxInput(
                "health_full_scale",
                label = "Full scale color",
                value = FALSE
            )
        })

        cols_aff <- color_picker_server("col_aff",
            list(
                "LeastAffected" = "#ecbd00",
                "Affected" = "#c40000"
            )
        )

        cols_unaff <- color_picker_server("col_unaff",
            list(
                "Unaffected" = "white",
                "Dubious" = "#3792ad"
            )
        )

        cols_avail <- color_picker_server("col_avail",
            list("Avail" = "#8aca25", "Unavail" = "black")
        )

        ## Families selection -------------------------------------------------
        lst_fam <- family_sel_server(
            "family_sel", ped_all, "family", 1
        )

        ## Pedigree affected --------------------------------------------------
        ped_aff <- shiny::reactive({
            shiny::req(lst_fam())
            shiny::req(lst_health())
            if (is.null(lst_fam()) |
                    is.null(lst_health()) |
                    is.null(input$health_full_scale)
            ) {
                return(NULL)
            }
            if (lst_health()$as_num &
                    is.null(lst_health()$threshold)
            ) {
                return(NULL)
            }
            tryCatch({
                withCallingHandlers({
                    generate_colors(
                        lst_fam()$ped_fam, col_aff = lst_health()$var,
                        add_to_scale = FALSE, mods_aff = lst_health()$mods_aff,
                        threshold = lst_health()$threshold,
                        is_num = lst_health()$as_num,
                        sup_thres_aff = lst_health()$sup_threshold,
                        keep_full_scale = input$health_full_scale,
                        colors_aff = unname(unlist(
                            cols_aff()[c("LeastAffected", "Affected")]
                        )),
                        colors_unaff = unname(unlist(
                            cols_unaff()[c("Unaffected", "Dubious")]
                        )),
                        colors_na = "grey",
                        colors_avail = unname(unlist(
                            cols_avail()[c("Avail", "Unavail")]
                        )),
                        breaks = 3
                    )
                }, warning = function(w) {
                    shinytoastr::toastr_warning(
                        title = "Warnings during pedigree normalization",
                        conditionMessage(w)
                    )
                    invokeRestart("muffleWarning")
                })
            }, error = function(e) {
                shinytoastr::toastr_error(
                    title = "Error during pedigree generation",
                    conditionMessage(e)
                )
                NULL
            })
        })

        ## Family information -------------------------------------------------
        ped_avaf_infos_server(
            "ped_avaf_infos", pedi = ped_aff,
            title = "Family informations",
            height = height_family_infos
        )

        ## Informative selection ----------------------------------------------
        lst_inf <- inf_sel_server("inf_sel", ped_all)

        ## Subfamily selection ------------------------------------------------
        ped_subfamilies <- shiny::reactive({
            shiny::req(lst_inf())
            shiny::req(ped_aff())
            pedi_inf <- is_informative(
                ped_aff(),
                informative = lst_inf()$inf_sel,
                col_aff = lst_health()$var
            )
            pedi_inf <- useful_inds(
                pedi_inf, keep_infos = lst_inf()$keep_parents,
                max_dist = lst_inf()$kin_max, reset = TRUE
            )
            pedi_inf <- Pedixplorer::subset(
                pedi_inf, useful(ped(pedi_inf)),
                del_parents = "both"
            )
            make_famid(pedi_inf)
        })

        lst_subfam <- family_sel_server(
            "subfamily_sel", ped_subfamilies,
            fam_var = "family", fam_sel = 1, title = "Subfamily selection"
        )

        ped_subfam <- shiny::reactive({
            shiny::req(lst_subfam())
            if (is.null(lst_subfam())) {
                return(NULL)
            }
            lst_subfam()$ped_fam
        })

        ## Sub Family information ---------------------------------------------
        ped_avaf_infos_server(
            "subped_avaf_infos", pedi = ped_subfam,
            title = "Subfamily informations",
            height = height_family_infos
        )

        ## Plotting pedigree --------------------------------------------------
        cust_title <- function(short) {
            shiny::reactive({
                shiny::req(lst_fam())
                shiny::req(lst_subfam())
                shiny::req(lst_inf())
                get_title(
                    family_sel = lst_fam()$famid,
                    subfamily_sel = lst_subfam()$famid,
                    inf_selected = lst_inf()$inf_sel,
                    kin_max = lst_inf()$kin_max,
                    keep_parents = lst_inf()$keep_parents,
                    nb_rows = length(lst_subfam()$ped_fam), short_title = short
                )
            })
        }

        ### Tips column selection --------------------------------------------
        output$col_sel_tips <- renderUI({
            shiny::req(ped_subfam())
            all_cols <- colnames(Pedixplorer::as.data.frame(ped(ped_subfam())))
            select <- c("affected", "avail", "status")
            select <- select[select %in% all_cols]
            shiny::selectInput(
                "tips_col",
                label = "Select columns for tips",
                choices = all_cols, selected = select,
                multiple = TRUE
            )
        })

        my_tips <- shiny::reactive({
            input$tips_col
        })

        plot_ped <- plot_ped_server(
            "ped", ped_subfam,
            cust_title(short = FALSE),
            precision = precision, lwd = 2,
            tips = my_tips
        )

        plot_legend_server(
            "legend", ped_subfam,
            boxw = 0.02, boxh = 0.08, adjx = 0, adjy = 0,
            leg_loc = c(0.1, 0.7, 0.1, 0.8), lwd = 1.5
        )

        ## Download data and plot ---------------------------------------------
        plot_download_server(
            "saveped",
            plot_ped, label = "Download plot",
            cust_title(short = TRUE)
        )
        data_subfam <- shiny::reactive({
            shiny::req(ped_subfam())
            if (is.null(ped_subfam())) {
                return(NULL)
            } else {
                Pedixplorer::as.data.frame(ped(ped_subfam()))
            }
        })
        data_download_server("plot_data_dwnl",
            data_subfam, label = "Download data",
            filename = cust_title(short = TRUE),
            helper = FALSE, title = NULL
        )
        ## Test exported values -----------------------------------------------
        shiny::exportTestValues(
            df = data_subfam()
        )


        ## End ----------------------------------------------------------------
        if (!interactive()) {
            session$onSessionEnded(function() {
                shiny::stopApp()
                q("no")
            })
        }
    })
}
