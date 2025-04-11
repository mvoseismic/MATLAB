function rmsout = rms( data );
% Returns RMS of a chunk of data
%
% Rod Stewart, 2009-04-14
%
% Bugs, etc
%
% 2009-06-09 Modified to cope with NaNs in array
% 2017-11-25 Modified to use nanmean_rod instead of nanmean

ndata = length( data );

datamean = nanmean_rod( data );

data = data - datamean;

datasquare = data.^2;

rmsout = sqrt( nanmean_rod( datasquare ) );
