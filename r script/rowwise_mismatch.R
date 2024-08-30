# from <https://stackoverflow.com/questions/14543627/extracting-numbers-from-vectors-of-strings>
# I am trying to count the number of mismatches in values between two rows (two samples), going column by column in R. I want to only count mismatches that dont include an NA. Here is some example data:

# data
dat <- read.table(text="Sample1  0 1 1 2 NA 2 1 1
Sample1b 1 1 1 2 1  1 1 1
Sample2  2 2 1 0 0 NA 0 0
Sample2b 2 2 1 1 0 NA 0 0")

# Id like to do this in groups of two rows (comparing sample 1 to sample 1b, and then sample 2 to 2b, and so forth). In this example, Sample 1vsSample 1b would have 2/7 mismatches and sample 2 vs 2b would have just 1/7 (the NA comparisons are removed from the denominator).

# Ive tried using an apply over columns, comparing each line, but havent gotten that far...

# Any help would be much appreciated!



library(dplyr)
# approach 1 using split, using V1 as group
dat |> 
  mutate(V1 = gsub(".*(\\d+).*", "\\1", V1)) %>% 
  split(.$V1) |> 
  lapply(function(df) {
    df <- df[,-1] # deselet V1
    mismatch <- df[1,] != df[2,]
    MASS::fractions(mean(mismatch, na.rm=TRUE))
    })

# approach 1.1 dplyr::group_split, using V1 as group, basically the same as using split tho
dat |> 
  mutate(V1 = gsub(".*(\\d+).*", "\\1", V1)) %>% 
  group_split(.$V1, .keep=FALSE) |> 
  lapply(function(df) {
    # transpose
    df <- t(df[,-1]) # deselet V1
    mismatch <- df[,1] != df[,2]
    MASS::fractions(mean(mismatch, na.rm=TRUE))
    })

# approach 2 using rowSums <- very exhaustive method since copying all of the columns
dat |> 
  mutate(group = gsub("\\D+$", "", V1)) |> 
  mutate(.by = group, across(V2:V9, \(x) first(x), .names="{.col}.")) |> 
  mutate(mismatch = rowSums(across(V2:V9) != across(V2.:V9.), na.rm=TRUE),
         denom = rowSums(across(V2.:V9., \(x) !is.na(x)), na.rm=TRUE),
         result = as.character(MASS::fractions(mismatch / denom))) |> 
  filter(result != 0) |> 
  select(group, result)
