function plotVertLines( Vlines )
%
% Plots vertical lines, with optional labels, on current axes 
% R.C. Stewart 9-Jan-2020
    
yl = ylim;
xl = xlim;

for il = 1:length(Vlines)
    
    X = [ [Vlines(il).datim] [Vlines(il).datim] ];
    Y = yl;
    style = Vlines(il).style;
    
    if isfield( Vlines, 'width' )
        width = Vlines(il).width;
    else
        width = 0.5;
    end
    
    if isfield( Vlines, 'top' )
        top = Vlines(il).top;
        Y(2) = yl(1) + (yl(2)-yl(1))*top/100.0;
    end

    if isfield( Vlines, 'bot' )
        top = Vlines(il).bot;
        Y(1) = yl(1) + (yl(2)-yl(1))*bot/100.0;
    end
    plot( X, Y, style, 'LineWidth', width, 'HandleVisibility', 'off' );
    
    if isfield( Vlines, 'label' ) && length( Vlines(il).label )
        label = string( Vlines(il).label );
        
        if isfield( Vlines, 'labelloc' )
            labelloc = Vlines(il).labelloc;
        else
            labelloc = 80;
        end
        ylabel =  yl(1) + (yl(2)-yl(1))*labelloc/100.0;
        
        if isfield( Vlines, 'labeloff' )
            labeloff = Vlines(il).labeloff;
        else
            labeloff = 5;
        end
        xlabel =  X(1) + ( (xl(2)-xl(1))*labeloff/100.0 );
    
        if isfield( Vlines, 'labelsize' )
            labelsize = Vlines(il).labelsize;
        else
            labelsize = 12;
        end
        
        if Vlines(il).box
            text( xlabel, ylabel, label, 'FontSize', labelsize, ...
                'EdgeColor', 'k', 'BackgroundColor', 'w' );
        else
            text( xlabel, ylabel, label, 'FontSize', labelsize );
        end
        
    end
        
end