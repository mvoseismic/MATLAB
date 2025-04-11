function mom = moment( mag )

    mw = 0.6667 * mag + 1.15;
    mom = 10 ^ (1.5 * (mw + 6.07));
    
return    
