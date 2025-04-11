function ws_plot_stack_multi( w, p_times, sec_pre, sec_post, ninstack, norm, label )
%
% Given a w structure with many channels, and an array of ptimes, 
% draws stacks of seismograms.
%
% Rod Stewart, SRC, 2010-12-17

sta = get( w(1), 'station' );
cha = get( w(1), 'component' );
stacha = sprintf( '%s %s', sta, cha );
fs = get( w(1), 'freq' );

npicks = length( p_times );
pts_pre = int32( sec_pre * fs );
pts_post = int32( sec_post * fs );
npts = pts_pre + pts_post + 1;
%nft = 2^nextpow2(npts);
Ydata = nan(npts, npicks);
Xtime = nan(npts,npicks);
%Yfft = nan(nft/2+1, npicks);
%Xfreq = nan(nft/2+1, npicks);
labels = repmat( '     ', npicks, 1 );

sec_in_day = 24.0 * 60.0 * 60.0;
y_limits = [0 ninstack+1];
t_limits = [-sec_pre sec_post];
%f_limits = [0 fs/2];

y_mult = 0.5;

for ipic = 1:npicks
    if ~isnan(p_times(ipic))
            
        data = get( w(ipic), 'data' );
        datim_start = get( w(ipic), 'start' );
        ndata = get( w(ipic), 'DATA_LENGTH' );
        
        days_ptime = p_times(ipic) - datim_start;
        pts_ptime = days_ptime * sec_in_day * fs;
        pts_ptime = pts_ptime + 1;
        p1 = int32( pts_ptime) - pts_pre;
        if p1 <= 0
            p1a = 1;
            p1x = 0 - p1 + 2;
        else
            p1a = p1;
            p1x = 1;
        end
        
        p2 = int32( pts_ptime) + pts_post;
        if p2 > ndata
            p2a = ndata;
            p2x = npts - (p2 - ndata);
        else
            p2a = p2;
            p2x = npts;
        end
        
        Y = nan(npts, 1);
        Y(p1x:p2x) = data(p1a:p2a)';
        
        switch label
            case 'time'
                labels(ipic,:) = datestr( p_times(ipic), 'MM:SS' );
            otherwise
        end

        if norm
            Y = mean_norm_nan(Y);
        end
        Ydata(:,ipic) = Y;
        X = (0:length(Y)-1) / fs;
        X = X - sec_pre;
        Xtime(:,ipic) = X;

        %{
        nY = length(Y);
        nft = 2^nextpow2(nY); % Next power of 2 from length of y
        Y = fft(Y,nft)/ndata;
        Y2 = 2*abs(Y(1:nft/2+1));
        Y2 = Y2 / max(Y2);
        f = fs/2*linspace(0,1,nft/2+1);
        nY2 = length(Y2);
        Yfft(1:nY2,ipic) = Y2;
        Xfreq(1:nY2,ipic) = f;
        %}
        
    end
end

Ydata = Ydata * y_mult;

nfig = ceil( npicks/ninstack );
figcount = 0;

for ifig = 1:nfig
            
    %figure;
            
    figcount = figcount + 1;
            
    iev1 = (ifig-1)*ninstack+1;
    iev2 = iev1 + ninstack - 1;
    if iev2 > npicks
        iev2 = npicks;
    end
            
    LP = repmat( '     ', ninstack, 1 );
    LP(ninstack-(iev2-iev1):ninstack,:) = labels(iev1:iev2,:);
    LP = flipud( LP );

%    if spec
%        subplot(1,2,1);
%    end

    XP = Xtime(:,iev1:iev2);
    YP = Ydata(:,iev1:iev2);
    plot_stack( XP, YP );
    xlim( t_limits );
    ylim( y_limits );
    title( stacha );
    xlabel( 'Time (seconds)' );
    set( gca, ...
        'XGrid','on', ...
        'YTick', (1:ninstack), ...
        'YTickLabel', LP );

    %{
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
    %}
        
end

