function ts_out = ts_rmean( ts_in, nrmean )
%
% Does running mean filter for time series data, allowing for NaNs
%
% Rod Stewart, 2009-08-12

ts_out = ts_in;

data = get( ts_in, 'Data' );

data = nan_rmean( data', nrmean );

set( ts_out, 'Data', data' );

return;