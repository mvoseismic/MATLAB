function writeSetup( setup )
%
% Writes megaplot2 setup information to screen and file
%
% R.C. Stewart, MVO, 23-Jan-2020


file_log = fullfile( setup.DirLog, setup.FileLog );

if setup.Log2File
    fid = fopen( file_log, 'w' );
    writeSetupOne( fid, setup );  
    fclose( fid );
end


if setup.Log2Screen
    writeSetupOne( 1, setup );  
end   

end


function writeSetupOne( fid, setup )

file_log = fullfile( setup.DirLog, setup.FileLog );

fprintf( fid, 'Megaplot2\n' );
fprintf( fid, ' Started                           %s\n', datestr( now ) );

fprintf( fid, '\n' );
fprintf( fid, ' Global setup\n' );

fprintf( fid, '  Mode:                            %s\n', setup.Mode );
if strcmp( setup.Mode, 'batch' )
    fprintf( fid, '  Input file:                      %s\n', setup.FileInput );
end

fprintf( fid, '  Log file:                        %s\n', file_log );

fprintf( fid, '  Directory for SEISAN counts:     %s\n', setup.DirSeisanCounts );
fprintf( fid, '  Directory for seismic data:      %s\n', setup.DirSeismicData );
fprintf( fid, '  Directory for megaplot data:     %s\n', setup.DirMegaplotData );

fprintf( fid, '  Log to file:                     %s\n', string( setup.Log2File ) );
fprintf( fid, '  Log to screen:                   %s\n', string( setup.Log2Screen ) );
fprintf( fid, '  Plot to file:                    %s\n', string( setup.Plot2File ) );
fprintf( fid, '  Plot to screen:                  %s\n', string( setup.Plot2Screen ) );

fprintf( fid, '  Start date/time for data:        %s\n', datestr( setup.DataBeg, 0 ) );
fprintf( fid, '  End date/time for data:          %s\n', datestr( setup.DataEnd, 0 ) );
fprintf( fid, '  Start date/time for plot:        %s\n', datestr( setup.PlotBeg, 0 ) );
fprintf( fid, '  End date/time for plot:          %s\n', datestr( setup.PlotEnd, 0 ) );

fprintf( fid, '  Name:                            %s\n', string( setup.Name ) );

fprintf( fid, '  Standard plot:                   %s\n', string( setup.Standard ) );
fprintf( fid, '  Time period of plot:             %s\n', string( setup.Period ) );

fprintf( fid, '  Plot date limits:                %s - %s\n', ...
    datestr( [setup.PlotDatimLim(1)] ), datestr( [setup.PlotDatimLim(2)] ) );
fprintf( fid, '  Plot magnitude limits:           %4.1f - %4.1f\n', setup.PlotMagLim );
fprintf( fid, '  Plot depth limits:               %5.1f - %5.1f\n', setup.PlotDepLim );

fprintf( fid, '  Daily counts rebinned:           %s\n', string( setup.CountBinResamp )  );

dplot = [setup.plot];

fprintf( fid, '  Size:                            %s\n', dplot.Size );
fprintf( fid, '  Orientation:                     %s\n', dplot.Orientation );
fprintf( fid, '  Type:                            %s\n', dplot.Type );
fprintf( fid, '  Colour:                          %s\n', dplot.Colour );
fprintf( fid, '  Symbol:                          %s\n', dplot.Symbol );
fprintf( fid, '  Line type:                       %s\n', dplot.Line );
fprintf( fid, '  Font size:                       %d\n', dplot.FontSize );
fprintf( fid, '  Subplot spacing:                 %s\n', setup.SubplotSpace );
fprintf( fid, '  Subplot X axis:                  %s\n', setup.PlotXaxis );
fprintf( fid, '  Number of subplots:              %d\n', dplot.NPanes );
fprintf( fid, '  Footer:                          %s\n', dplot.Footer );


end