library(ggplot2)
library(rstan)
library(rethinking)

data("Howell1")
d <- Howell1[Howell1$age>=18,]

ggplot(d) + geom_point(aes(x=height, y=weight),color= 'red') + theme_classic()

#lm(weight ~ height, data = d)

dat <- list(H = d$height, W = d$weight, Hbar = mean(d$height))

lookup("dnorm")

m1 <- ulam(
  alist(
    W ~ dnorm(mu, sigma),
    mu <- alpha + beta*(H-Hbar),
    alpha ~ dnorm(0,2),
    beta ~ dnorm(0,4),
    sigma ~ dexp(1)
  ),
data = dat, chains = 2, cores = 2, iter = 5000)
stancode(m1)
precis(m1)
