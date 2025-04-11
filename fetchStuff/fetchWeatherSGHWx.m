function fetchWeatherSGHWx( setup, ouf )


fprintf( 1, "==== fetchWeatherSGHWx\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherSGHWx\n" );
    fprintf( ouf, "\n" );
end

dirWeather = fullfile( setup.DirHome, 'data/weather/MVO/SGHWx' );
dirWeatherSave = fullfile( setup.DirHome, 'data/weather/MVO' );

fileWeatherNoGust = fullfile(dirWeather, 'SGHWxDailyNoGust.csv');
fileWeatherWithGust = fullfile(dirWeather, 'SGHWxAllWithGust.csv');
fileWeatherSave = fullfile(dirWeatherSave, 'SGHWxAll.mat');

% Data without gust
W = readtable( fileWeatherNoGust );
datetimeSGHWx1 = W.Var1;
datimSGHWx1 = datenum( datetimeSGHWx1 );
windSpeedSGHWx1 = W.Var4;
windSpeedGustSGHWx1 = nan( size(datimSGHWx1) );
windDirSGHWx1 = W.Var5;
%pressureSGHWx1 = W.Var6;
%temperatureSGHWx1 = W.Var7;
%humiditySGHWx1 = W.Var8;
%rainSGHWx1 = W.Var10;

% Data with gust
W = readtable( fileWeatherWithGust );
datetimeSGHWx2 = W.Var1;
datimSGHWx2 = datenum( datetimeSGHWx2 );
windSpeedSGHWx2 = W.Var4;
windSpeedGustSGHWx2 = W.Var5;
windDirSGHWx2 = W.Var6;
%pressureSGHWx2 = W.Var7;
%temperatureSGHWx2 = W.Var8;
%humiditySGHWx2 = W.Var9;
%rainSGHWx2 = W.Var11;

% Old data from spreadsheet
dirWeather = '/home/seisan/data/weather/MVO/SGHWx';
fileWeather = fullfile(dirWeather, 'SGHWx_AllData_2021-2023.xlsx' );

WT=[];
opt=detectImportOptions(fileWeather);
for yr = 2021:2023
    yrstr = sprintf( "%d", yr );
    WT=[WT;readtable(fileWeather,opt,'Sheet',yrstr)];
end
datetimeSGHWx3 = WT.Var1;
datimSGHWx3 = datenum( datetimeSGHWx3 );
windSpeedSGHWx3 = WT.Var2;
windSpeedGustSGHWx3 = nan( size(windSpeedSGHWx3) );
windDirSGHWx3 = WT.Var3;
%pressureSGHWx3 = W.Var4;
%temperatureSGHWx3 = W.Var5;
%humiditySGHWx2 = W.Var6;
%rainSGHWx2 = W.Var7;



datimSGHWx = [datimSGHWx3; datimSGHWx2; datimSGHWx1];
datimSGHWx = datimSGHWx + 4/24;
windSpeedSGHWx = [windSpeedSGHWx3; windSpeedSGHWx2; windSpeedSGHWx1];
windSpeedGustSGHWx = [windSpeedGustSGHWx3; windSpeedGustSGHWx2; windSpeedGustSGHWx1];
windDirSGHWx = [windDirSGHWx3; windDirSGHWx2; windDirSGHWx1];
%pressureSGHWx = [pressureSGHWx3; pressureSGHWx2; pressureSGHWx1];
%temperatureSGHWx = [temperatureSGHWx3; temperatureSGHWx2; temperatureSGHWx1];
%humiditySGHWx = [humiditySGHWx2; humiditySGHWx1];
%rainSGHWx = [rainSGHWx2; rainSGHWx1];


save( fileWeatherSave, "datimSGHWx", "windSpeedSGHWx", "windSpeedGustSGHWx", "windDirSGHWx" );
