#' Sketch of the family information table
#'
#' Simple function to create a sketch of the family information table.
#'
#' @param var_name the name of the health variable
#' @return An html sketch of the family information table
#' @keywords internal
#' @keywords ped_avaf_infos
#' @importFrom shiny tags HTML
sketch_family_table <- function(var_name) {
    shiny::tags$table(
        class = "display",
        shiny::tags$style(shiny::HTML(
            ".cell-border-right{border-right: 1px solid #000}"
        )), shiny::tags$thead(
            shiny::tags$tr(
                shiny::tags$th(
                    class = "dt-center cell-border-right",
                    colspan = 2, var_name
                ),
                shiny::tags$th(
                    class = "dt-center",
                    colspan = 3, "Availability"
                )
            ),
            shiny::tags$tr(
                shiny::tags$th("Affected"),
                shiny::tags$th("Modalities"),
                shiny::tags$th("Available"),
                shiny::tags$th("Unavailable"),
                shiny::tags$th("NA")
            )
        )
    )
}


#' Affection and availability information table
#'
#' This function creates a table with the affection and availability
#' information for all individuals in a pedigree object.
#'
#' @param pedi A pedigree object.
#' @param col_val The column name in the `fill` slot
#' of the pedigree object to use for the table.
#' @return A cross table dataframe with the affection and availability
#' information.
#' @examples
#' data(sampleped)
#' pedi <- Pedigree(sampleped)
#' pedi <- generate_colors(pedi, "num_child_tot", threshold = 2)
#' Pedixplorer:::family_infos_table(pedi, "num_child_tot")
#' Pedixplorer:::family_infos_table(pedi, "affection")
#' @keywords ped_avaf_infos
#' @importFrom tidyr spread
family_infos_table <- function(pedi, col_val = NA) {
    if (!col_val %in% fill(pedi)$column_values) {
        error <- paste(
            "The column value", col_val,
            "is not in the available column values"
        )
        stop(error)
    }
    aff <- fill(pedi)[fill(pedi)$column_values == col_val, ]
    df <- base::table(
        factor(avail(ped(pedi)), c(TRUE, FALSE)),
        mcols(pedi)[[unique(aff$column_mods)]],
        useNA = "always",
        dnn = c("Availability", "Affected")
    ) %>%
        as.data.frame() %>%
        tidyr::spread("Availability", "Freq")
    colnames(df) <- c("Affected", "TRUE", "FALSE", "NA")
    df$mods <- aff$labels[match(
        df$Affected, aff$mods
    )]
    df$Affected <- as.character(df$Affected)
    cols <- c("Affected", "mods", "TRUE", "FALSE", "NA")
    df[cols] <- lapply(df[cols],
        function(x) {
            x <- replace(x, is.na(x), "NA")
        }
    )
    return(df[cols])
}


#' @rdname ped_avaf_infos
#' @importFrom shiny NS column uiOutput textOutput
#' @importFrom DT dataTableOutput
ped_avaf_infos_ui <- function(id) {
    ns <- shiny::NS(id)
    shiny::column(12,
        shiny::uiOutput(ns("title_infos")),
        shiny::textOutput(ns("ped_avaf_infos_title")),
        shiny::uiOutput(ns("family_info_table_ui"))
    )
}

#' Shiny modules to display family information
#'
#' This module allows to display the health and availability data
#' for all individuals in a pedigree object.
#' The output is a datatable.
#' The function is composed of two parts: the UI and the server.
#' The UI is called with the function `ped_avaf_infos_ui()` and the server
#' with the function `ped_avaf_infos_server()`.
#'
#' @param id A string to identify the module.
#' @param pedi A reactive pedigree object.
#' @param title The title of the module.
#' @param height The height of the datatable.
#' @return A reactive dataframe with the selected columns renamed
#' to the names of cols_needed and cols_supl.
#' @examples
#' if (interactive()) {
#'     ped_avaf_infos_demo()
#' }
#' @include app_utils.R
#' @rdname ped_avaf_infos
#' @keywords internal
#' @importFrom shiny is.reactive moduleServer reactive req renderText
#' @importFrom shiny renderUI h3
#' @importFrom DT renderDataTable datatable
#' @importFrom stringr str_to_title
ped_avaf_infos_server <- function(
    id, pedi, title = "Family informations", height = "auto"
) {
    stopifnot(shiny::is.reactive(pedi))
    shiny::moduleServer(id, function(input, output, session) {
        ns <- shiny::NS(id)
        # Create the title ----------------------------------------------------
        output$title_infos <- shiny::renderUI({
            shiny::h3(title)
        })

        col_var <- shiny::reactive({
            shiny::req(pedi())
            unique(fill(pedi())$column_values)
        })

        df_infos <- shiny::reactive({
            shiny::req(pedi())
            shiny::req(col_var())
            family_infos_table(pedi(), col_var()[1])
        })

        output$family_info_table_ui <- shiny::renderUI({
            DT::dataTableOutput(ns("family_info_table_dt"), height = height)
        })

        # Display the family information table --------------------------------
        output$family_info_table_dt <- DT::renderDataTable({
            shiny::req(df_infos())
            DT::datatable(
                df_infos(),
                container = sketch_family_table(stringr::str_to_title(
                    col_var()[1]
                )), rownames = FALSE, selection = "none",
                options = list(
                    columnDefs = list(
                        list(
                            targets = 1,
                            className = "cell-border-right"
                        ),
                        list(
                            targets = "_all",
                            className = "dt-center"
                        )
                    ), dom = "t"
                ),
                fillContainer = TRUE
            )
        })
        # Display the title ---------------------------------------------------
        output$ped_avaf_infos_title <- shiny::renderText({
            shiny::req(pedi())
            if (!is.null(pedi())) {
                paste(
                    "Health & Availability data representation for family",
                    unique(famid(ped(pedi())))
                )
            } else {
                NULL
            }
        })

        df_infos
    })
}

#' @rdname ped_avaf_infos
#' @export
#' @importFrom utils data
#' @importFrom shiny fluidPage reactive exportTestValues shinyApp
ped_avaf_infos_demo <- function(height = "auto") {
    data_env <- new.env(parent = emptyenv())
    utils::data("sampleped", envir = data_env, package = "Pedixplorer")
    pedi <- Pedigree(
        data_env[["sampleped"]][data_env[["sampleped"]]$famid == "1", ]
    )
    ui <- shiny::fluidPage(
        ped_avaf_infos_ui("familysel")
    )
    server <- function(input, output, session) {
        df <- ped_avaf_infos_server(
            "familysel",
            shiny::reactive({
                pedi
            }),
            height = height
        )
        shiny::exportTestValues(df = {
            df()
        })
    }
    shiny::shinyApp(ui, server)
}
