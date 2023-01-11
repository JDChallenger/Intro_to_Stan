library(ggplot2)
library(rstan)
library(rethinking)

data("Howell1")
d <- Howell1[Howell1$age>=18,]

ggplot(d) + geom_point(aes(x=height, y=weight),color= 'red', shape = 1) + theme_classic()

#lm(weight ~ height, data = d)

dat <- list(H = d$height, W = d$weight, Hbar = mean(d$height), N = length(d$height))

lookup("dnorm")
fit = stan('stan_model1.stan', data = dat, iter = 3000, chains = 3)
print(fit)
plot(fit) # plot(fit, pars = c('a'))
traceplot(fit, nrow = 3)
pairs(fit)

samples <- extract(fit)

Hbar = mean(d$height)
f <- function(x) mean(samples$a) + mean(samples$b)*(x-Hbar)
ggplot(d) + geom_point(aes(x=height, y=weight),color= 'red', shape = 1) + theme_classic() + 
  geom_function(fun = f, linewidth = .7) + ylim(c(26,70))

mat <- matrix(0, ncol = 4000, nrow = 45)
for(i in 1:45){
  for(j in 1:4000){
    mat[i,j] <- samples$a[j] + samples$b[j]*(135+i - Hbar)
  }
}
h <- apply(mat,1,FUN = PI, prob = 0.95) # Note: PI function from the rethinking package
df <- data.frame(height = seq(136,180,1), lower = h[1,], upper = h[2,])

ggplot() + geom_point(data = d, aes(x=height, y=weight),color= 'red', shape = 1) + theme_classic() + 
  geom_function(fun = f, linewidth = .7) + 
  geom_ribbon(data = df, aes(x = height, ymin = lower, ymax = upper), fill = 'grey', alpha = .55) + 
  ylim(c(26,70))


mat2 <- matrix(0, ncol = 4000, nrow = 45)
for(i in 1:45){
  for(j in 1:4000){
    aux <- samples$a[j] + samples$b[j]*(135+i - Hbar)
    mat2[i,j] <- rnorm(1,mean = aux, sd = samples$sigma[j])
  }
}
h2 <- apply(mat2,1,FUN = PI)

df2 <- data.frame(height = seq(136,180,1), lower = h2[1,], upper = h2[2,])
ggplot() + geom_point(data = d, aes(x=height, y=weight),color= 'red', shape = 1) + theme_classic() + 
  geom_function(fun = f, linewidth = .7) + 
  geom_ribbon(data = df, aes(x = height, ymin = lower, ymax = upper), fill = 'grey', alpha = .55) +
  geom_ribbon(data = df2, aes(x = height, ymin = lower, ymax = upper), fill = 'grey', alpha = .2) + 
  ylim(c(26,70))

#Task: Can you add the OLS regression line to this? 


#################################
####logistic regression model

#Load data collected for this publication: https://doi.org/10.1186/s12936-020-03520-1
d2 <- readRDS('minimal_data.rds')
str(d2)
head(d2)

dat2 <- list(tf = d2$total_failures, LCF = d2$LCF, N = length(d2$LCF))
fit2 = stan('stan_model3.stan', data = dat2, iter = 4000, chains = 3)
print(fit2)

plot(fit2) # plot(fit, pars = c('a'))
traceplot(fit2)
samples2 <- extract(fit2)
hist(samples2$alpha)
hist(inv_logit(samples2$alpha))


