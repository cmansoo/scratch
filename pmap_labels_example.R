library(dplyr)
library(purrr)

# example data
df1 = tribble(
  ~a_age, ~a01edu, ~other_vars,
  35, 17, 1,
  41, 14, 2,
  28, 12, 3,
  68, 99, 4
)

df2 = tribble(
  ~b_age, ~b01edu, ~some_vars,
  25, 10, 2,
  52, 8, 1,
  31, 20, 5
)

df3 = tribble(
  ~c_age, ~c01edu,
  55, 16,
  47, 11,
  68, 16,
  36, 6, 
  29, 16
)

df_list = list(df1, df2, df3) |> setNames(c("a", "b", "c"))

# var_label(df_list[["a"]]) <- list(a_age = "Age", a01edu = "Highest education")

View(df_list[["a"]])
### set up parameters df
# easier to name the columns same as the function parameters
# you will be feeding
# if you want arbitrary naming, use individual lists instead or unname the params object

params = tribble(
  ~x, ~y, ~z,
  "a", "a_age", "a01edu",
  "b", "b_age", "b01edu",
  "c", "c_age", "c01edu"
)

df_list[params[["x"]]] <- 
  pmap(params,
       function(x, y, z) {
         df_list[[x]] |> labelled::set_variable_labels(
           .labels = lst(!!y := "Age",
                         !!z := "Highest education completed")
           )
         }
       )

View(df_list[["b"]])

#####{{ and := go together !! and {{ seem to have the same affect? look up ?":=" for more info

# pmap(params,
#      function(x, y, z) {
#        df_list[[x]] |> labelled::set_variable_labels(
#          .labels = lst({{y}} := "Age",
#                        {{z}} := "Highest education completed")
#        )
#      }
# )

### unname parameters

# pmap(unname(params),
#      function(.x, .y, .z) {
#        df_list[[.x]] |> labelled::set_variable_labels(
#          .labels = lst(!!.y := "Age",
#                        !!.z := "Highest education completed")
#          )
#        }
#      )

### individual lists
# l = c("a", "b", "c")
# m = c("a_age", "b_age", "c_age")
# n = c("a01edu", "b01edu", "c01edu")
# 
# pmap(list(l, m, n),
#      function(first, second, third) {
#        df_list[[first]] |> labelled:::set_variable_labels(
#          .labels = lst(!!second := "Age",
#                        !!third := "Highest education completed")
#          )
#        }
#      )

#### old code
# df_list[params[["x"]]] <-
#   pmap(params,
#        function(x, y, z) {
#          df_list[[x]] |> labelled::set_variable_labels(
#            .labels = list(y = "Age",
#                           z = "Highest education completed")
#            )
#          }
#        )