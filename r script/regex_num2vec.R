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
x <- c("N17[0-9]", "438[0-9]", "I6[02-4]1")
x_split <- strsplit(x, "")
lapply(x_split, function(y) {
  num1 <- y[which(y == "[") + 1]
  num2 <- y[which(y == "]") - 1]
  substr1 <- y[1:which(y == "[") - 1] |> paste0(collapse="")
  substr2 <- y[(which(y == "]")+1):length(y)] |> paste0(collapse="")
  # return
  paste0(substr1, seq(num1, num2), substr2)
})

# [[1]]
# [1] "N170NA]" "N171NA]" "N172NA]" "N173NA]" "N174NA]" "N175NA]" "N176NA]" "N177NA]"
# [9] "N178NA]" "N179NA]"
# 
# [[2]]
# [1] "4380NA]" "4381NA]" "4382NA]" "4383NA]" "4384NA]" "4385NA]" "4386NA]" "4387NA]"
# [9] "4388NA]" "4389NA]"
# 
# [[3]]
# [1] "I601" "I611" "I621" "I631" "I641"
