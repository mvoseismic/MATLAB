function ts_out = ts_denan( ts_in )
%
% Replaces NaNs in a timeseries object with 0's
%

ts_out = ts_in;

data = get( ts_out, 'data' );
data( isnan(data) ) = 0;
ts_out = set( ts_out, 'data', data );

return