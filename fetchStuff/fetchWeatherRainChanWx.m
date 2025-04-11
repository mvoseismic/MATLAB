function fetchWeatherRainChanWx( setup, ouf )


warning('off','all');


fprintf( 1, "==== fetchWeatherRainChanWx\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherRainChanWx\n" );
    fprintf( ouf, "\n" );
end

dirWeather = fullfile( setup.DirHome, 'data/weather/MVO/ChanWx' );
dirWeatherSave = fullfile( setup.DirHome, 'data/weather/MVO' );
fileWeatherRainSave = fullfile(dirWeatherSave, 'ChanWxRain.mat');


datimRainChanWx = [];
datetimRainChanWx = [];
rainChanWx = [];


filesRain = dir(fullfile(dirWeather,'ChanWx_*.csv')); 
for k = 1:length(filesRain)
  baseFileName = filesRain(k).name;
  fileRain = fullfile(dirWeather, baseFileName);

  %fprintf( "%s\n", fileRain );

  opts = detectImportOptions(fileRain);
  opts = setvaropts(opts,"DateTime",'InputFormat','dd/MM/yyyy HH:mm:ss');
  R = readtable( fileRain, opts );

  datetimeRain = R.DateTime;
  datim1 = datenum( datetimeRain );
  rain1 = R.Rain_mm_C_1;

  datimRainChanWx = [ datimRainChanWx; datim1 ];
  datetimRainChanWx = [ datetimRainChanWx; datetimeRain ];
  rainChanWx = [ rainChanWx; rain1 ];

end

[datimRainChanWx,idx] = sort( datimRainChanWx );
datetimRainChanWx = datetimRainChanWx(idx);
rainChanWx = rainChanWx( idx );

plot( datimRainChanWx, cumsum(rainChanWx), 'r-' );


save( fileWeatherRainSave, "datimRainChanWx", "rainChanWx" );
