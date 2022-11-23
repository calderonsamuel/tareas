library(dm)
library(RMariaDB)

rep_db <- DBI::dbConnect(
  drv = RMariaDB::MariaDB(),
  user = Sys.getenv("DB_USER"),
  password = Sys.getenv("DB_SECRET"),
  dbname = Sys.getenv("DB_NAME"),
  host = Sys.getenv("DB_HOST"),
  port = Sys.getenv("DB_PORT")
)

rep_dm <- dm_from_con(rep_db)

rep_model <- rep_dm |>
  dm_add_pk(users, user_id) |>
  dm_add_pk(organisations, org_id) |>
  dm_add_pk(groups, group_id) |>
  dm_add_pk(tasks, task_id) |>
  dm_add_fk(progress, task_id, tasks) |>
  dm_add_fk(tasks, group_id, groups) |>
  # dm_add_fk(tasks, assignee, users) |>
  # dm_add_fk(tasks, assigned_by, users) |>
  dm_add_fk(groups, org_id, organisations) |>
  dm_add_fk(group_users, group_id, groups) |>
  dm_add_fk(group_users, user_id, users) |>
  dm_add_fk(org_users, org_id, organisations) |>
  dm_add_fk(org_users, user_id, users)

rep_model |>
  dm_flatten_to_tbl(tasks) |>
  head() |>
  collect() |> View()
