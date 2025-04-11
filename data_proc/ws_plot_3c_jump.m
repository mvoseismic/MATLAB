function ws_plot_3c_jump( w, s, f, start, stop, timebase, stalabels, pt1, pt2, ptj, clip )
%
% Plots a 3C set together, with jumped particle motion plots
%
% Rod Stewart, 2011-01-10


left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');
ht_quarter = pos(height) / 4.0;
trim_Z = ht_quarter * 0.3;
posZ = [ pos(left),     pos(bottom)+3*ht_quarter+trim_Z,     pos(width),     ht_quarter-trim_Z ];

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

if ptj == 0
    ptj = nptspt;
end
njump = ceil( nptspt/ptj );

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
        
    if ii == 2
        
        subplot('position',posZ);
 
        plot( tdata, data, 'k-' );
        if nptspt > 0
            hold on;
            plot(data3c(:,4),data3c(:,ii), part_linespec );
            for ij = [pt1:ptj:pt2]
                X = [tdata(ij) tdata(ij)];
                Y = [-1 1];
                plot( X, Y, 'b-' );
            end
            X = [tdata(pt2) tdata(pt2)];
            Y = [-1 1];
            plot( X, Y, 'b-' );
        end
        title( tit );
        xlabel( t_label );

        ylabel( '' );
        set( gca, 'YTick', [] );
        ylim( [-1 1] );
   
    end
    
    
    
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
        
        if ii == 2
    
            xstring = 0.02 * tlong;
            ystring = 0.7;
            text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
        end
    end
    
    grid on;

end


wid_part = pos(width)/njump;


for ii = 1:njump
    
    p1 = 1 + (ii-1)*ptj;
    p2 = p1 + ptj;
    if p2 > nptspt
        p2 = nptspt;
    end
    
    posPEZ = [  pos(left)+wid_part*(ii-1), ...
                pos(bottom)+2*ht_quarter, wid_part, ht_quarter ];
    dataX = data3c(p1:p2,1);
    dataY = data3c(p1:p2,3);
    plot_part( posPEZ, dataX, dataY, part_linespec, stachaE, stachaZ );
    
    posPNZ = [  pos(left)+wid_part*(ii-1), ...
                pos(bottom)+ht_quarter, wid_part, ht_quarter ];
    dataX = data3c(p1:p2,2);
    dataY = data3c(p1:p2,3);
    plot_part( posPNZ, dataX, dataY, part_linespec, stachaN, stachaZ );
    
    posPEN = [  pos(left)+wid_part*(ii-1), ...
                pos(bottom), wid_part, ht_quarter ];
    dataX = data3c(p1:p2,1);
    dataY = data3c(p1:p2,2);
    plot_part( posPEN, dataX, dataY, part_linespec, stachaE, stachaN );
    
end


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