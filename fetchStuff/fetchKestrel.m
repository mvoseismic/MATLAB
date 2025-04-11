clear;
setup = setupGlobals();

dirKestrel = fullfile( setup.DirHome, 'STUFF/data/weather/Kestrel5500--LOCAL_TIME' );

filesKestrel = dir(fullfile(dirKestrel, 'WEATHER*.csv'));
nfiles = length( filesKestrel );

for i = 1:nfiles
    fprintf( '%d    %s\n', i, filesKestrel(i).name );
end
ifile = inputd( 'Select file', 'i', nfiles );
fileKestrel = fullfile( dirKestrel, filesKestrel(ifile).name );

K = readtable( fileKestrel );
kDate = K.Var1;
kTime = K.Var2;
K3 = split( K.Var3, ',' );
kTemperature = str2double(K3(:,2));
kTemperature = (kTemperature-32)*(5/9);
kHumidity = str2double(K3(:,4));
kPressure = str2double(K3(:,5));
kPressure = 33.86389 * kPressure;
kWindSpeed = str2double(K3(:,8));
kWindSpeed = 0.44704 * kWindSpeed;
kWindDir = str2double(K3(:,15));

kDateTime = kDate + kTime;
kDateTime.Format='yyyy-MM-dd HH:mm:ss';
idFix1 = and( strcmp( K3(:,1), 'PM' ), hour(kDateTime) ~= 12 );
kDateTime(idFix1) = kDateTime(idFix1) + hours(12);
idFix2 = and( strcmp( K3(:,1), 'AM' ), hour(kDateTime) == 12 );
kDateTime(idFix2) = kDateTime(idFix2) - hours(12);
kDateTime = kDateTime + hours(4);
kDatim = datenum( kDateTime );

weather = struct( 'datim', kDatim, 'temp', kTemperature, ...
    'humid', kHumidity, 'press', kPressure, 'wspeed', kWindSpeed, ...
    'wdir', kWindDir );

fileMat=strrep(fileKestrel,'.csv','.mat');
save( fileMat, 'weather' );



figure;
figure_size( 's' );

subplot(5,1,1);
plot( kDatim, kTemperature, 'ro' );
datetick( 'x', 'keeplimits' );
title( 'Temperature' );
ylabel( 'Degrees C' );

subplot(5,1,2);
plot( kDatim, kHumidity, 'ro' );
datetick( 'x', 'keeplimits' );
title( 'Relative Humidity' );
ylabel( '%' );

subplot(5,1,3);
plot( kDatim, kPressure, 'ro' );
datetick( 'x', 'keeplimits' );
title( 'Pressure' );
ylabel( 'mbar' );

subplot(5,1,4);
plot( kDatim, kWindSpeed, 'ro' );
datetick( 'x', 'keeplimits' );
title( 'Wind Speed' );
ylim([0 Inf]);
ylabel( 'm/s' );

subplot(5,1,5);
plot( kDatim, kWindDir, 'ro' );
datetick( 'x', 'keeplimits' );
title( 'Wind Direction' );
xlabel( 'Time (UTC)' );
ylim([0 360]);
ylabel( 'Degrees' );

tit = sprintf( "Kestrel 5500: %s - %s UTC", datestr(kDatim(1)), datestr(kDatim(end)));

plotOverTitle( tit );
