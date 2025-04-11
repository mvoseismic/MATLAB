function wout = ws_tidy( win )
%
% Takes a waveform structure and attempts to clean it up
%
% Rod Stewart, 2012-06-05
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data = data - nanmean_rod( data );
    lengths(ii) = length( data );
    freqs(ii) = get( win(ii), 'freq' );
    wout(ii) = set( wout(ii), 'data', data );
end

length_max = max( lengths );
freq_max = max( freqs );

for ii = 1:nsta
    
    if lengths(ii) < length_max
        
        message = sprintf( 'Chan %d, only %d points, replacing with %d zeros', ...
            ii, lengths(ii), length_max );
        m_progress( 'ws_tidy', 'W', message );
        data = zeros( length_max, 1 );
        wout(ii) = set( wout(ii), 'data', data );
    end
    
    if freqs(ii) < freq_max
        
        message = sprintf( 'Chan %d, changing frequency', ...
            ii );
        m_progress( 'ws_tidy', 'W', message );
        wout(ii) = set( wout(ii), 'freq', freq_max );
    end
    
end

return
