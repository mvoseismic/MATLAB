function fetchWeatherRain( setup, ouf )

warning('off','all');

fprintf( 1, "==== fetchWeatherRain\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeatherRain\n" );
    fprintf( ouf, "\n" );
end

dirWeather = fullfile( setup.DirHome, 'data/weather/MVO/0-new' );

for ir = 1:3
    switch ir
        case 1
            fileWeatherRainSave = fullfile(dirWeather, 'ChanWxRain1m.mat');
            fileWeatherRain = fullfile(dirWeather, 'ChanWx_AllRain_Since7July2022.txt');
        case 2
            fileWeatherRainSave = fullfile(dirWeather, 'HermWxRain1m.mat');
            fileWeatherRain = fullfile(dirWeather, 'HermWx_RainOnly_Since22June2022.txt');
        case 3
            fileWeatherRainSave = fullfile(dirWeather, 'LeesWxRain1m.mat');
            fileWeatherRain = fullfile(dirWeather, 'LeesWx_AllRain_Since24Mar2021.txt');
    end

    datimRain = [];
    rain1m = [];

    opts = detectImportOptions(fileWeatherRain);
    opts = setvartype(opts,"Var1","datetime");
    opts = setvaropts(opts,"Var1",'InputFormat','yyyy/MM/dd');
    R = readtable( fileWeatherRain, opts );
    %R = readtable( fileWeatherRain, 'Delimiter','\t', 'Format','%{y/M/d H:m:s.S}D%f')

    datimRain = datenum(R.Var1) + days(R.Var2);

    rain1minute = R.Var3;
    rain1minute( rain1minute == -888.88 ) = NaN;

    save( fileWeatherRainSave, "datimRain", "rain1minute" );
 

end

