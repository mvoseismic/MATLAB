function fetchWeatherMeteostat( setup, ouf )
% 
% Fetches Geralds weather data from Meteostat and saves them as MATLAB arrays
%
% R.C. Stewart 21-May-2024

data_file = 'meteostat-TRBP0-geralds-combined.txt';
data_file = fullfile( setup.DirMeteostat, data_file );

B = readtable( data_file );

DT = B.Var1 + B.Var2;
DT.Format = 'yyyy-MM-dd HH:mm:ss';
datimGeralds = datenum( DT );
datimGeralds = datimGeralds + 4/24;
tempGeralds = B.Var3;
windDirGeralds = B.Var8;
windSpeedGeralds = B.Var9;

fprintf( 1, "==== fetchWeatherMeteostat\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherMeteostat\n" );
    fprintf( ouf, "\n" );
end

data_file = fullfile( setup.DirMeteostat, 'meteostat.mat' );

idWant = datimGeralds < now;
datimGeralds = datimGeralds( idWant );
tempGeralds = tempGeralds( idWant );
windDirGeralds = windDirGeralds( idWant );
windSpeedGeralds = windSpeedGeralds( idWant );
windSpeedGeralds = 0.277778 * windSpeedGeralds;

save( data_file, 'datimGeralds','tempGeralds', ...
    'windDirGeralds', 'windSpeedGeralds' );

return