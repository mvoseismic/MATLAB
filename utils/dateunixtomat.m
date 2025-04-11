function mdnum = dateunixtomat( dnum )
%
% Converts Unix serial date number to MATLAB serial date number
%
% Rod Stewart, 2010-11-01

dnum = dnum / (24.0*60.0*60.0);

mdnum = dnum + datenum( '01-Jan-1970 00:00:00' );