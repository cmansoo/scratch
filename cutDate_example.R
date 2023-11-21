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




