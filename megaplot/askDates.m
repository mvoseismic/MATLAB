function [plotBeg, plotEnd] = askDates(begPlotDef,endPlotDef)

if ~exist('endPlotDef','var')
    begPlotDef = '1/1/1995';
    endPlotDef = 'now';
end

begPlot = inputd( 'Start date for plot (dd/mm/yyyy)', 's', begPlotDef );
plotBeg = dateCommon( begPlot );

endPlot = inputd( 'End date for plot (dd/mm/yyyy)', 's', endPlotDef );
plotEnd = dateCommon( endPlot );
