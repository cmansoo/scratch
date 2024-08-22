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
x <- c("N17[0-9]", "438[0-9]", "I61[0-4]")
x_split <- strsplit(x, "")
lapply(x_split, function(y) {
  num1 <- y[which(y == "[") + 1]
  num2 <- y[which(y == "]") - 1]
  substr1 <- y[1:which(y == "[") - 1] |> paste0(collapse="")
  # return
  paste0(substr1, seq(num1, num2))
})

# [[1]]
# [1] "N170" "N171" "N172" "N173" "N174" "N175" "N176" "N177" "N178" "N179"
# 
# [[2]]
# [1] "4380" "4381" "4382" "4383" "4384" "4385" "4386" "4387" "4388" "4389"
# 
# [[3]]
# [1] "I610" "I611" "I612" "I613" "I614"
