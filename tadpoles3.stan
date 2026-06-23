data{
     vector[48] propsurv;
    array[48] int size;
    array[48] int pred;
    array[48] int density;
    array[48] int surv;
    array[48] int tank;
}
parameters{
     real a0;
     vector[48] a;
     real<lower=0> sigma_a;
}
model{
     vector[48] p;
    sigma_a ~ exponential( 1 );
    a ~ normal( 0 , sigma_a );
    a0 ~ normal( 0 , 2 );
    for ( i in 1:48 ) {
        p[i] = a0 + a[tank[i]];
        p[i] = inv_logit(p[i]);
    }
    surv ~ binomial( density , p );
}
generated quantities{
    vector[48] log_lik;
     vector[48] p;
    for ( i in 1:48 ) {
        p[i] = a0 + a[tank[i]];
        p[i] = inv_logit(p[i]);
    }
    for ( i in 1:48 ) log_lik[i] = binomial_lpmf( surv[i] | density[i] , p[i] );
}
