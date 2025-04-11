function [otime, type, located, lat, lon, dep, loc_agency, nph, ...
    rms, mag, mag_type, mag_agency, felt] = parseSoufriereHypos( tline )
%
% Parses the line from soufriere hypos
%
% R.C. Stewart, 26-Feb-2020

yr = str2double( tline(1:4) );
mo = str2double( tline(6:7) );
da = str2double( tline(9:10) );
hr = str2double( tline(12:13) );
mi = str2double( tline(15:16) );
se = str2double( tline(18:22) );
otime = datenum( yr, mo, da, hr, mi, se );

type = 'L';

lat = str2double( tline(24:30) );
lon = str2double( tline(32:38) );
dep = str2double( tline(40:45) );

located = 1;
loc_agency = 'SRC';
     
mag = str2double( tline(47:49) );
mag_type = 't';
mag_agency = 'SRC';

felt = tline(51:54);

rms = str2double( tline(56:61) );

nph = str2double( tline(62:64) );
npp = str2double( tline(65:67) );
nps = str2double( tline(68:70) );



