#' Regular Expression Bracket Expander
#'
#' Given a regular expression with brackets, expands the expression with explicit matches.
#' Returns a vector of explicit matches.
#'
#' @param rex a regular expression
#' @param show_expanded if set to TRUE, the resulting vector will show each value in the expanded range as names.
#' @examples
#' r <- "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
#' regex_expander(r)
regex_expander <- function(rex, show_expanded=TRUE){
  alpha_nums <- c(0:9, letters, LETTERS)
  rex_split <- strsplit(rex, split="\\|")[[1]]
  
  # extract range patterns
  range_pattern <- stringr::str_extract_all(rex_split, "\\[.*?\\]")
  
  # expand range
  expanded_patterns <- lapply(range_pattern, function(rng){
    if(length(rng) == 1){
      grep(rng, alpha_nums, value=TRUE)
    } else if(length(rng) > 1){
      # if more than 1 range, get every possible combination
      expanded <- lapply(rng, function(v) grep(v, alpha_nums, value=TRUE))
      apply(expand.grid(expanded), 1, function(x) paste0(x, collapse=""))
    } else{
      # no range in the pattern
      NULL
    }
  })
  
  # replace ranges with explicit nums/alphabets
  res <- mapply(function(rex, rng, expt){
    if(length(rng) == 1){
      sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
             USE.NAMES=show_expanded)
    } else if(length(rng) > 1){
      rng <- paste0(rng, collapse="")
      sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
             USE.NAMES=show_expanded)
    } else{
      warning("The expression ", rex, " does not contain any ranges.")
      rex
    }
  },
  rex_split, range_pattern, expanded_patterns,
  USE.NAMES=FALSE)
  
  # regex with no "|" separator
  if(is.matrix(res)) {
    rnms <- rownames(res)
    res <- as.vector(res)
    names(res) <- rnms
    # return
    res
  }
  
  # otherwise, return
  else unlist(res)
}

r <- "^405[0-3L-O]$"
regex_expander(r, show_expanded=FALSE)
regex_expander(r, show_expanded=TRUE)


r <- "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
regex_expander(r, show_expanded=FALSE)
regex_expander(r, show_expanded=TRUE)

r <- "^W3812$"
regex_expander(r, show_expanded = FALSE)
regex_expander(r, show_expanded = TRUE)

















##########################################################################################################################
#' Regular Expression Bracket Expander
#'
#' Given a regular expression with brackets, expands the expression with explicit matches.
#' Returns a vector of explicit matches.
#'
#' @param rex a regular expression
#' @param show_expanded if set to TRUE, the resulting vector will show each value in the expanded range as names.
#' @examples
#' r <- "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
#' regex_expander(r)
regex_expander <- function(rex, show_expanded=TRUE){
  alpha_nums <- c(0:9, letters, LETTERS)
  rex_split <- strsplit(rex, split="\\|")[[1]]
  
  # extract range patterns
  range_pattern <- stringr::str_extract_all(rex_split, "\\[.*?\\]")
  
  # expand range
  expanded_patterns <- lapply(range_pattern, function(rng){
    if(length(rng) == 1){
      grep(rng, alpha_nums, value=TRUE)
    } else if(length(rng) > 1){
      # if more than 1 range, get every possible combination
      expanded <- lapply(rng, function(v) grep(v, alpha_nums, value=TRUE))
      # apply(expand.grid(expanded), 1, function(x) paste0(x, collapse=""))
      expanded <- expand.grid(expanded)
      names(expanded) <- rng
      
      expanded
      
      
    } else{
      # no range in the pattern
      NULL
    }
  })
  
  # replace ranges with explicit nums/alphabets
  res <- mapply(function(rex, rng, expt){
    if(length(rng) == 1){
      sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
             USE.NAMES=show_expanded)
    } else if(length(rng) > 1){
      rng <- paste0(rng, collapse="")
      sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
             USE.NAMES=show_expanded)
    } else{
      warning("The expression ", rex, " does not contain any ranges.")
      rex
    }
  },
  rex_split, range_pattern, expanded_patterns,
  USE.NAMES=FALSE)
  
  # regex with no "|" separator
  if(is.matrix(res)) {
    rnms <- rownames(res)
    res <- as.vector(res)
    names(res) <- rnms
    # return
    res
  }
  
  # otherwise, return
  else unlist(res)
}

# r <- "^W3812$|^405[0-3L-O]$|^N17[04][9FK][0-3]Z$"
r <- "^W3812$|^405[0-3L-O]$|^02[W04]F[0-4][JK]Z"
# r <- "02[W04]F[0-4][JK]Z"
# regex_expander(r, show_expanded=FALSE)
regex_expander(r, show_expanded=TRUE)











####### DEV #############
# r <- "^W3812$|^405[0-3L-O]$|^02[W04]F[0-4][JK]Z"
r <- "AB[W04]F[0-4][JK]Z"
# r <- "AB[0-3]"
ALPHA_NUMS <- c(0:9, letters, LETTERS)


rex_split <- strsplit(r, split="\\|")[[1]]
rex_split


