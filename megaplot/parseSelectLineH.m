function [otime, lat, lon, dep, rms] = parseSelectLineH( tline )
%
% Parses the H line from select.out
%
% R.C. Stewart, 7-Jan-2020

yr = str2double( tline(2:5) );
mo = str2double( tline(7:8) );
da = str2double( tline(9:10) );
hr = str2double( tline(12:13) );
mi = str2double( tline(14:15) );
se = str2double( tline(17:22) );
otime = datenum( yr, mo, da, hr, mi, se );

lat = str2double( tline(24:32) );
lon = str2double( tline(34:43) );
dep = str2double( tline(45:52) );
rms = str2double( tline(54:59) );
