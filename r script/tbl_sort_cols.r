
tbl_sort_cols <- function(tbl){
  # tbl: table object from gtsummary::tbl_summary
  # tbl object MUST include columns generated using "by" parameter in tbl_summary
  # tbl[["table_styling"]][["header"]][["label"]] has the column labels
  if(!require(gtsummary)) stop("package gtsummary is not installed. Please install using `install.packages('gtsummary')")
  
  labs <- tbl[["table_styling"]][["header"]][["label"]]
  
  mapping <- list()
  labs_substr <- labs[grep(labs, pattern=".+N = ")]
  
  # assign column values to labels accordingly
  if (any(grepl("Overall", labs))){
    for (i in seq_along(labs_substr)){
      mapping[[
        labs_substr[[i]]
      ]] <- tbl[["table_body"]][[paste0("stat_",(i-1))]]
    }
  } else{
    for (i in seq_along(labs_substr)){
      mapping[[
        labs_substr[[i]]
      ]] <- tbl[["table_body"]][[paste0("stat_",(i))]]
    }
  }
  
  # sort labels
  processed_str <- gsub(",", "", names(mapping))
  processed_str <- as.numeric(gsub(".+N = ", "", processed_str))
  sorted_index <- order(processed_str, decreasing = T, na.last = F)
  sorted_mapping <- mapping[sorted_index]
  
  indices_lab <- tbl[["table_styling"]][["header"]][["label"]] |> grep("N = ", x=_)
  indices_stat <- names(tbl[["table_body"]]) |> grep("stat_", x=_)

  tbl[["table_styling"]][["header"]][["label"]][indices_lab] <- names(sorted_mapping)
  tbl[["table_body"]][indices_stat] <- sorted_mapping
  
  return(tbl)
}


# tests
# test, no overall
test1 <- trial |> tbl_summary(by=stage)
test1

tbl_sort_cols(test1)

# test2, add overall
test2 <- trial |> tbl_summary(by=stage) |> add_overall()
test2

tbl_sort_cols(test2)


# test, bigger data, no overall
test3 <- dplyr::storms |> tbl_summary(by=status)
test3

tbl_sort_cols(test3)
