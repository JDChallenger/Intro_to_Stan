data {
  int<lower=0> N;
  vector[N] H;
  vector[N] W;
  real Hbar;
}
parameters {
  real a;
  real b;
  real<lower=0> sigma;
}
model {
  a ~ normal(0,5);
  b ~ normal(0,5); //lognormal(0,1);
  sigma ~ exponential(1);
  W ~ normal(a + b*(H - Hbar), sigma);
  //equivalently
  //for (i in 1:N) {
  //  W[i] ~ normal(a + b*(H[i] - Hbar), sigma);
  //}
}
