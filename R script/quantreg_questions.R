library(quantreg)

fit1 <- rq(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species, method="fn", data=iris, tau=seq(0.01, 0.99, by=0.01))
fit1$coefficients
plot(summary(fit1))

fit2 <- rq(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width + Species, method="br", data=iris)
summary(fit2)$coef

# generate data
set.seed(123)
n <- 100
x1 <- runif(100)
x2 <- sample(0:2, n, replace=TRUE) |> factor(levels=c(0, 1, 2))
x3 <- sample(c(0, 1), n, replace=TRUE) |> factor(levels=c(0, 1))
# y <- ifelse(x3 == 1, 10 + 25*x1 + 14 + rnorm(n), 10 + 25*x1 + rnorm(n))
y <- dplyr::case_when(
  x2 == 1 & x3 == 1 ~ 10 + 25*x1 + 14 + 5 + rnorm(n),
  x2 == 1 & x3 == 0 ~ 10 + 25*x1 + 14 + rnorm(n),
  x2 == 2 & x3 == 1 ~ 10 + 25*x1 - 3 + 5 + rnorm(n),
  x2 == 2 & x3 == 0 ~ 10 + 25*x1 - 3 + rnorm(n),
  .default = 10 + 25*x1 + rnorm(n)
)

# # try writing vectorized case when statement?
# y_helper <- function(x1, x2, x3, n){
#   intercept_x1_error <- 10 + 25*x1 + rnorm(n)
#   if(x2 == 1 & x3 == 1) {y <- intercept_x1_error + 14 + 5}
#   else if(x2 == 1 & x3 == 0) {y <- intercept_x1_error + 14}
#   else if(x2 == 2 & x3 == 1) {y <- intercept_x1_error - 3 + 5}
#   else if(x2 == 2 & x3 == 0) {y <- intercept_x1_error - 3}
#   
#   return(y)
# }
# y_helper_vectorized <- Vectorize(y_helper, c("x2", "x3"), SIMPLIFY = FALSE)
# y_helper_vectorized(x1, x2, x3, n)
# ### doesnt really work -> open up a separate question
# # for now use y <- dplyr::case_when(...)

dat <- data.frame(y, x1, x2, x3)

# model
# fit <- rq(y ~ x1 + x2 + x3, method="fn", data=dat, tau=seq(0.05, 0.95, by=0.05))
# plot(summary(fit))

fit <- rq(y ~ x1 + x2 + x3, method="fn", data=dat, tau=0.5)
fit$coefficients
summary(fit)

rq(y ~ x1 + x2 + x3, method="br", data=dat)

#######
fit1 <- rq(y ~ x1 + x2 + x3, method="fn", data=dat)
fit2 <- rq(y ~ x1 + x2 + x3, method="br", data=dat)
fit1$coefficients
summary(fit1)
summary(fit1, se="nid")
summary(fit1, se="iid")
summary(fit1, se="ker")
fit2$coefficients
summary(fit2)


