function axis2 (type )
%
% Plots a second set of ticks and labels on the other side.
%
% Doesn't work for dateticked axes.
%
% type can be:
%               x
%               y
%               xy or both or anything
%
% Rod Stewart, MVOI, 2017-07-13

ax1=gca;

ax2 = axes('Position', get(ax1, 'Position'),'Color', 'none');

switch type
    
    case 'x'
        set(ax2, 'XAxisLocation', 'top', 'YAxisLocation', 'left');
        set(ax2, 'YColor', 'none' );
        
    case 'y'
        set(ax2, 'XAxisLocation', 'bottom', 'YAxisLocation', 'right');
        set(ax2, 'XColor', 'none' );
        
    otherwise
        set(ax2, 'XAxisLocation', 'top', 'YAxisLocation', 'right');
        
end

set(ax2, 'XLim', get(ax1, 'XLim'),'YLim', get(ax1, 'YLim'));
set(ax2, 'XTick', get(ax1, 'XTick'), 'YTick', get(ax1, 'YTick'));
