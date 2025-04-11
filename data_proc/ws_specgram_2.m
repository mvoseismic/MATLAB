function ws_specgram_2( ws, nfft, noverlap, window, atop, clim, flim, linorlog, taxis )
%
% Plots a single waveform object as a spectrogram and an fft
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

wavepos = [ pos(left)+pos(width)*0.02, pos(bottom)+pos(height)*0.8, pos(width), pos(height) * 0.15] ;
specpos = [ pos(left)+pos(width)*0.02, pos(bottom), pos(width), pos(height) * 0.8 ];

subplot('position',wavepos);

plot(tdatas,data);
set(gca,'XAxisLocation', 'top' );
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
xlabel( '' );
title( stacha );

subplot('position',specpos);
spectrogram( data, window, noverlap, nfft, fs,'yaxis' );
set(gca,'XAxisLocation', 'bottom' );

tlim = [min(tdata) max(tdata)];
set( gca, ...
        'Box', 'on' , ...
        'Layer', 'top', ...
        'LineWidth', 1.0, ...
        'TickDir', 'out', ...
        'YLim', flim, ...
        'XLim', tlim , ...
        'GridLineStyle', '-', ...
        'XGrid', 'on', ...
        'YGrid', 'on' );
if clim(1) ~= clim(2)
    caxis( clim );
end  

if strcmp( linorlog, 'log' )
    set(gca,'YScale', 'log');
else
    set(gca,'YScale', 'linear');
end
    
ylabel( 'Frequency (Hz)' );
xlabel( tlabel );


return
