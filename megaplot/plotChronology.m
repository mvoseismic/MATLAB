function plotChronology( setup, ch_type, plot_type, plot_symcol )
%
% Plots data from chronology
%

switch ch_type
    
    case 'explosions'
        
        file_exp = fullfile( setup.Dir.Chronology, 'explosions_all.txt' );
        T = readtable( file_exp, 'DateTimeType', 'text' );
        
        datim = datenum( T.Var1 );
        data = ones( size( datim ) );  
        
        plot_title = 'explosions';
        plot_ylabel = 'explosions';
        
end

switch plot_type
    case 'bar'
        bar( datim, data, 'FaceColor', plot_symcol, 'EdgeColor', plot_symcol );
    case 'symbol'
        plot( datim, data, plot_symcol );
    case 'line'
        plot( datim, data, plot_symcol, 'LineWidth', 2 );
    case 'stem'
        stem( datim, data, plot_symcol );
end
ylim( [0 1] );
xlim( [setup.PlotBeg setup.PlotEnd] );
datetick( 'x', 'keeplimits' );

ax = gca;

ax.XMinorTick = 'off';
ax.TickDir = 'both';
ax.XGrid = 'on';


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