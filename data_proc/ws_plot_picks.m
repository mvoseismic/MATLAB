function ws_plot_picks( w, s, f, start, stop, timebase, stalabels, c3, norm, picks )
%
% Plots a bunch of WS files together with picks in an array
%
% Rod Stewart, 2012-05-24

ws_plot( w, s, f, start, stop, timebase, stalabels, c3, norm );
hold on;

x_limits = get( gca, 'XLim' );
x_range = x_limits(2) - x_limits(1);
y_limits = get( gca, 'YLim' );
y_range = y_limits(2) - y_limits(1);

%fprintf( 'x_limits: %4.1f  %4.1f        x_range: %4.1f\n', x_limits, x_range );
%fprintf( 'y_limits: %4.1f  %4.1f        y_range: %4.1f\n', y_limits, y_range );

[nsta,npic] = size( picks );

ystep = y_range/nsta;

for ista = 1:nsta
   
    ysta = y_limits(2) - (ista*ystep) + 1.0;
    yline = [ysta-1 ysta+1];
    
    %fprintf( 'ista: %d      ysta: %5.1f      yline: %5.1f  %5.1f\n', ...
    %    ista, ysta, yline );
    
    start = get( w(ista), 'start' );
    freq = get( w(ista), 'freq' );
    ndata = length( get( w(ista), 'data' ) );
    long = (ndata-1) / (freq*24.0*60.0*60.0);
    %fprintf( 'long: %9.3e\n', long );
        
    for ipic = 1:npic
        
        xpic = picks( ista, ipic );
        xpic = (xpic-start) / long;
        xpic = x_limits(1) + xpic*x_range;
        %fprintf( 'xpic: %9.3e\n', xpic );
        
        xline = [xpic xpic];
        
        plot( xline, yline, 'r-' );
        
    end
end

return