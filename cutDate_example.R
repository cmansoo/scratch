# example data, obtained using dput()
df <- structure(
  list(
    record_id = c(1L, 1L, 2L, 2L, 3L, 3L, 3L, 3L, 
                  3L, 3L, 3L, 3L, 3L, 3L, 3L, 4L, 4L, 5L, 5L, 6L, 6L, 6L, 6L, 6L, 
                  6L, 6L, 6L, 7L, 7L, 7L, 7L, 7L, 7L, 7L, 7L, 7L, 7L, 7L, 8L, 8L, 
                  8L, 8L, 8L, 8L, 8L, 8L, 8L, 8L, 9L, 9L, 9L, 9L, 10L, 10L, 10L, 
                  10L, 10L, 10L, 11L, 11L, 12L, 13L, 14L, 14L, 15L, 15L, 16L, 16L, 
                  17L, 17L, 17L, 17L, 17L, 17L, 17L, 17L, 17L, 17L, 17L, 18L, 18L, 
                  18L, 18L, 18L, 18L, 18L, 18L, 18L, 18L, 18L, 19L, 19L, 19L, 19L, 
                  19L, 19L, 19L, 19L, 19L, 19L, 19L, 20L, 20L, 20L, 20L, 20L, 20L, 
                  20L, 20L, 20L, 21L, 21L, 21L, 21L, 21L, 21L, 21L, 21L, 21L, 21L, 
                  21L, 22L, 22L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 23L, 
                  23L, 24L, 24L, 25L, 25L, 26L, 26L, 26L, 26L, 26L, 26L, 26L, 26L, 
                  26L, 26L, 26L, 27L, 27L, 27L, 27L, 27L, 27L, 27L, 27L, 27L, 27L, 
                  27L, 33L, 34L, 34L, 34L, 34L, 34L, 34L, 34L, 34L, 34L, 34L, 34L, 
                  35L, 35L, 35L, 35L, 35L, 35L, 35L, 35L, 35L, 35L, 35L, 36L, 36L, 
                  36L, 36L, 36L, 36L, 36L, 36L, 36L, 36L, 36L, 37L, 37L, 38L, 38L, 
                  38L, 38L, 38L, 38L, 38L, 38L, 38L, 38L, 38L, 39L, 39L, 39L, 39L, 
                  39L, 39L, 39L, 39L, 39L, 39L, 39L, 40L, 40L, 40L, 40L, 41L, 41L, 
                  41L, 41L, 41L, 41L, 41L, 41L, 41L, 41L, 41L, 42L, 42L, 43L, 43L, 
                  43L, 43L, 43L, 43L, 43L, 43L, 43L, 43L, 43L), 
    survey_timestamp_2 = c(NA, 
                           NA, NA, NA, NA, "9/22/2022 15:23", "9/26/2022 17:29", "10/4/2022 18:25", 
                           "10/10/2022 21:19", "10/17/2022 19:00", "10/24/2022 15:16", "10/31/2022 20:21", 
                           "11/7/2022 17:08", "11/15/2022 1:20", "11/21/2022 17:31", NA, 
                           NA, NA, NA, NA, "9/19/2022 18:15", "9/26/2022 17:40", "10/3/2022 21:17", 
                           "10/10/2022 16:23", "11/11/2022 22:31", "11/15/2022 12:52", NA, 
                           NA, "9/20/2022 15:37", "9/26/2022 21:03", "10/3/2022 21:18", 
                           "10/10/2022 17:45", "10/17/2022 21:04", "10/24/2022 20:49", "11/1/2022 2:29", 
                           "11/7/2022 18:09", "11/14/2022 18:32", "11/21/2022 17:37", NA, 
                           "10/4/2022 20:58", "10/18/2022 12:19", "10/18/2022 12:19", "10/18/2022 12:20", 
                           "11/12/2022 13:36", "11/12/2022 13:36", "11/12/2022 13:36", "11/12/2022 13:37", 
                           NA, NA, "9/20/2022 15:20", "10/28/2022 12:15", NA, NA, "9/28/2022 18:38", 
                           "10/6/2022 15:09", "10/14/2022 8:01", "10/14/2022 8:01", NA, 
                           NA, NA, NA, NA, NA, NA, NA, NA, NA, "9/20/2022 15:24", NA, "9/22/2022 15:19", 
                           "9/28/2022 11:14", "10/10/2022 16:33", "10/12/2022 16:46", "10/17/2022 17:24", 
                           "10/26/2022 16:24", "11/2/2022 20:17", "11/9/2022 17:49", "11/14/2022 18:15", 
                           "11/23/2022 17:11", NA, "10/4/2022 18:16", "10/10/2022 18:15", 
                           "10/10/2022 18:15", "10/25/2022 5:41", "10/25/2022 5:41", "11/21/2022 16:31", 
                           "11/21/2022 16:31", "11/21/2022 17:11", "11/21/2022 17:11", "11/21/2022 17:11", 
                           NA, "9/22/2022 18:07", "9/26/2022 18:32", "10/3/2022 21:25", 
                           "10/10/2022 19:33", "10/17/2022 18:31", "10/24/2022 15:27", "10/31/2022 19:23", 
                           "11/7/2022 17:48", "11/14/2022 18:22", "11/21/2022 20:09", NA, 
                           "9/19/2022 18:08", "10/5/2022 17:03", "10/11/2022 13:24", "10/11/2022 13:24", 
                           "10/21/2022 1:04", "10/27/2022 0:25", "11/1/2022 18:05", NA, 
                           NA, "9/20/2022 16:56", "10/1/2022 13:28", "10/5/2022 0:56", "10/12/2022 16:39", 
                           "10/18/2022 21:23", "10/27/2022 13:41", "11/2/2022 21:55", "11/12/2022 0:18", 
                           "11/19/2022 17:07", "11/21/2022 19:07", NA, NA, NA, "9/30/2022 23:00", 
                           "10/10/2022 17:30", "10/13/2022 16:48", "10/19/2022 18:45", "10/28/2022 16:48", 
                           "10/28/2022 21:58", "11/8/2022 20:28", "11/14/2022 18:53", "11/22/2022 17:27", 
                           "11/25/2022 16:13", NA, "10/19/2022 16:43", NA, NA, NA, "9/22/2022 15:18", 
                           "9/30/2022 21:41", "10/11/2022 16:23", "10/21/2022 14:40", "10/21/2022 14:40", 
                           "11/1/2022 13:49", "11/1/2022 13:50", "11/11/2022 17:50", "11/24/2022 19:26", 
                           "11/24/2022 19:26", NA, "9/22/2022 15:25", "9/29/2022 2:49", 
                           "10/5/2022 23:17", "10/12/2022 11:28", "10/25/2022 0:34", "10/25/2022 0:34", 
                           "11/17/2022 18:44", "11/17/2022 18:44", "11/17/2022 18:44", "11/25/2022 23:36", 
                           NA, NA, "11/2/2022 11:00", "11/2/2022 11:00", "11/2/2022 11:00", 
                           "11/2/2022 11:01", "11/2/2022 11:01", "11/3/2022 10:15", "11/3/2022 10:15", 
                           "11/16/2022 21:03", "11/16/2022 21:03", "11/29/2022 11:58", NA, 
                           "9/22/2022 16:19", "10/6/2022 11:17", "10/6/2022 11:17", "10/14/2022 16:06", 
                           "10/22/2022 14:14", "10/24/2022 15:50", "11/6/2022 14:12", "11/7/2022 18:18", 
                           "11/18/2022 19:18", "11/29/2022 13:26", NA, "9/20/2022 16:18", 
                           "9/27/2022 22:56", "10/5/2022 23:47", "10/10/2022 16:40", "10/21/2022 18:54", 
                           "10/31/2022 19:41", "11/2/2022 2:35", "11/12/2022 14:11", "11/18/2022 18:45", 
                           "11/28/2022 20:39", NA, "9/20/2022 15:19", NA, "9/23/2022 2:49", 
                           "9/28/2022 17:43", "10/5/2022 22:55", "10/14/2022 11:31", "10/17/2022 17:30", 
                           "10/28/2022 20:10", "11/7/2022 17:54", "11/7/2022 18:08", "11/16/2022 18:51", 
                           "11/30/2022 21:55", NA, "9/21/2022 14:02", "9/30/2022 19:15", 
                           "10/14/2022 18:00", "10/19/2022 17:59", "10/24/2022 16:13", "10/24/2022 16:14", 
                           "11/7/2022 20:28", "11/7/2022 20:28", "11/18/2022 18:56", "11/21/2022 18:04", 
                           NA, "9/20/2022 15:18", "10/5/2022 17:38", NA, NA, "9/20/2022 15:19", 
                           "9/26/2022 18:30", "10/3/2022 22:31", "10/14/2022 2:30", "10/17/2022 18:02", 
                           "10/27/2022 12:46", "11/1/2022 10:58", "11/9/2022 17:28", "11/15/2022 5:00", 
                           "11/22/2022 21:38", NA, NA, NA, "9/21/2022 15:07", "9/28/2022 15:04", 
                           "10/5/2022 21:38", "10/15/2022 13:22", "10/22/2022 13:21", "10/29/2022 13:14", 
                           "11/7/2022 21:20", "11/7/2022 21:21", "11/19/2022 14:53", "11/23/2022 15:04"
    ), 
    yoga_saturday = c(NA, NA, NA, NA, NA, "Yes", "Yes", "Yes", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", NA, NA, NA, 
                      NA, NA, "No", "Yes", "Yes", "No", "No", "No", NA, NA, "Yes", 
                      "Yes", "Yes", "No", "Yes", "No", "Yes", "Yes", "Yes", "Yes", 
                      NA, "Yes", "Yes", "Yes", "Yes", "Yes", "No", "Yes", "Yes", NA, 
                      NA, "Yes", "Yes", NA, NA, "No", "No", "No", "No", NA, NA, NA, 
                      NA, NA, NA, NA, NA, NA, NA, "No", NA, "Yes", "Yes", "Yes", "Yes", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", NA, "Yes", "Yes", "Yes", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", "No", NA, "Yes", "Yes", 
                      "Yes", "No", "Yes", "No", "No", "No", "No", "Yes", NA, "Yes", 
                      "No", "No", "No", "No", "No", "No", NA, NA, "Yes", "No", "Yes", 
                      "Yes", "No", "No", "Yes", "Yes", "Yes", "Yes", NA, NA, NA, "Yes", 
                      "No", "Yes", "No", "Yes", "Yes", "No", "Yes", "No", "No", NA, 
                      "Yes", NA, NA, NA, "Yes", "Yes", "Yes", "Yes", "Yes", "No", "Yes", 
                      "No", "Yes", "Yes", NA, "Yes", "Yes", "No", "No", "No", "No", 
                      "No", "No", "No", "No", NA, NA, "No", "No", "No", "No", "No", 
                      "No", "No", "No", "No", "No", NA, "No", "Yes", "No", "Yes", "Yes", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", NA, "Yes", "Yes", "Yes", "Yes", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", NA, "Yes", NA, "No", 
                      "No", "No", "No", "No", "No", "No", "No", "No", "No", NA, "Yes", 
                      "Yes", "Yes", "Yes", "No", "Yes", "No", "No", "No", "No", NA, 
                      "Yes", "No", NA, NA, "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", 
                      "Yes", "No", "No", "No", NA, NA, NA, "Yes", "Yes", "Yes", "No", 
                      "Yes", "Yes", "Yes", "Yes", "Yes", "Yes"), 
    yoga_days = c(NA, 
                  NA, NA, NA, NA, 2L, 3L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, 2L, NA, NA, 
                  NA, NA, NA, 1L, 0L, 1L, 2L, 0L, 0L, NA, NA, 6L, 7L, 7L, 7L, 7L, 
                  7L, 7L, 7L, 7L, 7L, NA, 1L, 5L, 3L, 3L, 5L, 4L, 5L, 7L, NA, NA, 
                  3L, 2L, NA, NA, 0L, 0L, 0L, 0L, NA, NA, NA, NA, NA, NA, NA, NA, 
                  NA, NA, 4L, NA, 2L, 4L, 5L, 5L, 2L, 1L, 5L, 2L, 1L, 3L, NA, 3L, 
                  7L, 7L, 5L, 4L, 3L, 4L, 4L, 4L, 4L, NA, 1L, 0L, 1L, 0L, 2L, 3L, 
                  1L, 0L, 0L, 1L, NA, 4L, 3L, 2L, 2L, 1L, 0L, 0L, NA, NA, 2L, 2L, 
                  2L, 0L, 4L, 0L, 4L, 2L, 2L, 2L, NA, NA, NA, 1L, 1L, 1L, 1L, 2L, 
                  2L, 1L, 2L, 0L, 3L, NA, 3L, NA, NA, NA, 7L, 5L, 2L, 5L, 5L, 7L, 
                  7L, 7L, 7L, 7L, NA, 2L, 2L, 2L, 3L, 4L, 3L, 2L, 3L, 0L, 0L, NA, 
                  NA, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 1L, NA, 3L, 5L, 5L, 1L, 
                  5L, 5L, 5L, 5L, 7L, 7L, NA, 3L, 3L, 7L, 5L, 5L, 3L, 4L, 6L, 4L, 
                  5L, NA, 1L, NA, 3L, 3L, 1L, 1L, 0L, 0L, 1L, 1L, 0L, 0L, NA, 1L, 
                  2L, 1L, 1L, 3L, 2L, 1L, 3L, 2L, 4L, NA, 3L, 4L, NA, NA, 5L, 2L, 
                  6L, 5L, 7L, 6L, 7L, 7L, 7L, 7L, NA, NA, NA, 2L, 3L, 4L, 3L, 2L, 
                  1L, 3L, 2L, 2L, 2L)
  ), 
  class = "data.frame", 
  row.names = c(NA, 
                -246L)
)

