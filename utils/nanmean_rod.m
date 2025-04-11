function out = nanmean( Data )
%
% calculates mean of a vector or array with NaNs in it
%
% Rod Stewart, SRC 2008-09-04

ID = isnan( Data );

nuData = Data( ~ID );

out = mean( nuData );