#install rstan
# Note: this'll need a working Rtools toolchain, if you're on a Windows PC
# these instructions may be useful, for the toolchain: https://mc-stan.org/docs/cmdstan-guide/installation.html#cpp-toolchain
install.packages("rstan", repos = "https://cloud.r-project.org/", 
                 dependencies = TRUE)

####################################################
# Optional (but useful for helper functions)
# we will also use the rethinking package, as an easy-to-use wrapper for stan
# this package now uses cmdstanr ("a lightweight interface to Stan for 
# R users that provides an alternative to the traditional RStan interface.")
# see: https://mc-stan.org/cmdstanr/articles/cmdstanr.html#comparison-with-rstan

# we recommend running this in a fresh R session or restarting your current session
install.packages("cmdstanr", repos = c('https://stan-dev.r-universe.dev', getOption("repos")))

library(cmdstanr)
#after you download library, still need to install it
install_cmdstan()

#then these packages
install.packages(c("coda","mvtnorm","devtools","loo","dagitty"))

#then rethinking
devtools::install_github("rmcelreath/rethinking")


