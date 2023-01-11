library(ggplot2)
library(rstan)
library(rethinking)

#'dat' should be loaded loaded in the tutorial script

m1 <- ulam(
  alist(
    W ~ dnorm(mu, sigma),
    mu <- alpha + beta*(H-Hbar),
    alpha ~ dnorm(0,5),
    beta ~ dnorm(0,5),
    sigma ~ dexp(1)
  ),
  data = dat, chains = 2, cores = 2, iter = 4000)
stancode(m1)
precis(m1)

#logistic regression model. 'dat2' should be loaded in the tutorial script

m2 <- ulam(
  alist(
    LCF ~ dbinom(tf, p),
    logit(p) <- alpha,
    alpha ~ dnorm(0,2)
  ),
  data = dat2, chains = 2, cores = 2, iter = 4000)
stancode(m2)
precis(m2)
es <- extract.samples(m2)