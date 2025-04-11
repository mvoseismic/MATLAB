function ws_stack( w, p_times, sec_pre, sec_post, norm )
%
% Given a w structure with many channels, and an array of ptimes, 
% calculates stack, and returns it in a w structure
%
% Rod Stewart, SRC, 2011-10-27

fs = get( w(1), 'freq' );

npicks = length( p_times );
pts_pre = int32( sec_pre * fs );
pts_post = int32( sec_post * fs );
npts = pts_pre + pts_post + 1;
Ydata = nan(npts, npicks);
Xtime = nan(npts,npicks);

sec_in_day = 24.0 * 60.0 * 60.0;

label = 'time';

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
        else
            Y = Y - nanmean(Y);
        end
        
        Ydata(:,ipic) = Y;
        X = (0:length(Y)-1) / fs;
        X = X - sec_pre;
        Xtime(:,ipic) = X;

    end
 
end

