function wout = ws_filtfilt( win, f )
%
% Applies filtfilt to filterobject, allowing for nans
%
% Rod Stewart, 2011-01-26
%

wout = win;

wout = ws_deflatline( wout );
wout = ws_denan( wout );

wout = filtfilt( f, wout );

nsta = length( win );

for ii = 1:nsta
    
    data1 = get( wout(ii), 'data' );
    data2 = get( win(ii), 'data' );
    data1( isnan(data2) ) = nan; 

    wout(ii) = set( wout(ii), 'data', data1 );
    
end

return
