function wout = ws_denan( win )
%
% Takes a waveform structure and replaces any nans in data with 0
%
% Rod Stewart, 2011-01-26
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data( isnan( data ) ) = 0.0;
    wout(ii) = set( wout(ii), 'data', data );
end

return
