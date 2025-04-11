function fetchWeatherNDBCrt( setup )
% 
% Fetches real time data from NDBC weather buoy and saves them as MATLAB arrays
%
% R.C. Stewart 17-Oct-2021

data_file = 'rt42060-last5days.txt';
data_file = fullfile( setup.DirNDBC, 'dataNDBC', data_file );
B = readtable( data_file );
datimB42060 = datenum(B.Var1, B.Var2, B.Var3, B.Var4, B.Var5, 0 );
waveDirB42060 = B.Var12;
waveDirB42060( waveDirB42060 > 900 ) = NaN;
waveHeightB42060 = B.Var9;
waveHeightB42060( waveHeightB42060 > 90 ) = NaN;
windSpeedB42060  = B.Var7;
windSpeedB42060( windSpeedB42060 > 500 ) = NaN;
windDirB42060  = B.Var6;
windDirB42060( windDirB42060 >900 ) = NaN;


data_file = 'rt41044-last5days.txt';
data_file = fullfile( setup.DirNDBC, 'dataNDBC', data_file );
B = readtable( data_file );
datimB41044 = datenum(B.Var1, B.Var2, B.Var3, B.Var4, B.Var5, 0 );
waveDirB41044 = B.Var12;
waveDirB41044( waveDirB41044 > 900 ) = NaN;
waveHeightB41044 = B.Var9;
waveHeightB41044( waveHeightB41044 > 90 ) = NaN;
windSpeedB41044  = B.Var7;
windSpeedB41044( windSpeedB41044 > 500 ) = NaN;
windDirB41044  = B.Var6;
windDirB41044( windDirB41044 >900 ) = NaN;

data_file = 'rt41040-last5days.txt';
data_file = fullfile( setup.DirNDBC, 'dataNDBC', data_file );
B = readtable( data_file );
datimB41040 = datenum(B.Var1, B.Var2, B.Var3, B.Var4, B.Var5, 0 );
waveDirB41040 = B.Var12;
waveDirB41040( waveDirB41040 > 900 ) = NaN;
waveHeightB41040 = B.Var9;
waveHeightB41040( waveHeightB41040 > 90 ) = NaN;
windSpeedB41040  = B.Var7;
windSpeedB41040( windSpeedB41040 > 500 ) = NaN;
windDirB41040  = B.Var6;
windDirB41040( windDirB42060 >900 ) = NaN;

data_file = fullfile( setup.DirMegaplotData, 'fetchedWeatherNDBCrt.mat' );

save( data_file, 'datimB42060','waveHeightB42060', 'waveDirB42060', ...
    'windSpeedB42060', 'windDirB42060', ...
    'datimB41040','waveHeightB41040', 'waveDirB41040', ...
    'windSpeedB41040', 'windDirB41040', ...
    'datimB41044','waveHeightB41044', 'waveDirB41044', ...
    'windSpeedB41044', 'windDirB41044');


return