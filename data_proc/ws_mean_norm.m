function wout = ws_mean_norm( win )
%
% Takes a waveform structure and removes mean and normalises the data
%
% Rod Stewart, 2009-06-13
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data = mean_norm_nan( data );
    wout(ii) = set( wout(ii), 'data', data );
end

return