# required libraries
library(dplyr)
library(tidyr)
library(stringr)

### each record is not unique, it has duplicate ID's. Goal is to group by week and pivot wider
### so each row contains one record per ID
# naive approach
df |> 
  mutate(date = lubridate::mdy(str_extract(survey_timestamp_2, "\\d+\\/\\d+\\/\\d+"))) |> # extract dates
  pivot_wider(id_cols = record_id,
              names_from = date,
              values_from = c(yoga_saturday, yoga_days)) |> # pivot wider by date
  View() 

# cut.Date to group by weeks
df |>
  mutate(date = lubridate::mdy(str_extract(survey_timestamp_2, "\\d+\\/\\d+\\/\\d+")), # extract dates
         week = cut.Date(date, breaks = "1 week") # group the dates by week
         ) |> 
  pivot_wider(id_cols = record_id,  # uncomment for second run
  names_from = week,
  values_from = c(yoga_saturday, yoga_days)
  )|>
  View()

### we see that sum columns have vectors like c("Yes", "Yes") in there. This shows that there are duplicate dates or weeks
### R also reported a warning message
# Warning in View :
#   Values from `yoga_days` and `yoga_saturday` are not uniquely identified; output will contain list-cols.
# * Use `values_fn = list` to suppress this warning.
# * Use `values_fn = {summary_fun}` to summarise duplicates.
# * Use the following dplyr code to identify duplicates.
# {data} %>%
#   dplyr::group_by(record_id, date) %>%
#   dplyr::summarise(n = dplyr::n(), .groups = "drop") %>%
#   dplyr::filter(n > 1L)

