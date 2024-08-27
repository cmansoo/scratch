# make reproducible example
# test = lab
# entry = admission
# ID = patient
# ID + entry = patient + specific admission
# 1 row = 1 admission record

library(dplyr)
library(tidyr)

# dat1 is the duplicated data
# there can be multiple entries for each ID
# dat2 is the test data, the test record we have pulled is for a test that is of our interest
# goal is to convert dat2 to wide format s.t. we have test value1, test value2, .... and 
# test date1, test date2, ... respectively
# We want to merge the wide format back to dat1.
# However, when merging we want to make sure that based on the test and entry dates,
# for each ID, we want to make sure that we're getting the test records for that specific admission.

# sample data
dat1 <- data.frame(
  id = c("A", "A", "B", "B", "B", "C", "C"),
  entry_date = as.Date(c("2020-01-01", "2021-12-14", "2019-09-01", "2021-01-24", "2022-01-01", "2017-03-19", "2017-06-12"))
)
dat1

set.seed(42)
n <- 50
dat2 <- data.frame(
  id = sample(c("A", "B", "C"), n, replace=TRUE),
  test_date = sample(seq(as.Date("2017-01-01"), as.Date("2023-12-31"), by="day"), n, replace=TRUE),
  test_name = sample(paste0("test_", letters[1:5]), replace=TRUE),
  test_value = runif(n)
) |> 
  arrange(id, test_date)
dat2

# using dat1 want to filter test dates that are later then entry date
# for each ID

# 1. convert dat1 to wide format
new_dat1 <- dat1 |>
  mutate(.by=id, rn=row_number()) |> 
  pivot_wider(
    names_from=rn,
    values_from=entry_date,
    names_prefix="entry_date"
  ) |> 
  left_join(x=dat2, y=_, by="id")

new_dat1

# group duplicates based on test and entry dates
# new_dat1 |> 
#   mutate(
#          date_comparison=case_when(
#     test_date >= entry_date1 & test_date < entry_date2 ~ "between date1 and date2", # entry date 2 will not be missing because we have duplicate records.
#     test_date >= entry_date2 & test_date < entry_date3 ~ "between date2 and date3", # but date 3 can be missing
#     test_date >= entry_date2 & is.na(entry_date3) ~ "after date2 where date3 missing",
#     test_date >= entry_date3 ~ "after date3",
#     .default=NA
#   )) |> View()

# convert to wide format
merged_dat <- new_dat1 |>
  # break relevant test records into grouups
  mutate(entry_group=case_when(
    test_date >= entry_date1 & test_date < entry_date2 ~ "first_entry",
    test_date >= entry_date2 & test_date < entry_date3 |
      test_date >= entry_date2 & is.na(entry_date3) ~ "second_entry",
    test_date >= entry_date3 ~ "third_entry",
    .default=NA
  )) |> 
  # remove records that dont belong to a group
  filter(!is.na(entry_group)) |> 
  mutate(.by=c(id, entry_group), rn=row_number()) |>
  # split into list of dataframes by group
  group_split(entry_group, .keep=TRUE) |> 
  # convert to wide format
  # add identifier
  lapply(function(dat){
    dat |> 
      pivot_wider(
        id_cols=c(id, entry_group),
        names_from=rn,
        values_from=c(test_value, test_date)
      )
  }) |> 
  # bind
  bind_rows() 

# merge the wide format data back to original data
# replicate entry_group
dat1.1 <- dat1 |> 
  mutate(
    .by=id, 
    entry_group=case_when(
      row_number() == 1 ~ "first_entry",
      row_number() == 2 ~ "second_entry",
      row_number() == 3 ~ "third_entry"
    )
  )

# join
result <- left_join(dat1.1, merged_dat, by=c("id", "entry_group"))
result


########### method from here works
# first duplicate
new_dat2.1 <- new_dat1 |>
  filter(test_date >= entry_date1 & test_date < entry_date2) |> 
  mutate(.by=id, rn=row_number()) |>
  pivot_wider(
    id_cols = c(id,entry_date1),
    names_from=rn,
    values_from=c(test_value, test_date)
  ) |>
  mutate(id_concat=paste0(id, "-", entry_date1))

new_dat2.1

# second set of duplicates
new_dat2.2 <- new_dat1 |>
  filter( (test_date >= entry_date2 & test_date < entry_date3) |
           (test_date >= entry_date2 & is.na(entry_date3)) ) |> 
  mutate(.by=id, rn=row_number()) |>
  pivot_wider(
    id_cols=c(id, entry_date2),
    names_from=rn,
    values_from=c(test_value, test_date)
  ) |>
  mutate(id_concat=paste0(id,"-",entry_date2))
new_dat2.2

# third set of duplicates
new_dat2.3 <- new_dat1 |>
  filter(test_date >= entry_date3) |>
  mutate(.by=id, rn=row_number()) |>
  pivot_wider(
    id_cols=c(entry_date3, id),
    names_from=rn,
    values_from=c(test_value, test_date)
  ) |>
  mutate(id_concat=paste0(id,"-",entry_date3))

new_dat2.3


# ... and so on

# merge the processed data back to dat1
new_dat2_bound <- bind_rows(new_dat2.1, new_dat2.2, new_dat2.3) |>
  select(-matches("entry"), -id)

res <- dat1 |>
  mutate(id_concat=paste0(id,"-",entry_date)) |>
  left_join(new_dat2_bound, by="id_concat")

res

