render_reporte_group_user <- function(date_max = as.character(Sys.Date()), 
                                      group_id = Sys.getenv("TAREAS_GROUP_ID"), 
                                      user_id = Sys.getenv("TAREAS_USER_ID"),
                                      output_format = "docx",
                                      output_file = NULL) {
  # cli::cli_alert_info("Rendering for user {user_id}")
  
  render_params <- list(
    input = "reporte_group_user.qmd", 
    output_format = output_format,
    output_file = output_file,
    quiet = TRUE,
    execute_params = list(
      date_max = date_max,
      group_id = group_id,
      user_id = user_id
    )
  ) |> purrr::discard(is.null)
  
  do.call(quarto::quarto_render, args = render_params)
}
