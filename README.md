# Intro_to_Stan
*
This repository accompanies my training session **An Introduction to Bayesian Regression in Stan**. The materials are described in the slide deck *Stan_tutorial_Jan2023.pdf*

Stan is a widely used platform for statistical modeling and high-performance statistical computation. Amongst other things, it can perform full Bayesian statistical inference with MCMC sampling. It has been used to solve research problems in a range of scientific fields. 

Stan interfaces with the most popular data analysis languages (R, Python, shell, MATLAB, Julia, Stata) and runs on all major platforms (Linux, Mac, Windows). We'll be using the R interface (Rstan). Documentation can be found here: https://mc-stan.org/users/documentation/.

In addition to (fairly up-to-date) implementations of R & Rstudio, there are some additional packages you’ll need to install- please have a go at this before the session. Installing Stan can be tricky, as you will need a C++ toolchain. There is some guidance on installation here: https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
 
We will also use some functions from the rethinking package, which you should install after installing RStan. This package is not available on CRAN, but can be installed here: https://github.com/rmcelreath/rethinking
