function wout = ws_gained( win )
%
% Takes a waveform structure and applies corrections for gain to
% each channel
%
% Rod Stewart, 2011-01-26
%

wout = win;

nsta = length( win );
scales = ones( nsta, 1 );

for ii = 1:nsta
    
    sta = get( win(ii), 'station' );
    cha = get( win(ii), 'channel' );
    datim = get( win(ii), 'start' );
    
    scales(ii) = sta_getgain( sta, cha, datim );
    
end

scales = 1.0 ./ scales;

wout = ws_scale( win, scales );

for ii = 1:nsta
    wout(ii) = set( wout(ii), 'Units', 'V/m/s?' );
end

return
