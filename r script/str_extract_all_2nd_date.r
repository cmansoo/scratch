library(dplyr)
library(tidyr)
library(stringr)
library(anytime)

# example data
df <- tribble(
  ~text,
  "...text...1/5/17...text...12/26/18",
  "...text...3/1/19...text...4/5/19",
  "...text...10/5/14...text...",
  "...text...5/5/16...text...9/16/17",
  "...text...",
  "...text...2/22/20...text..."
)

# for loop (do not use this method)
str_extract_all(df$text, "\\d+\\/\\d+\\/\\d+") -> result
# str_extract_all(df$text, "\\d+\\/\\d+\\/\\d+", simplify=T) -> result2

# initialize empty vector
sec_date <- rep(NA, length(result))

# if more then 1 item per element, then append to sec_date
for (i in 1:length(result)){
  if(length(result[[i]] > 1)){
    sec_date[[i]] <- result[[i]][2]
  }
}

df1 <- df |> mutate(second_date = lubridate::mdy(sec_date))
df1

# dplyr and tidyr solution
df2 <- df |> 
  mutate(date = as.data.frame(str_extract_all(text, "\\d+\\/\\d+\\/\\d+", simplify=T))) |> # nest the resulting matrix as df
  unnest_wider(date) |> # unnest
  mutate(across(c(V1, V2), lubridate::mdy)) |>  # convert to date
  rename(first_date = V1, second_date = V2)

df2
####
# df3 <- df |> 
#   mutate(date = as.data.frame(str_extract_all(text, "\\d+\\/\\d+\\/\\d+", simplify=T))) |> # nest the resulting matrix as df
#   unnest_wider(date) #|> # unnest
#   mutate(across(c(V1, V2), ~.x
#                   anytime::anydate)) |>  # convert to date
#   # rename(first_date = V1, second_date = V2)

# df3

