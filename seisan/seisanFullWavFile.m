function fileOut = seisanFullWavFile( fileIn, setup )
%
% Given a Seisan file name, attempts to work out where to find it
%
% Rod Stewart, 17-May-2020

% Get year and month from file name, yyyy-mm
year = fileIn(1:4);
mont = fileIn(6:7);

% Get year and month from file name, yymm
if str2num(year) > 2100 
    year = strcat( '19', fileIn(1:2) );
    mont = fileIn(3:4);
end




fileOut = fullfile( setup.Dir.WAV, year, mont, fileIn );

return;