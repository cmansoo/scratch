#' Regular Expression Bracket Expander
#'
#' Given a regular expression with brackets, expands the expression with explicit matches.
#' Returns a vector of explicit matches.
#'
#' @param rex a regular expression
#' @param show_expanded if set to TRUE, the resulting vector will show each value in the expanded range as names.
#' @examples
#' r <- "^W3812|^405[0-3L-O]|^N17[04][9FK]Z"
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
regex_expander(r, FALSE)
regex_expander(r, TRUE)


r <- "^W3812$|^405[0-3L-O]$|^N17[04][9FK]Z$"
regex_expander(r, FALSE)
regex_expander(r, TRUE)

