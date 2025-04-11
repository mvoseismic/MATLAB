function moment = ml2moment( ml )

mw = 0.6667 * ml + 1.15;
moment = 10 ^ (1.5 * (mw + 6.07));
moment = moment / 1000000000000.0;