# use values_fn = {summary_fun} to summarize duplicates
df |>
  mutate(date = lubridate::mdy(str_extract(survey_timestamp_2, "\\d+\\/\\d+\\/\\d+")), # extract dates
         week = cut.Date(date, breaks = "1 week") # group the dates by week
  ) |> 
  pivot_wider(id_cols = record_id,
              names_from = week,
              values_from = c(yoga_saturday, yoga_days),
              values_fn = ~paste0(.x, collapse = ",") # collapses the vectors c("Yes", "Yes" ...) in to string "Yes,Yes"
  )|> 
  View()


# remove duplicates then pivot_wider
df |>
  mutate(date = lubridate::mdy(str_extract(survey_timestamp_2, "\\d+\\/\\d+\\/\\d+")), # extract dates
         week = cut.Date(date, breaks = "1 week") # group the dates by week
  ) |> 
  group_by(record_id, week) |> 
  mutate(row = row_number()) |> # find duplicates and display row numbers
  filter(row == 1) |> # retain only the first duplicate weeks
  ungroup() |> 
  pivot_wider(id_cols = record_id,
              names_from = week,
              values_from = c(yoga_saturday, yoga_days)
              )|>
  View()


# use gt::data_color() to visualize the df
df |>
  mutate(date = lubridate::mdy(str_extract(survey_timestamp_2, "\\d+\\/\\d+\\/\\d+")), # extract dates
         week = cut.Date(date, breaks = "1 week") # group the dates by week
  ) |> 
  group_by(record_id, week) |> 
  mutate(row = row_number()) |> # find duplicates and display row numbers
  filter(row == 1) |> # retain only the first duplicate weeks
  ungroup() |> 
  pivot_wider(id_cols = record_id,
              names_from = week,
              values_from = c(yoga_saturday, yoga_days)
  )|>
  gt::gt() |> 
  gt::data_color(
    palette = "Set1", 
    method="factor",
    columns = -record_id
  )




