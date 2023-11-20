# sort columns of tbl_summary output (using hashmap..?)
# goal is to sort the columns in a descending order
# ... N = 14, ... N = 16, ... N = 4, ... N = 25 should be
# ... N = 25, ... N = 16, ... N = 14, ... N = 4
library(gtsummary)
# library(stringr)
library(dplyr)

# example tbl_summary
tbl <- trial |>
  tbl_summary(by=stage) |>
  add_overall()

tbl

# desired output
# trial |>
#   tbl_summary(by=stage) |>
#   add_overall() |>
#   modify_table_body(
#     ~.x |>
#       dplyr::relocate(stat_3, .after=stat_4) |>
#       dplyr::relocate(stat_1, .after=stat_2)
#   )

# # no overall
# tbl <- trial |> 
#   tbl_summary(by=stage)
# 
# tbl

# # storms example
# tbl <- storms |> 
#   tbl_summary(by=status) |> 
#   add_overall()
# 
# tbl


# tbl[["table_styling"]][["header"]][["label"]] has the column labels
labs <- tbl[["table_styling"]][["header"]][["label"]]


# method 1
# use gsub to replace "...N = " part of the strings with "" (we're just removing)
# if there are commas, we also need to remove those
# then convert to numeric
# use order() to sort the labels
processed_str <- gsub(",", "", labs)
processed_str <- as.numeric(gsub(".+N = ", "", processed_str))
sorted_index <- order(processed_str, decreasing=T, na.last=F)

# sort labs only
sorted_labs <- labs[sorted_index]
sorted_labs

# update table labels
tbl[["table_styling"]][["header"]][["label"]] <- sorted_labs

tbl

# # method 2
# sort desc
# str_sort(labs, na_last = F, numeric = T)
# sorted_labs <- labs[
#   order(
#     as.numeric(str_extract(labs, "N = (\\d+)", group = 1)),
#     na.last = F,
#     decreasing = T
#   )
# ]

# now we see that the column labels are sorted
# but the colum values below are not sorted
# we try using hashmap
# actually just try with a named list

# what we know is that table[["table_body"]][["stat_d"]] contains the column values
# tbl[["table_body"]][["stat_0"]] has col label "Overall, N = 200"
# tbl[["table_body"]][["stat_1"]] has col label "T1, N = 53"
# tbl[["table_body"]][["stat_2"]] has col label "T2, N = 54"
# tbl[["table_body"]][["stat_3"]] has col label "T3, N = 43"
# tbl[["table_body"]][["stat_4"]] has col label "T4, N = 50"

# create a list that maps labels to columns
mapping <- list()

# extract indices of columns to reassign
indices_lab <- labs |> grep(".+N = ", x=_)
indices_stat <- names(tbl[["table_body"]]) |> grep("stat_", x=_)

# grab column labels to sort
labs_substr <- labs[indices_lab]

# grab column values
col_values <- tbl[["table_body"]][indices_stat]

# for (i in seq_along(labs_substr)){
#   mapping[[
#     labs_substr[[i]]
#     ]] <- tbl[["table_body"]][[paste0("stat_",(i-1))]]
# }

# assign column values to mapping
mapping <- col_values

# assign column labels to mapping
mapping <- mapping |> setNames(labs_substr)
mapping

# sort this mapping based on the names
# reference: https://stackoverflow.com/questions/27312311/sort-a-named-list-in-r
# https://stackoverflow.com/questions/17531403/how-to-sort-a-character-vector-where-elements-contain-letters-and-numbers 

# # use gsub to replace "...N = " part of the strings with "" (we're just removing)
# # then convert to numeric
# # use order() to sort the labels
# # sort labs
processed_str <- gsub(",", "", names(mapping))
processed_str <- as.numeric(gsub(".+N = ", "", processed_str))
sorted_index <- order(processed_str, decreasing = T, na.last = F)
sorted_mapping <- mapping[sorted_index]
sorted_mapping

# now you have sorted list of mapping
# try to assign the values back to tbl obj
# replace the labels of table that says "overall, N =...", "T..., N...", ...
tbl[["table_styling"]][["header"]][["label"]][indices_lab] <- names(sorted_mapping)

# assign sorted columns to tbl
tbl[["table_body"]][indices_stat] <- sorted_mapping

tbl



# define a function
tbl_sort_cols <- function(tbl){
  # tbl: table object from gtsummary::tbl_summary
  # tbl object MUST include columns generated using "by" parameter in tbl_summary
  # tbl[["table_styling"]][["header"]][["label"]] has the column labels
  labs <- tbl[["table_styling"]][["header"]][["label"]]
  
  # first extract indicies of labels that contain "N = "
  indices_lab <- grep(labs, pattern=".+N = ")
  
  # extract indicies of columns that match the labels
  indices_stat <- names(tbl[["table_body"]]) |> grep("stat_", x=_)
  
  # grab labels to sort
  labs_substr <- labs[indices_lab]
  
  # create a list that maps labels to columns
  mapping <- list()
  
  # assign column values to mapping
  mapping <- tbl[["table_body"]][indices_stat]
  
  # assign column labels to mapping
  mapping <- mapping |> setNames(labs_substr)
  
  # sort labels and columns
  # first remove unnecessary commas
  # convert the string to numbers and sort
  processed_str <- gsub(",", "", names(mapping))
  processed_str <- as.numeric(gsub(".+N = ", "", processed_str))
  sorted_index <- order(processed_str, decreasing = T, na.last = F)
  sorted_mapping <- mapping[sorted_index]
  
  # # extract indices of columns to reassign
  # indices_lab <- tbl[["table_styling"]][["header"]][["label"]] |> grep("N = ", x=_)
  # indices_stat <- names(tbl[["table_body"]]) |> grep("stat_", x=_)
  
  # reassign column labels
  tbl[["table_styling"]][["header"]][["label"]][indices_lab] <- names(sorted_mapping)
  
  # reassign columns
  tbl[["table_body"]][indices_stat] <- sorted_mapping
  
  return(tbl)
}

# test, no overall
test1 <- trial |> tbl_summary(by=stage)
test1

tbl_sort_cols(test1)

# test2, yes overall
test2 <- trial |> tbl_summary(by=stage) |> add_overall()
test2

tbl_sort_cols(test2)

# test, add p
test3 <- trial |> tbl_summary(by=stage) |> add_overall() |> add_p()
test3

tbl_sort_cols(test3)

# test, arbitrary data, no overall
test4 <- dplyr::storms |> tbl_summary(by=status)
test4

tbl_sort_cols(test4)

# test, arbitrary data, yes overall
test5 <- dplyr::storms |> tbl_summary(by=status) |> add_overall()
test5

tbl_sort_cols(test5)

# test, add p
test6 <- dplyr::storms |> dplyr::select(-name) |> tbl_summary(by=status) |> add_overall() |> add_p()
test6

tbl_sort_cols(test6)
















# removed from the function
# # assign column values to labels accordingly
# # if overall column exists (i.e. stat_0 exists), then i - 1
# # otherwise i
# if (any(grepl("Overall", labs))){
#   for (i in seq_along(labs_substr)){
#     mapping[[
#       labs_substr[[i]]
#     ]] <- tbl[["table_body"]][[paste0("stat_",(i-1))]]
#   }
# } else{
#   for (i in seq_along(labs_substr)){
#     mapping[[
#       labs_substr[[i]]
#     ]] <- tbl[["table_body"]][[paste0("stat_",(i))]]
#   }
# }

