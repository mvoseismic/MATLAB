function ws_plot_allz( w )

    stachans = ws_any('anyz');

    [IsInList, whereInList] = ismember(w,stachans);

    wc = w(IsInList);

    wc = ws_mean_norm(wc);

    offsets = [];
    wc = ws_add_offset( wc, offsets );

%    figure;

    plot(wc,'Xunit','minutes');
    
    hold on;
    
    start = get( w(1), 'START_STR' );
    
    tit = sprintf( 'MVO *Z, starting %s', start );
    title( tit );
    
    nsta = length( wc );
    
    ylim([-2*nsta+1 1]);
    ylabel( '' );
    set( gca, 'YTick', [] );
    
    xlimits = get(gca,'XLim');
    xstring = xlimits(1) + 0.02*(xlimits(2)-xlimits(1));
   
    nsta = length(wc);
    
    
    for ii = 1:nsta
        
        sta = get( wc(ii), 'STATION' );
        cha = get( wc(ii), 'COMPONENT' );
        stacha = sprintf( '%s %s', sta, cha );
        
        ystring = -2.0*(ii-1) + 0.3;
        text(xstring,ystring,stacha);
    end
   
  
    return
