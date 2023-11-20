library(dplyr)
library(forcats)
library(gtsummary)


# sample data
df <- tribble(
  ~grade, ~year, ~graduated,
  "A", "senior", "1",
  NA_character_, "senior", "0",
  "A", NA_character_, "1",
  "B", NA_character_, NA_character_,
  NA_character_, NA_character_, NA_character_,
  "F", "freshmen", NA_character_
)

# default
df |> tbl_summary()

### notice the percentages are out of 4, NOT 6
### e.g. for grade A, 2/4 = 50%, NOT 2/6 = 33%

# missing = no
df |> tbl_summary(missing = "no")

# explciit na
df |> 
  mutate(across(everything(), ~fct_explicit_na(.x))) |> 
  tbl_summary()

# remove_row_type
df |> 
  mutate(across(everything(), ~fct_explicit_na(.x))) |> 
  tbl_summary() |> 
  remove_row_type(type = "level", level_value = "(Missing)")

# to handle binary
df |> 
  mutate(across(everything(), ~fct_explicit_na(.x))) |> 
  tbl_summary(value = graduated ~ "1")

# full version
df |> 
  mutate(across(everything(), ~fct_explicit_na(.x))) |> 
  tbl_summary(value = graduated ~ "1") |> 
  remove_row_type(type = "level", level_value = "(Missing)")






