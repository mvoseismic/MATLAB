function nd = datenum_syr( yr )
%
% rerurns serial day from a serial year number, ie 1995.6
%
% Rod Stewart, 2008-09-25

yrfrac = rem( yr, 1 );
year = yr - yrfrac;

nd0 = datenum( year, 1, 1 );
nd1 = datenum( year+1, 1, 1 ) - nd0;

nd = nd0 + yrfrac * nd1;