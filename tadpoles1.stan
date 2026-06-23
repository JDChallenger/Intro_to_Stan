data{
    array[48] int tank;
     vector[48] propsurv;
    array[48] int size;
    array[48] int pred;
    array[48] int density;
    array[48] int surv;
}
parameters{
     real a;
}
model{
     real p;
    a ~ normal( 0 , 2 );
    p = a;
    p = inv_logit(p);
    surv ~ binomial( density , p );
}
generated quantities{
    vector[48] log_lik;
     real p;
    p = a;
    p = inv_logit(p);
    for ( i in 1:48 ) log_lik[i] = binomial_lpmf( surv[i] | density[i] , p );
}
