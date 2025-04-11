function fetchWeather( setup, ouf )

fprintf( 1, "==== fetchWeather\n" );
if nargin == 2
    fprintf( ouf, "==== fetchWeather\n" );
    fprintf( ouf, "\n" );
end

dirWeather = '/mnt/mvofls3/DVG_Data/DVG_DATA_SHARE/Weather_Data_For_Rod';
dirWeatherSave = fullfile( setup.DirHome, 'data/weather/MVO' );

filesWeather = dir(fullfile(dirWeather, '*.csv'));
nfiles = length( filesWeather );

for ifile = 1:nfiles

    fileWeather = filesWeather(ifile).name;
    chunks = split( fileWeather, '_' );

    sta = string( chunks(1) );
    what = string( chunks(2) );

    fileWeatherSave = fullfile( dirWeatherSave, strcat( sta, '_', what, '.mat' ) );
    fileWeather = fullfile( dirWeather, fileWeather );

    X = readtable( fileWeather );
    if strcmp( what, 'AllRain' )
        datim = datenum(X.DateTime_LT_);
        %datim = datim + datenum( 2000, 1, 1, 0, 0, 0 );
        datim = datim + 4/24;
        rain = X.Rain_mm_;
        save( fileWeatherSave, 'datim', 'rain' );
    elseif strcmp( what, 'HourlyRain' )
        %datim = datenum(X.DateTime_LT_);
        datim = datenum(X.DateTime);
        %datim = datim + datenum( 2000, 1, 1, 0, 0, 0 );
        datim = datim + 4/24;
        %rain = X.Total_Rain_mm_;
        rain = X.Total_Rain_mm_C_1;
        save( fileWeatherSave, 'datim', 'rain' );
    elseif strcmp( what, 'AllWind' )
        datim = datenum(X.DateTime);
        datim = datim + datenum( 2000, 1, 1, 0, 0, 0 );
        datim = datim + 4/24;
        wspeed = X.WindSpeed_m_s_;
        %gspeed = X.GustSpeed_m_s_;
        wdir = X.WindDirection___;
        %save( fileWeatherSave, 'datim', 'wspeed', 'gspeed', 'wdir' );
        save( fileWeatherSave, 'datim', 'wspeed', 'wdir' );
    end

end

%dirWeather = '/mnt/mvofls3/DVG_Data/DVG_DATA_SHARE/Weather_Data_For_Rod/LeesWx';
dirWeather = '/home/seisan/data/MVO/LeesWx';

filesWeather = dir(fullfile(dirWeather, '*.xlsx'));
nfiles = length( filesWeather );

datim = [];
rain = [];

for ifile = 1:nfiles

    fileWeather = filesWeather(ifile).name;   
    fileWeather = fullfile( dirWeather, fileWeather );
    X = readtable( fileWeather );
    datim1 = datenum(X.DateTime);
    datim1 = datim1 + 4/24;
    rain1 = X.Rain_mm_C_1;

    datim = [datim; datim1];
    rain = [rain; rain1];
    
end

datim = datim';
rain = rain';
fileWeatherSave = fullfile( dirWeatherSave, 'LeesWx_MinutelyRain.mat' );
save( fileWeatherSave, 'datim', 'rain' );