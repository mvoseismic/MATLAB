function panacea2( datalots, npts, fs, stacha, time_start, png_dir, gain )
%
% Plots a day's worth of seismic data in many ways
% and stores it in a png file.
%
% Version 2
% Rod Stewart, UWI/SRC, 2020-07-23

% Sampling:                                 dela = sec / sample
dela = 1.0 / fs;                            % sampling frequency
delam = dela / 60.0;                        % min / sample
delad = dela / ( 60.0 * 60.0 * 24.0 );      % day / sample

% Local time
lt_offset = -4.0;
lt_offset_days = lt_offset / 24.0;

% Plot is meant for Letter Landscape
figx = 1164;
figy = 900;
figh = figure(  'PaperType', 'usletter', 'PaperOrientation', 'landscape', ...
                'Position', [10 10 figx figy] );
%set(    gca, 'DefaultAxesColorOrder', [0 0 0;1 0 0;0 0 1;0 1 0] );
set(    figh, 'DefaultAxesColorOrder', [0 0 0;.5 0 0;0 0 .5;0 .5 0] );

% Plot captions
caption = sprintf( '%s \n%s', stacha, datestr( time_start, 'yyyy-mm-dd' ) );
caption = string_tidy( caption );
annotation( 'textbox', [0.005 0.95 0.07 0.03], ...
            'String', caption, ...
            'LineStyle', 'none', ...
            'FontSize', 12, 'FontWeight', 'bold' );
annotation( 'textbox', [0.925 0.95 0.07 0.03], ...
            'String', caption, ...
            'LineStyle', 'none', ...
            'FontSize', 12, 'FontWeight', 'bold' );
annotation( 'textbox', [0.01, 0.915, 0.06, 0.03], ...
            'String', 'UTC (LT)', ...
            'LineStyle', 'none', ...
            'FontSize', 12 );
annotation( 'textbox', [0.93, 0.915, 0.06, 0.03], ...
            'String', 'UTC (LT)', ...
            'LineStyle', 'none', ...
            'FontSize', 12 );
        
% First plot
x1 = 0.07;
y1 = 0.05;
xd1 = 0.375;
yd1 = 0.9;
% Second plot
x2 = 0.445;
y2 = y1;
xd2 = 0.31;
yd2 = yd1;
% Third plot
x3 = 0.755;
y3 = y1;
xd3 = 0.085;
yd3 = yd1;
% Fourth plot
x4 = 0.84;
y4 = y1;
xd4 = 0.085;
yd4 = yd1;


% Left: helicorder
%
% Helicorder parameters
hours_per_plot = 24.0;
minutes_per_line = 10.0;

samples_per_plot = hours_per_plot * 60.0 * 60.0 * fs;
samples_per_line = minutes_per_line * 60.0 * fs;
lines_per_plot = samples_per_plot / samples_per_line;
lines_per_hour = lines_per_plot / hours_per_plot;

% Normalise data
datamax = max( datalots );
datamin = min( datalots );
datarange = datamax - datamin;

%gain = 40000.0;
datamult = datarange / gain;

datalots = mean_norm( datalots);
datalots2 = datalots * datamult;


% sort data for plotting
for iline = 1:lines_per_plot
    line_time( iline ) = time_start + ( (iline-1) * minutes_per_line / (24.0*60.0) ); 
    dataoffset = samples_per_line * double(iline - 1);
    idx1 = dataoffset+1;
    idx2 = dataoffset+int32(samples_per_line);
    dataplot = datalots2(idx1:idx2);
    dataplot = dataplot + iline;
    datapl(:,iline) = dataplot;
    timeplot = (0:delam:minutes_per_line-delam);
    timepl(:,iline) = timeplot;
end

% Time labels for ends of line
line_time = downsample( line_time, lines_per_hour );
line_labels_utc = datestr( line_time, 'HH:MM (' );
line_labels_lt = datestr( line_time + (lt_offset/24.0) , 'HH:MM)' );
line_labels =[ line_labels_utc line_labels_lt ];
lll = length( line_labels );

% Plot
ah1 = axes( 'Position', [ x1 y1 xd1 yd1] );

plot( ah1, timepl, datapl, 'LineStyle', '-' );

yticks = (1:lines_per_hour:lines_per_plot+1);
ylimits = [1.0-lines_per_hour lines_per_plot+1.0+0.5*lines_per_hour];

set( ah1, ...
        'Box', 'on' , ...
        'LineWidth', 2.0, ...
        'TickDir', 'in', ...
        'XLim', [0.0 minutes_per_line], ...
        'YLim', ylimits, ...
        'XMinorTick', 'off', ...
        'XMinorGrid', 'off', ...
        'XGrid', 'on', ...
        'GridLineStyle', '-', ...
        'YDir', 'reverse', ...
        'YTick', yticks, ...
        'YTickLabel', line_labels );
    
