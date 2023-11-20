library(dplyr)
library(purrr)

# example data
df1 <- tribble(
  ~a01age, ~a01edu,
  35, 17, 
  41, 14, 
  28, 12, 
  68, 99,
)

df2 <- tribble(
  ~b01age, ~b01edu, ~b01sex, ~b01fish,
  25, 10, 1, 1,
  52, 8, 2, 0,
  31, 20, 2, 0
)

df3 <- tribble(
  ~c01age, ~c01edu, ~c01sex,
  55, 16, 1,
  47, 11, 1,
  68, 16, 1,
  36, 6, 2,
  29, 16, 2
)

df_list <- list(df1, df2, df3) |> setNames(c("a", "b", "c"))

# view data
View(df_list[["a"]])
# View(df_list[["b"]])


# use mutate across with matches to select columns using regex
df_list <- map(
  df_list,
  function(x) {
    x = x |>
      mutate(
        across(
          matches("\\d.*edu"),
          ~case_when(.x %in% c(1:6) ~ "Elementary School",
                     .x %in% c(7, 8) ~ "Junior High",
                     .x %in% c(9:12) ~ "High School",
                     .x %in% c(13:16) ~ "college",
                     .x %in% c(17:98) ~ "Graduate School",
                     TRUE ~ "No Answer")
        )
      )

    return(x)
  }
)

######### above code is equivalent to #####################################
# df1 = df1 |> mutate(a01edu = case_when(a01edu %in% c(1:6) ~ "Elementary School",
#                                 a01edu %in% c(7, 8) ~ "Junior High",
#                                 a01edu %in% c(9:12) ~ "High School",
#                                 a01edu %in% c(13:16) ~ "college",
#                                 a01edu %in% c(17:98) ~ "Graduate School",
#                                 TRUE ~ "No Answer"))
# df2 = df2 |> mutate(...
###########################################


# view data
# View(df_list[["a"]])
# View(df_list[["b"]])
# View(df_list[["c"]])


