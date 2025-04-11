function out = nanmedian( Data, nmin )
%
% calculates median of a vector or array with NaNs in it
%
% If nmin is set, it is the minimum no of points used to calc a median,
% NaN otherwise
%
% Rod Stewart, SRC 2008-09-04

if nargin == 1
    nmin = 1;
end

ID = isnan( Data );

nuData = Data( ~ID );
n_notnan = sum( ~ID );

if n_notnan >= nmin
    out = median( nuData );
else
    out = NaN;
end