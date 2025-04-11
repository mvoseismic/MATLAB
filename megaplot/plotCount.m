function plotCount( setup, Count, plot_type, plot_symcol, cum )
%
% Plots data from Count structure
%
% R.C. Stewart 27-Feb-2020

if ~strcmp( [setup.CountBinResamp], 'daily' )
    Count = countResamp( setup, Count );
end

datim = [Count.datim];
idPlot = datim >= setup.PlotBeg & datim <= setup.PlotEnd;
datim = datim( idPlot );
data = [Count.data];
data = data( idPlot );
datamin = min(data);

if cum
    data = cumsum( data );
    plot_title = strcat( [Count.title], " (cumulative)" );
    plot_ylabel = strcat( "Cumulative ", [Count.label] );
else
    plot_title = [Count.title];
    plot_ylabel = [Count.label];
end


% Hack for NSTA
if strcmp( Count.label, 'nsta' )
    switch [Count.binFreq]
        case 'weekly'
            data = data / 7;
        case 'fortnightly'
            data = data / 14;
        case 'monthly'
            data = data / 30;
    end
end
    
switch [Count.binFreq]
    case 'daily'
        plot_title = strcat( plot_title, " / day" );
        formatDatetick = 3;
    case 'weekly'
        plot_title = strcat( plot_title, " / week" );
        formatDatetick = 10;
    case 'monthly'
        plot_title = strcat( plot_title, " / month" );
        formatDatetick = 10;
    case 'other'
        plot_title = strcat( plot_title, " / other" );
        formatDatetick = 10;
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
xlim( [setup.PlotBeg setup.PlotEnd] );
datetick( 'x', formatDatetick, 'keeplimits' );


yl = ylim;
if datamin < 0
    ylim( [-1 yl(2)] );
else
    ylim( [0 yl(2)] );
end

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


        % Hack for Y tick labels
        if strcmp( plot_ylabel, 'All')
            ax = gca;
            ax.YTickLabel = [num2str(ax.YTick.') repmat('     ',size(ax.YTickLabel,1),1)];
        elseif strcmp( plot_ylabel, 'Hybrids')
            ax = gca;
            ax.YTickLabel = [num2str(ax.YTick.') repmat('     ',size(ax.YTickLabel,1),1)];
        elseif strcmp( plot_ylabel, 'LP/RFs')
            ax = gca;
            ax.YTickLabel = [num2str(ax.YTick.') repmat('     ',size(ax.YTickLabel,1),1)];
        end
        yLimits = ylim;
        if yLimits(1) == -1
            ylim( [0 1] );
            set( gca,'YTick', [] );
%            set(gca,'Yticklabel',[]);
        elseif yLimits(2) <= 5
            set(gca, 'YTick', [0 1 2 3 4 5] ); 
            ylim( [0 yLimits(2)+0.5] );
        else
            ylim( [0 yLimits(2)*1.1] );
        end

        
end

hold on;

set( gca, 'FontSize', 14 );
