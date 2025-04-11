function wout = ws_demean( win )
%
% Takes a waveform structure and removes mean from each trace
%
% Rod Stewart, 2009-06-13
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data = data - nanmean_rod( data );
    wout(ii) = set( wout(ii), 'data', data );
end

return
