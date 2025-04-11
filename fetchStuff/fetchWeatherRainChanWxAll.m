function fetchWeatherRainChanWxAll( setup, ouf )

warning('off','all');

fprintf( 1, "==== fetchWeatherRainChanWxAll\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherRainChanWxAll\n" );
    fprintf( ouf, "\n" );
end

dirWeather = fullfile( setup.DirHome, 'data/weather/MVO/ChanWx' );
dirWeatherSave = fullfile( setup.DirHome, 'data/weather/MVO' );
fileWeatherRainSave = fullfile(dirWeatherSave, 'ChanWxRain.mat');

fileRain = fullfile(dirWeather, 'ChanWx-all.csv');

R = readtable( fileRain );
datetimeRainChanWx = R.Var1;
rainChanWx = R.Var2;
datimRainChanWx = datenum( datetimeRainChanWx );

save( fileWeatherRainSave, "datimRainChanWx", "rainChanWx" );