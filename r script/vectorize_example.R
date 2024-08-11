set.seed(123)
n <- 500
X1 <- runif(n, -2, 4)
X2 <- factor(sample(0:2, n, replace=TRUE))
X3 <- factor(sample(0:1, n, replace=TRUE))

# generate single y value
y_helper <- function(x1, x2, x3){
  z <- 10 + 25*x1 + rnorm(1)
  
  if(x2 == 0 && x3 == 0) y <- z
  else if(x2 == 0 && x3 == 1) y <- z - 7
  else if(x2 == 1 && x3 == 0) y <- z + 15
  else if(x2 == 1 && x3 == 1) y <- z + 15 - 7
  else if(x2 == 2 && x3 == 0) y <- z - 2
  else if(x2 == 2 && x3 == 1) y <- z - 2 - 7
  
  return(y)
}

# 1. for-loop
Y <- rep(0, n)
for(i in 1:n){
  Y[i] <- y_helper(X1[i], X2[i], X3[i])
}

# 2. Vectorize()
y_helper_vectorized <- Vectorize(y_helper)
Y <- y_helper_vectorized(X1, X2, X3)

# 3. map
Y <- mapply(function(v1, v2, v3) y_helper(v1, v2, v3), X1, X2, X3)

# Map
Y <- Map(function(v1, v2, v3) y_helper(v1, v2, v3), X1, X2, X3) |> unlist()

# the same can be achieved with dplyr::case_when
Z <- 10 + 25*X1 + rnorm(n)
Y <- dplyr::case_when(
  X2 == 0 & X3 == 0 ~ Z,
  X2 == 0 & X3 == 1 ~ Z - 7,
  X2 == 1 & X3 == 0 ~ Z + 15,
  X2 == 1 & X3 == 1 ~ Z + 15 - 7,
  X2 == 2 & X3 == 0 ~ Z - 2,
  X2 == 2 & X3 == 1 ~ Z - 2 - 7
)


# fit linear model
dat <- data.frame(Y, X1, X2, X3)
fit <- lm(Y ~ X1 + X2 + X3, data=dat)
summary(fit)


