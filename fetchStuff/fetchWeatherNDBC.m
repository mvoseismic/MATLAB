function fetchWeatherNDBC( setup, ouf )
% 
% Fetches data from NDBC weather buoy and saves them as MATLAB arrays
%
% R.C. Stewart 17-Oct-2021

data_file = 'dataNDBC/all42060.txt';
data_file = fullfile( setup.DirNDBC, data_file );

B = readtable( data_file );
datimB42060 = datenum(B.x_YY, B.MM, B.DD, B.hh, B.mm, 0 );
waveDirB42060 = B.MWD;
waveDirB42060( waveDirB42060 > 900 ) = NaN;
waveHeightB42060 = B.WVHT;
waveHeightB42060( waveHeightB42060 > 90 ) = NaN;
windSpeedB42060  = B.WSPD;
windDirB42060  = B.WDIR;
windDirB42060( windDirB42060 >900 ) = NaN;

fprintf( 1, "==== fetchWeatherNDBC\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherNDBC\n" );
    fprintf( ouf, "\n" );
end

data_file = fullfile( setup.DirNDBC, 'NDBC.mat' );

save( data_file, 'datimB42060','waveHeightB42060', 'waveDirB42060', ...
    'windSpeedB42060', 'windDirB42060' );


return