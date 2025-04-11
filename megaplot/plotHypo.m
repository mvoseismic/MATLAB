function plotHypo( setup, Hypo, data_type, plot_type, plot_symcol, cum )
%
% Plots data from Hypo structure
%
% R.C. Stewart 8-Jan-2020

X = [Hypo.otime];

switch data_type
    
    case 'depth'
        Y = [Hypo.dep];
        plot_title = 'Depth (km)';
        plot_ylabel = 'Depth';
        
    case 'lat'
        Y = [Hypo.lat];
        plot_title = 'Latitude (deg)';
        plot_ylabel = 'Lat';
        
    case 'lon'
        Y = [Hypo.lon];
        plot_title = 'Longitude (deg)';
        plot_ylabel = 'Lon';
        
    case 'mag'
        Y = [Hypo.mag];
        plot_title = 'ML';
        plot_ylabel = 'ML';
        
    case 'mag3plus'
        Y = [Hypo.mag];
        Y(Y<3.0) = NaN;
        plot_title = 'ML';
        plot_ylabel = 'ML';
        
    case 'moment'
        Y = [Hypo.mag];
        Y = mag2moment( Y );
        plot_title = 'Moment';
        plot_ylabel = 'Moment';
        
    case 'nsta'
        Y = [Hypo.nsta];
        plot_title = 'No of stations';
        plot_ylabel = 'nsta';
        
    case 'gap'
        Y = [Hypo.gap];
        plot_title = 'gap';
        plot_ylabel = 'gap';
        
    case 'rms'
        Y = [Hypo.rms];
        plot_title = 'RMS';
        plot_ylabel = 'RMS';
        
    case 'counts'
        [X, Y, plot_title] = hypoRate( setup, Hypo );
        plot_ylabel = 'N';
        
end
        
% We only want non-Nan values
idy = isfinite( Y );
X = X(idy);
Y = Y(idy);

if cum
    Y = cumsum( Y );
    plot_title = strcat( plot_title, " (cumulative)" );
    plot_ylabel = strcat( "Cumulative ", plot_ylabel );
end

switch plot_type
    case 'bar'
        bar( X, Y, 'FaceColor', plot_symcol, 'EdgeColor', plot_symcol, 'BarWidth', 1 );
    case 'symbol'
        plot( X, Y, plot_symcol );
    case 'line'
        plot( X, Y, plot_symcol, 'LineWidth', 2 );
    case 'stem'
        stem( X, Y, plot_symcol );
end
      
xlim( [setup.DatimBeg setup.DatimEnd] );
datetick( 'x', 'keeplimits' );

ax = gca;

ax.XMinorTick = 'on';
ax.TickDir = 'both';
ax.XGrid = 'on';

switch data_type
    case {'depth','dep'}
        axis ij;
        ylim( [-1 5] );
    case 'lat'
        ylim( [16.69 16.74] );
    case 'lon'
        ylim( [-62.2 -62.15] );
    otherwise
end


switch setup.SubplotSpace
    case 'normal'
        title( plot_title );
    case 'tight'
        ylabel( plot_ylabel );
        switch setup.PlotXaxis
            case 'top'
                ax.XAxisLocation = 'top';
            case 'bottom'
                ax.XAxisLocation = 'bottom';
                %ylabs = ax.YTickLabel;
                %ylabs(length(ylabs)) = '';
                %ax.YTickLabel = ylabs;
            case 'none'
                ax.XAxisLocation = 'bottom';
                ax.XTickLabel = {};
                %ylabs = ax.YTickLabel;
                %ylabs(length(ylabs)) = '';
                %ax.YTickLabel = ylabs;
        end
          
end

hold on;
