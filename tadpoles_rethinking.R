library(rethinking)
library(ggplot2)

d <- readRDS('data/d_partial_pooling.rds')
str(d)

ggplot(d) + geom_point(aes(x = tank, y = surv/density, color = factor(density))) +
  theme_classic() + ylab('Proportion survived') + labs(color = 'Tadpole\ndensity') + 
  geom_vline(xintercept = c(16.5,32.5), alpha = .4, color = 'slateblue')

#Model 1: complete pooling (assumes tanks are identical)
mod1 <- ulam(
  alist(
   surv ~ dbinom(density,p),
   logit(p) <- a,
   a ~ dnorm(0,1.5)
  ),
  data = d, chains = 3, cores = 3, iter = 3000, log_lik = T
)
stancode(mod1)
precis(mod1, depth = 1)

#average proportion survived, across all tanks:
es1 <- extract.samples(mod1)
quantile(inv_logit(es1$a), probs = c(0.025,0.5,0.975))

#Model 2: no pooling (assumes tanks are each completely distinct: 
#by looking at Tank #1, we learn nothing about Tank #2)
mod2 <- ulam(
  alist(
    surv ~ dbinom(density,p),
    logit(p) <- a[tank],
    a[tank] ~ dnorm(0,1.5)
  ),
  data = d, chains = 3, cores = 3, iter = 3000, log_lik = T
)
stancode(mod2)
precis(mod2, depth = 2)

#Model 3: partial pooling. There is some between-tank variation,
# the magnitude of which the model will try to learn
mod3 <- ulam(
  alist(
    surv ~ dbinom(density,p),
    logit(p) <- a0 + a[tank],
    a0 ~ dnorm(0,1.5),
    a[tank] ~ dnorm(0, sigma_a),
    sigma_a ~ dexp(1)
  ),
  data = d, chains = 3, cores = 3, iter = 3000, log_lik = T
)
stancode(mod3)
precis(mod3, depth = 1)
precis(mod3, depth = 2) # to see all parameter estimates

#extract samples
es3 <- extract.samples(mod3)
hist(es3$sigma_a)

### Exercise for you: plot model predictions for all the tanks, alongside the data
# (you can do this in turn for each model). What do you notice?

compare(mod1,mod2,mod3, func = WAIC)

#include predation
d$pred_num <- ifelse(d$pred=='pred', 1, 0)
mod4 <- ulam(
  alist(
    surv ~ dbinom(density,p),
    logit(p) <- a0 + a[tank] + b*pred_num,
    a0 ~ dnorm(0,1.5),
    b ~ dnorm(0,1),
    a[tank] ~ dnorm(0, sigma_a),
    sigma_a ~ dexp(1)
  ),
  data = d, chains = 3, cores = 3, iter = 3000, log_lik = T
)
stancode(mod4)
precis(mod4, depth = 1)

compare(mod1,mod2,mod3,mod4, func = WAIC)
