function ws_plot( w, s, f, start, stop, timebase, stalabels, c3, norm )
%
% Plots a bunch of WS files together
%
% Rod Stewart, 2009-06-16

if start
    stime_start = start;
else
    stime_start = min( get(w, 'Start' ) );
end

if stop
    stime_stop = stop;
else
    npts = max( get( w, 'DATA_LENGTH' ) );
    sps = max( get( w, 'FREQ' ) );    
    stime_stop = stime_start + (npts-1)/(24.0*60.0*60.0*sps);
end

if c3
    set(    0, 'DefaultAxesColorOrder', [.5 0 0;0 0 .5;0 .5 0] );
%    set(    0, 'DefaultAxesColorOrder', [0 0 1] );
else
    set(    0, 'DefaultAxesColorOrder', [0 0 1] );
end

    if isobject( s )
        [IsInList, whereInList] = ismember(w,s);

        wc = w(IsInList);
    else
        wc = w;
    end
    
    
    if stop > start
        wc = extract( wc, 'TIME', start, stop );
    end

    if isobject( f )
        wc = fillgaps( wc, 'meanAll');
        wc = filtfilt(f,wc);
    end
 
    if norm
        if c3
           wc = ws_mean_norm_3c(wc);
        else
            wc = ws_mean_norm(wc);
        end
    else
        wc = ws_mean_norm_1(wc);
    end
    
    offsets = [];
    wc = ws_add_offset( wc, offsets );

    if strcmp( timebase, 'minutes' )
        plot(wc,'Xunit','minutes');
        tlong = (stime_stop - stime_start) * (24.0*60.0);
    elseif strcmp( timebase, 'hours' )
        plot(wc,'Xunit','hours');
        tlong = (stime_stop - stime_start) * 24.0;
    elseif strcmp( timebase, 'seconds' )
        plot(wc,'Xunit','seconds');
        tlong = (stime_stop - stime_start) * (24.0*60.0*60.0);
    else
        plot(wc,'Xunit','seconds');
        tlong = (stime_stop - stime_start) * (24.0*60.0*60.0);
    end
    
    start = get( wc(1), 'START_STR' );
    
    tit = sprintf( 'Start time %s', start );
    title( tit );
    
    nsta = length( wc );
    
    ylim([-2*nsta+1 1]);
    ylabel( '' );
    set( gca, 'YTick', [] );
   
    
    npts = max( get( wc, 'DATA_LENGTH' ) );
    sps = max( get( wc, 'FREQ' ) );
        
    xlim([0 tlong]);
    
    nsta = length(wc);
    
    xstring = 0.02 * tlong;
    
    switch stalabels
        case 1
            for ii = 1:nsta
        
                sta = get( wc(ii), 'STATION' );
                cha = get( wc(ii), 'COMPONENT' );
                stacha = sprintf( '%s %s', sta, cha );
    
                ystring = -2.0*(ii-1) + 0.5;
                text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
            end
        case 2
            for ii = 1:nsta
        
                
                stacha = datestr( get( wc(ii), 'start' ), 'mm/dd HH:MM' );
    
                ystring = -2.0*(ii-1) + 0.5;
                text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
            end
    end
    
   
return