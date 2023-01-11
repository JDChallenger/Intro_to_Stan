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
  vector[N] mu;
  a ~ normal(0,5);
  b ~ normal(0,5); //lognormal(0,1);
  sigma ~ exponential(1);
  //r[N] mu;
  mu = a + b*(H - Hbar);
  W ~ normal(mu, sigma);
  //equivalently
  //for (i in 1:N) {
  //  W[i] ~ normal(a + b*(H[i] - Hbar), sigma);
  //}
}
