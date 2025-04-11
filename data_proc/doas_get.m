function doas = doas_get

global DIR_DOAS

dfile = fullfile( DIR_DOAS, 'LL-20081209-20090104.csv' );
doas_raw = csvread( dfile, 1, 2 );
doas = doas_raw;
doas(:,1) = datexltomat( doas_raw(:,1) ) + 4.0/24.0;

end