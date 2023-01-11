data {
  int<lower=0> N;
  array[N] int<lower=0> LCF;
  array[N] int<lower=0> tf;
}
parameters {
  real alpha;
}
model {
  real p;
  alpha ~ normal(0,2);
  p = inv_logit(alpha);
  LCF ~ binomial(tf, p);
}
