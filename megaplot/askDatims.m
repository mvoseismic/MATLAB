function [plotBeg, plotEnd] = askDatims()

begPlot = inputd( 'Start date/time for plot (yyyy,mm,dd,hh,mm,ss)', 's', '2023,2,8,0,0,0' );
ymdhms = strsplit( begPlot, ',');
plotBeg = datenum( cellfun(@str2num,ymdhms) );

endPlot = inputd( 'End date/time for plot (yyyy,mm,dd,hh,mm,ss)', 's', 'now' );
if strcmp( endPlot, 'now' )
    plotEnd = now;
else
    ymdhms = strsplit( endPlot, ',');
    plotEnd = datenum( cellfun(@str2num,ymdhms) );
end