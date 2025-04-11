function ws_specgram( ws, nfft, noverlap, window, atop, clim, flim, linorlog, taxis, rsammin, rsamsmooth )
%
% Plots a single waveform object as a spectrogram
%
% Rod Stewart, 2009-08-15

npts = get( ws, 'DATA_LENGTH' );
fs = get( ws, 'FREQ' );

sta = get( ws, 'STATION' );
cha = get( ws, 'COMPONENT' );
stacha = sprintf( '%s %s',  sta, cha );

data = get( ws, 'data' );
data = mean_norm_nan(data);
tdata = 1:npts;
tdata = tdata -1;
tdata = tdata / fs;

switch taxis
    case 'seconds'
        tdatas = tdata;
        tlabel = 'Time (seconds)';
    case 'minutes'
        tdatas = tdata / 60.0;
        tlabel = 'Time (minutes)';
    case 'hours'
        tdatas = tdata / 60.0 / 60.0;
        tlabel = 'Time (hours)';
end

left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');

if rsammin < 0
    specpos = [ pos(left)+pos(width)*0.02, pos(bottom)+pos(height)*0.15, pos(width), pos(height) * 1.0 ];
elseif rsammin == 0
    wavepos = [ pos(left)+pos(width)*0.02, pos(bottom),  pos(width) , pos(height) * 0.15] ;
    specpos = [ pos(left)+pos(width)*0.02, pos(bottom)+pos(height)*0.15, pos(width), pos(height) * 0.85 ];
else
    wavepos = [ pos(left)+pos(width)*0.02, pos(bottom),  pos(width) , pos(height) * 0.15] ;
    rsampos = [ pos(left)+pos(width)*0.02, pos(bottom)+pos(height)*0.15, pos(width), pos(height) * 0.15 ];
    specpos = [ pos(left)+pos(width)*0.02, pos(bottom)+pos(height)*0.30, pos(width), pos(height) * 0.70 ];
end

if rsammin >= 0
    subplot('position',wavepos);

    plot(tdatas,data);
    tlim = [min(tdatas) max(tdatas)];
    xlim( tlim );
    if atop == 0
        atop = max( max(data), abs(min(data)) );
    end
    ylim( [-1.0*atop atop] );
    grid on;
    ylabel('');
    %axis tight;

    set( gca, 'YTick', [] );
    xlabel( tlabel ); 
    xlabel('');
end

subplot('position',specpos);
spectrogram( data, window, noverlap, nfft, fs,'yaxis' );

tlim = [min(tdata) max(tdata)];
set( gca, ...
        'Box', 'on' , ...
        'Layer', 'top', ...
        'LineWidth', 1.0, ...
        'TickDir', 'in', ...
        'YLim', flim, ...
        'XLim', tlim , ...
        'GridLineStyle', '-', ...
        'XGrid', 'on', ...
        'YGrid', 'on', ...
        'XTick', [] );
if clim(1) ~= clim(2)
    caxis( clim );
end    
    if strcmp( linorlog, 'log' )
        set(gca,'YScale', 'log');
    else
        set(gca,'YScale', 'linear');
    end
    
ylabel( 'Frequency (Hz)' );
ylabel('');
xlabel('');
title( stacha );

if rsammin > 0

    npoles = 4;
    corner = 1.0;
    type = 'high';
    
 	nyq = 0.5 * fs;
	[z,p,k] = butter(npoles,corner/nyq,type);
	[sos,g] = zp2sos(z,p,k);
	Hd = dfilt.df2sos(sos,g);
	data = filter(Hd,data);
    data = mean_norm_nan( data );
    
    rsamdata = rsamlike( data, fs, rsammin);  
    
    if rsamsmooth > 0
        rsamdata = nan_rmedian( rsamdata, rsamsmooth );
    end
    rsamtime = [0:length(rsamdata)-1];
        
    rsammax = max( rsamdata );
    rsamdata = rsamdata / rsammax;
    
    subplot('position',rsampos);
    plot(rsamtime,rsamdata);
    tlim = [min(rsamtime) max(rsamtime)];
    xlim( tlim );
    ylim( [0 atop] );
    grid on;
    ylabel('');
    set( gca, 'XTick', [], 'YTick', [] );


end


return