# extract range patterns
range_pattern <- stringr::str_extract_all(rex_split, "\\[.*?\\]")
range_pattern |> length()
range_pattern


# single string
rng <- unlist(range_pattern)
rng
if(length(rng) == 1){
  expanded <- grep(rng, ALPHA_NUMS, value=TRUE)
  replaced <- sapply(expanded, function(p){
    gsub(pattern=rng, replacement=p, x=rex_split, fixed=TRUE)
  })
  
  replaced
} else if(length(rng) > 1){
  expanded <- lapply(rng, function(v) grep(v, alpha_nums, value=TRUE))
  expanded <- expand.grid(expanded)
  names(expanded) <- rng
  
  print(expanded)
  # replace
  apply(expanded, MARGIN=1, function(rw){
    stringr::str_replace_all(rex_split, pattern=stringr::fixed(rw))
    # names(rw)
  }, simplify=FALSE)
}

######### PICKUP FROM HERE #####

### the range patterns are read as regex. (e.g. regex "[W04]" instead of "\\[W04\\]")
### gsub(... fixed=...) <- if fixed = TRUE, these
### regex's are treated as string literal.
### stringr::fixed does the same thing
# stringr::str_replace_all(rex_split, pattern=c("\\[W04\\]"="0" ))
# stringr::str_replace_all(rex_split, pattern=stringr::fixed(c("[W04]"="0" )))
# gsub(pattern="[W04]", replacement="0", x=rex_split, fixed=TRUE)

# stringr::str_replace_all(rex_split, 
#                          pattern=stringr::fixed(setNames(as.character(unlist(expanded[2,])), names(expanded)))
#                          )

# use Reduce to replace all substrings, instead of str_replace_all
library(purrr)
reduce2(.x=names(expanded), .y=as.character(unlist(expanded[2, ])),
        .init=rex_split,
        .f=function(v1, v2, v3){
          message("v1: ",v1)
          message("v2: ",v2)
          message("v3: ",v3)
          result <- gsub(pattern=v2, replacement=v3, x=v1,
               fixed=TRUE)
          message("result: ",result)
        })
# this works but extremely confusing
# v1 is the .init
# v2 is .x
# v3 is .y

# Reduce(f=function(v1, v2) {
#   # first
#   print(v1)
#   print(v2)
#   print(names(v1))
#   replaced1 <- gsub(pattern=names(v1), replacement=v1, x=rex_split, fixed=TRUE)
#   gsub(pattern=names(v2), replacement=v2, x=replaced1, fixed=TRUE)
#   }, 
#   
#   x=setNames(as.character(unlist(expanded[2,])), names(expanded))
#   # init=rex_split
#   )


# result <- mapply(function(rng, rex){
#   if(length(rng) == 1){
#     expanded <- grep(rng, ALPHA_NUMS, value=TRUE)
#     replaced <- sapply(expanded, function(p){
#       gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE)
#     })
#     
#     replaced
#   } else if(length(rng) > 1){
#     expanded <- lapply(rng, function(v) grep(v, alpha_nums, value=TRUE))
#     expanded <- expand.grid(expanded)
#     names(expanded) <- rng
#     
#     print(expanded)
#     # replace
#     apply(expanded, MARGIN=1, function(rw){
#       
#       stringr::str_replace_all(rex, pattern=names(expanded), replacement=rw)
#       # names(rw)
#     }, simplify=FALSE)
#   }
# },
# range_pattern, rex_split,
# SIMPLIFY=FALSE)
# result

# if(length(range_pattern) == 1){
#   rng <- unlist(range_pattern)
#   expanded_range <- grep(rng, alpha_nums, value=TRUE)
#   # replace
#   sapply(expanded_range, function(p){
#     gsub(pattern=rng, replacement=p, x=rex_split)
#   })
# }



# expand range
expanded_patterns <- lapply(range_pattern, function(rng){
  if(length(rng) == 1){
    grep(rng, alpha_nums, value=TRUE)
  } else if(length(rng) > 1){
    # if more than 1 range, get every possible combination
    expanded <- lapply(rng, function(v) grep(v, alpha_nums, value=TRUE))
    # apply(expand.grid(expanded), 1, function(x) paste0(x, collapse=""))
    expanded <- expand.grid(expanded)
    names(expanded) <- rng
    
    expanded
    
    
  } else{
    # no range in the pattern
    NULL
  }
})


# replace ranges with explicit nums/alphabets
res <- mapply(function(rex, rng, expt){
  if(length(rng) == 1){
    sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
           USE.NAMES=show_expanded)
  } else if(length(rng) > 1){
    rng <- paste0(rng, collapse="")
    sapply(expt, function(p) gsub(pattern=rng, replacement=p, x=rex, fixed=TRUE),
           USE.NAMES=show_expanded)
  } else{
    warning("The expression ", rex, " does not contain any ranges.")
    rex
  }
},
rex_split, range_pattern, expanded_patterns,
USE.NAMES=FALSE)

# regex with no "|" separator
if(is.matrix(res)) {
  rnms <- rownames(res)
  res <- as.vector(res)
  names(res) <- rnms
  # return
  res
}

# otherwise, return
else unlist(res)









































