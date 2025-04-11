function ts_out = ts_add_y( ts_in, offset )
%
% Simply adds a fixed Y value to the data in a time series object
%

ts_out = ts_in;

data = get( ts_out, 'data' );
data = data + offset;
ts_out = set( ts_out, 'data', data );

return