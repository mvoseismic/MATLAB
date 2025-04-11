function ws_plot_stack( w, p_times, sec_pre, sec_post, ninstack, norm, spec )
%
% Given a w structure with one channel, and an array of ptimes, 
% draws stacks of seismograms.
%
% Rod Stewart, SRC, 2010-12-17

sta = get( w(1), 'station' );
cha = get( w(1), 'component' );
stacha = sprintf( '%s %s', sta, cha );
data = get( w(1), 'data' );
datim_start = datenum( datestr( get( w(1), 'start' ) ) );
ndata = get( w(1), 'DATA_LENGTH' );
fs = get( w(1), 'freq' );

npicks = length( p_times );
pts_pre = sec_pre * fs;
pts_post = sec_post * fs;
npts = pts_pre + pts_post + 1;
nft = 2^nextpow2(npts);
Ydata = nan(npts, npicks);
Xtime = nan(npts,npicks);
Yfft = nan(nft/2+1, npicks);
Xfreq = nan(nft/2+1, npicks);
labels = repmat( '     ', npicks, 1 );

sec_in_day = 24.0 * 60.0 * 60.0;
y_limits = [0 ninstack+1];
t_limits = [-sec_pre sec_post];
f_limits = [0 fs/2];

y_mult = 0.5;

for ipic = 1:npicks
    if ~isnan(p_times(ipic))
            
        days_ptime = p_times(ipic) - datim_start;
        pts_ptime = days_ptime * sec_in_day * fs;
        pts_ptime = pts_ptime + 1;
        p1 = int32( pts_ptime) - pts_pre;
        p2 = int32( pts_ptime) + pts_post;
        Y = data(p1:p2)';
                
        labels(ipic,:) = datestr( p_times(ipic), 'MM:SS' );

        if norm
            Y = mean_norm_nan(Y);
        end
        Ydata(:,ipic) = Y;
        X = (0:length(data(p1:p2))-1) / fs;
        X = X - sec_pre;
        Xtime(:,ipic) = X;

        nY = length(Y);
        nft = 2^nextpow2(nY); % Next power of 2 from length of y
        Y = fft(Y,nft)/ndata;
        Y2 = 2*abs(Y(1:nft/2+1));
        Y2 = Y2 / max(Y2);
        f = fs/2*linspace(0,1,nft/2+1);
        nY2 = length(Y2);
        Yfft(1:nY2,ipic) = Y2;
        Xfreq(1:nY2,ipic) = f;
        
    end
end

Ydata = Ydata * y_mult;

nfig = ceil( npicks/ninstack );
figcount = 0;

for ifig = 1:nfig
            
    figure;
            
    figcount = figcount + 1;
            
    iev1 = (ifig-1)*ninstack+1;
    iev2 = iev1 + ninstack - 1;
    if iev2 > npicks
        iev2 = npicks;
    end
            
    LP = repmat( '     ', ninstack, 1 );
    LP(ninstack-(iev2-iev1):ninstack,:) = labels(iev1:iev2,:);
    LP = flipud( LP );

    if spec
        subplot(1,2,1);
    end
    XP = Xtime(:,iev1:iev2);
    YP = Ydata(:,iev1:iev2);
    plot_stack( XP, YP );
    xlim( t_limits );
    ylim( y_limits );
    title( stacha );
    xlabel( 'Time (seconds)' );
    set( gca, ...
        'YTick', (1:ninstack), ...
        'YTickLabel', LP );

    if spec
        subplot(1,2,2);
        XP = Xfreq(:,iev1:iev2);
        YP = Yfft(:,iev1:iev2);
        plot_stack( XP, YP );
        xlim( f_limits );
        ylim( y_limits );
        tit = 'Single-sided amplitude spectrum';
        title( tit );
        xlabel( 'Frequency (Hz)' );
        set( gca, ...
            'YTick', (1:ninstack), ...
            'YTickLabel', LP );
    end   
end

