# given a regex with range of numbers, spell out the expression explicitly
# e.g. for a regex "abc[12-469]", the result will be c("abc1", "abc2", "abc4", "abc5", "abc6", "abc9")
x <- "N17[0-9]"
x <- "438[2189]"
x_split <- unlist(strsplit(x, ""))
num1 <- x_split[which(x_split == "[") + 1]
num2 <- x_split[which(x_split == "]") - 1]
substr1 <- x_split[1:which(x_split == "[") - 1] |> paste0(collapse="")
newstr <- paste0(substr1, seq(num1, num2))
newstr
# [1] "4382" "4383" "4384" "4385" "4386" "4387" "4388" "4389"

# vectors?
x <- c("N17[0-3]", "438[46]", "I6[02-4]1", "V[1-3]71")
x_split <- strsplit(x, "")
lapply(x_split, function(y) {
  bracket1_idx <- which(y == "[")
  hyphen_idx <- which(y == "-")
  bracket2_idx <- which(y == "]")
  num1 <- y[hyphen_idx - 1]
  num2 <- y[hyphen_idx + 1]
  substr1 <- y[1:bracket1_idx - 1] |> paste0(collapse="")
  
  if(bracket2_idx == length(y)) paste0(substr1, seq(num1, num2))
  else {
    substr2 <- y[(bracket2_idx + 1):length(y)] |> paste0(collapse="")
    paste0(substr1, seq(num1, num2), substr2)
  }
})

# [[1]]
# [1] "N170" "N171" "N172" "N173"
# 
# [[2]]
# [1] "4384" "4385" "4386"
# 
# [[3]]
# [1] "I601" "I611" "I621" "I631" "I641"
# 
# [[4]]
# [1] "V171" "V271" "V371"

# currently doesnt work for sets of numbers, need to fix sequence to set
# seq(num1, num2) should be set of numbers for [02-4]. i.e. c(0, seq(2,4))

x <- "I6[02-4]1"
y <- unlist(strsplit(x, ""))
bracket1_idx <- which(y == "[")
hyphen_idx <- which(y == "-")
bracket2_idx <- which(y == "]")
num1 <- y[hyphen_idx - 1]
num2 <- y[hyphen_idx + 1]
substr1 <- y[1:bracket1_idx - 1] |> paste0(collapse="")

if(bracket2_idx == length(y)) {
  paste0(substr1, seq(num1, num2))
} else {
  substr2 <- y[(bracket2_idx + 1):length(y)] |> paste0(collapse="")
  paste0(substr1, seq(num1, num2), substr2)
}

