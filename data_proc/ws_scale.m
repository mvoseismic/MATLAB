function wout = ws_scale( win, scales )
%
% Takes a waveform structure and scales each channel
% Rod Stewart, 2009-06-13
%

wout = win;

nsta = length( win );
nsca = length( scales );

if nsca == 1
    scales = scales * ones( nsta, 1 );
elseif nsta ~= nsca
    script_status( 'ws_scale', 'Arrays', 'unmatched' );
    script_status( 'ws_scale', 'nsta', num2str(nsta) );
    script_status( 'ws_scale', 'nsca', num2str(nsca) );
    return
end

for ii = 1:nsta
    data = get(win(ii),'data');
    data = data * scales(ii);
    wout(ii) = set( wout(ii), 'data', data );
end

return
