function ws_plot_3c( w, s, f, start, stop, timebase, stalabels, pt1, pt2, clip )
%
% Plots a 3C set together, with particle motion plots
%
% Rod Stewart, 2011-01-10


left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');
ht_third = pos(height) / 3.0;
wid_seis = 0.8 * pos(width);
wid_part = pos(width) - wid_seis;

posE = [ pos(left),     pos(bottom)+2*ht_third,     wid_seis,     ht_third ];
posN = [ pos(left),     pos(bottom)+ht_third,       wid_seis,     ht_third ];
posZ = [ pos(left),     pos(bottom),                wid_seis,     ht_third ];
posPEZ = [ pos(left)+wid_seis,    pos(bottom)+2*ht_third, wid_part, ht_third ];
posPNZ = [ pos(left)+wid_seis,    pos(bottom)+ht_third,   wid_part, ht_third ];
posPEN = [ pos(left)+wid_seis,    pos(bottom),            wid_part, ht_third ];

part_linespec = 'r-';

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

if pt1 == pt2
    pt1 = 1;
    pt2 = npts;
end
nptspt = pt2-pt1+1;
data3c = nan(nptspt,4);

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

if clip ~= 0.0
    wc = ws_clip( wc, clip );
    wc = ws_mean_norm_3c(wc);
end

    
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
    
    data3c(:,ii) = data(pt1:pt2);
    data3c(:,4) = tdata(pt1:pt2);
        
    switch ii
        case 1
            subplot('position',posE);
        case 2
            subplot('position',posN);
        case 3
            subplot('position',posZ);
    end
 
    plot( tdata, data, 'k-' );
    if nptspt > 0
        hold on;
        plot(data3c(:,4),data3c(:,ii), part_linespec );
    end
    
    switch ii
        case 1
            title( tit );
            xlabel( '' );
            set( gca, 'XTickLabel', [] );
        case 2
            xlabel( '' );
            set( gca, 'XTickLabel', [] );
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
    
    grid on;

end

plot_part( posPEZ, data3c(:,1), data3c(:,3), 'r-', stachaE, stachaZ );
plot_part( posPNZ, data3c(:,2), data3c(:,3), 'r-', stachaN, stachaZ );
plot_part( posPEN, data3c(:,1), data3c(:,2), 'r-', stachaE, stachaN );

function plot_part( pos_part, dataX, dataY, line_spec, labelX, labelY )

    subplot( 'position', pos_part );
    
    ndata = length( dataX );
    
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