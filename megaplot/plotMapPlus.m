function plotMapPlus( setup, Hypo, whither, overtitle )
%
% Plots hypocentre data on a map along with event rates, mags and depths
%
% R.C. Stewart, 20-Feb-2020

if nargin < 3
    whither = 'Montserrat';
end

if nargin < 4
    overtitle = whither;
end

datim_lim = setup.PlotDatimLim;
    
figure1( 'portrait' );

subplot( 6, 1, 1:3 );
plotMap( setup, Hypo, whither );
    
hypo_datim = [Hypo.otime];
hypo_mag = [Hypo.mag];
hypo_dep = [Hypo.dep];

subplot( 6, 1, 4 );
plot( hypo_datim, hypo_mag, 'ro' );
title( 'Magnitude, Mt' );
xlim( datim_lim );
ylim( setup.PlotMagLim );
set( gca, 'XMinorTick', 'on', 'TickDir', 'out', 'XGrid', 'on', 'XMinorGrid', 'on' );
datetick( 'x', 'keeplimits' );

subplot( 6, 1, 5 );
plot( hypo_datim, hypo_dep, 'ro' );
axis ij;
title( 'Depth (km)' );
xlim( datim_lim );
ylim( setup.PlotDepLim );
set( gca, 'XMinorTick', 'on', 'TickDir', 'out', 'XGrid', 'on', 'XMinorGrid', 'on' );
datetick( 'x', 'keeplimits' );

subplot( 6, 1, 6 );
[count_datim, count_hypo, title_text] = hypoRate( setup, Hypo );
bar( count_datim, count_hypo );
title( title_text );
xlim( datim_lim );
set( gca, 'XMinorTick', 'on', 'TickDir', 'out', 'XGrid', 'on', 'XMinorGrid', 'on' );
datetick( 'x', 'keeplimits' );

sgtitle( overtitle );