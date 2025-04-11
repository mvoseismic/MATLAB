function ws_plot_3c_pm( w, s, f, start, stop, timebase, stalabels, pt1, pt2, pt3 )
%
% Plots a 3C set together
%
% Rod Stewart, 2011-01-10

left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');
wid_seis = 0.55 * pos(width);
wid_part = (pos(width) - wid_seis)/2.0;
ht_third = pos(height) / 3.0;

posE = [ pos(left), pos(bottom)+2*ht_third, wid_seis, ht_third ];
posN = [ pos(left), pos(bottom)+ht_third, wid_seis, ht_third ];
posZ = [ pos(left), pos(bottom), wid_seis, ht_third ];
posPartEZ1 = [ pos(left)+ wid_seis, pos(bottom)+2*ht_third, wid_part, ht_third ];
posPartNZ1 = [ pos(left)+ wid_seis, pos(bottom)+ht_third, wid_part, ht_third ];
posPartEN1 = [ pos(left)+ wid_seis, pos(bottom), wid_part, ht_third ];
posPartEZ2 = [ pos(left)+ wid_seis+wid_part, pos(bottom)+2*ht_third, wid_part, ht_third ];
posPartNZ2 = [ pos(left)+ wid_seis+wid_part, pos(bottom)+ht_third, wid_part, ht_third ];
posPartEN2 = [ pos(left)+ wid_seis+wid_part, pos(bottom), wid_part, ht_third ];

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
 
wc = ws_mean_norm_3c(wc);

ndata3ca = pt2 - pt1 + 1;
data3ca = nan(ndata3ca,4);
ndata3cb = pt3 - pt2 + 1;
data3cb = nan(ndata3cb,4);
    
for ii = 1:3
    
    start = get( wc(ii), 'START_STR' );
    tit = sprintf( 'Start time %s', start );
    npts = max( get( wc(ii), 'DATA_LENGTH' ) );
    sps = max( get( wc(ii), 'FREQ' ) );
    data = get(wc(ii), 'DATA' );
    tdata = (0:npts-1);
    
    if strcmp( timebase, 'minutes' )
        tdata = tdata / (sps * 60.0);
        t_label = 'Time (minutes)';
    elseif strcmp( timebase, 'hours' )
        tdata = tdata / (sps * 60.0 * 24.0);
        t_label = 'Time (hours)';
    elseif strcmp( timebase, 'seconds' )
        tdata = tdata / sps;
        t_label = 'Time (seconds)';
    end
    tlong = tdata(length(tdata)) - tdata(1);
    
    data3ca(:,ii) = data(pt1:pt2);
    data3ca(:,4) = tdata(pt1:pt2);
    data3cb(:,ii) = data(pt2:pt3);
    data3cb(:,4) = tdata(pt2:pt3);
    
    switch ii
        case 1
            subplot('position',posE);
        case 2
            subplot('position',posN);
        case 3
            subplot('position',posZ);
    end
 
    plot( tdata, data, 'k-' );
    hold on;
    plot( data3ca(:,4), data3ca(:,ii), 'r-' );
    if pt3 > pt2
        plot( data3cb(:,4), data3cb(:,ii), 'b-' );
    end
    
    switch ii
        case 1
            title( tit );
            xlabel( '' );
            set( gca, 'XTick', [] );
        case 2
            xlabel( '' );
            set( gca, 'XTick', [] );
        case 3
            xlabel( t_label );
    end
    
    ylabel( '' );
    set( gca, 'YTick', [] );
    ylim( [-1 1] );
   
    
    xstring = 0.02 * tlong;
    
    if stalabels
        
        sta = get( wc(ii), 'STATION' );
        cha = get( wc(ii), 'COMPONENT' );
        stacha = sprintf( '%s %s', sta, cha );
        
        switch ii
            case 1
                stachaE = stacha;
            case 2
                stachaN = stacha;
            case 3
                stachaZ = stacha;
        end
    
        ystring = 0.7;
        text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
    end
    
%    grid on;

end

plot_part( posPartEZ1, data3ca(:,1), data3ca(:,3),'r-', stachaE, stachaZ );
plot_part( posPartNZ1, data3ca(:,2), data3ca(:,3),'r-', stachaN, stachaZ );
plot_part( posPartEN1, data3ca(:,1), data3ca(:,2),'r-', stachaE, stachaN );

if pt3 > pt2
    plot_part( posPartEZ2, data3cb(:,1), data3cb(:,3),'b-', stachaE, stachaZ );
    plot_part( posPartNZ2, data3cb(:,2), data3cb(:,3),'b-', stachaN, stachaZ );
    plot_part( posPartEN2, data3cb(:,1), data3cb(:,2),'b-', stachaE, stachaN );
end

function plot_part( posit, dataX, dataY, line_spec, labelX, labelY )

    subplot('position',posit);
    plot(dataX,dataY,line_spec);
    axis equal;
    xlim([-1 1]);
    ylim([-1 1]);
    Xlabel( '' );
    ylabel( '' );
    set( gca, 'XTick', [] );
    set( gca, 'YTick', [] );
    xstring = 0.9;
    ystring = -0.9;
    text(xstring,ystring,labelX,...
        'HorizontalAlignment','right',...
        'VerticalAlignment','middle',...
        'FontSize', 8, ...
        'BackgroundColor',[.7 .9 .7]);
    xstring = -0.9;
    ystring = 0.9;
    text(xstring,ystring,labelY,...
        'HorizontalAlignment','right',...
        'VerticalAlignment','middle',...
        'Rotation', 90, ...
        'FontSize', 8, ...
        'BackgroundColor',[.7 .9 .7]);

return