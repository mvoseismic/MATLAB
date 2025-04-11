function plotBlank( setup )
%
% Plots blank pane for plotVertLines
%
% R.C. Stewart 17-FNov-2020

X = [1 2];
Y = [0 1];
plot_title = 'Activity';
plot_ylabel = 'Activity';

plot( X, Y, 'k.');

xlim( [setup.PlotBeg setup.PlotEnd] );
datetick( 'x', 'keeplimits' );
ylim( [0 1] );

ax = gca;

ax.XMinorTick = 'off';
ax.TickDir = 'both';
ax.XGrid = 'off';
ax.YTickLabel = [];


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

