data{
     vector[48] propsurv;
    array[48] int size;
    array[48] int pred;
    array[48] int density;
    array[48] int surv;
    array[48] int tank;
}
parameters{
     vector[48] a;
}
model{
     vector[48] p;
    a ~ normal( 0 , 1 );
    for ( i in 1:48 ) {
        p[i] = a[tank[i]];
        p[i] = inv_logit(p[i]);
    }
    surv ~ binomial( density , p );
}
generated quantities{
    vector[48] log_lik;
     vector[48] p;
    for ( i in 1:48 ) {
        p[i] = a[tank[i]];
        p[i] = inv_logit(p[i]);
    }
    for ( i in 1:48 ) log_lik[i] = binomial_lpmf( surv[i] | density[i] , p[i] );
}