% Get rid of last X tick
xticks = get( ah1, 'XTick' );
nxticks = length( xticks );
xticks = xticks( 1 : nxticks-1 );
set( ah1, 'XTick', xticks );

title( 'Helicorder', 'FontSize', 12, 'FontWeight', 'bold' );
xlabel( 'Minutes', 'FontSize', 12 );

% Middle left: spectrogram

% spectrogram parameters
%window = 4096;
%noverlap = 1024;
%nfft = 4096;
window = hamming( 4096 );
noverlap = 1024;
nfft = 4096;

% plot paremeters
%ylimits = [0 86400];
%ylimits = [-3600 90000];
ylimits = [-1 24.5];
yticks = (0:1:24);

ah2 = axes( 'Position', [ x2 y2 xd2 yd2] );
%spectrogram( datalots2, window, noverlap, nfft, fs );
spectrogram( datalots2, window, noverlap, nfft, fs );
colormap jet;
colorbar off;
ah2.XScale = 'log';
ah2.Box = 'on';
ah2.LineWidth = 2.0;
ah2.TickDir = 'in';
ah2.XScale = 'log';
ah2.XLim = [0.1 100.0];
ah2.YDir = 'reverse';
ah2.GridLineStyle = '-';
ah2.XGrid = 'on';
ah2.YLim = ylimits;
ah2.YGrid = 'on';
ah2.XTick = [0.1 1.0 10.0];
ah2.XTickLabel = {'0.1';'1';'10'};
ah2.YTick = yticks;
ah2.YTickLabel = [];
ah2.CLim = [-70 10];

title( 'Spectrogram', 'FontSize', 12, 'FontWeight', 'bold' );
xlabel( 'Frequency (Hz)', 'FontSize', 12 );
ylabel( '' );    

% Middle right: seismogram

% set time samples
time_stop = time_start + delad*(npts-1);
timelots = (time_start: delad: time_stop);

% plot parameters
extra = (time_stop-time_start) / 48.0;
ylimits = [time_start-2*extra time_stop+extra];
yticks = (time_start:1.0/24.0:time_start+1.0);
linewidth = 1.5;

ah3 = axes( 'Position', [ x3 y3 xd3 yd3] );
plot( ah3, datalots2, timelots, 'b-');
hold on;
plot( ah3, datalots, timelots, 'r-', 'LineWidth', linewidth );
xscale = max( abs( min(datalots)) , max(datalots) );

set( ah3, ...
        'Box', 'on' , ...
        'LineWidth', 2.0, ...
        'TickDir', 'in', ...
        'YDir', 'reverse', ...
        'XDir', 'reverse', ...
        'XLim', [-xscale xscale], ...
        'YLim', ylimits, ...
        'GridLineStyle', ':', ...
        'XTick', [], ...
        'YGrid', 'on', ...
        'YTick', yticks, ...
        'YTickLabel', [] );

title( 'Seismogram', 'FontSize', 12, 'FontWeight', 'bold' );

% Right: RSAM

% RSAM parameters
rsam_window_min = 10.0;
rsam_window_sec = 600;
rsam_window_pts = rsam_window_sec * fs;

rsam = rsamlike( datalots, fs, rsam_window_min );
rsam2 = rsam * datamult / 2.0;
npts_rsam = length( rsam );
deladd = delad * rsam_window_pts;

time_stop = time_start + deladd*(npts_rsam-1);
timersam = (time_start: deladd: time_stop);
timersam = timersam + (deladd/2.0);

xlimit = max( rsam );

% Smoothed RSAM
%medwin = 31;
%smoothed = nan_rmedian( rsam2, medwin );

ah4 = axes( 'Position', [ x4 y4 xd4 yd4] );

barh( ah4, timersam, rsam2, 'b', 'EdgeColor', 'k', 'BarWidth', 1 );
hold on;
barh( ah4, timersam, rsam, 'r', 'EdgeColor', 'k', 'BarWidth', .7 );
%plot( ah4, rsam, timersam, 'r-', 'LineWidth', linewidth );
%plot( ah4, smoothed, timersam, 'c-', 'LineWidth', linewidth );

set( ah4, ...
        'Box', 'on' , ...
        'LineWidth', 2.0, ...
        'YAxisLocation', 'right', ...
        'TickDir', 'in', ...
        'YDir', 'reverse', ...
        'YLim', ylimits, ...
        'XLim', [0 xlimit], ...
        'GridLineStyle', ':', ...
        'XTick', [], ...
        'YGrid', 'on', ...
        'YTick', yticks, ...
        'YTickLabel', line_labels );

title( 'RMS', 'FontSize', 12, 'FontWeight', 'bold' );

out_file = sprintf( '%s-%s.png', datestr( time_start, 'yyyy_mm_dd' ), stacha );
out_file = fullfile( png_dir, out_file );
saveas( figh, out_file, 'png' );
exportfig( figh, out_file, ...
        'Format', 'png', ...
        'Width', figx, 'Height', figy, ...
        'Color', 'rgb' );