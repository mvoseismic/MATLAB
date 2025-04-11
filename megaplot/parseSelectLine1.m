function [datim, type, lat, lon, dep, loc_agency, nsta, ...
    err, mag, mag_type, mag_agency] = parseSelectLine1( tline )
%
% Parses the 1 line from select.out and all lines from collect.out
%
% R.C. Stewart, 7-Jan-2020

yr = str2double( tline(2:5) );
mo = str2double( tline(7:8) );
da = str2double( tline(9:10) );
hr = str2double( tline(12:13) );
mi = str2double( tline(14:15) );
se = str2double( tline(17:20) );
datim = datenum( yr, mo, da, hr, mi, se );

type = tline(22:23);

tpart = tline(24:30);
if isStringBlank( tpart )
    lat = NaN;
else
    lat = str2double( tpart );
end

tpart = tline(31:38);
if isStringBlank( tpart )
    lon = NaN;
else
    lon = str2double( tpart );
end
   
tpart = tline(39:43);
if isStringBlank( tpart )
    dep = NaN;
else
    dep = str2double( tpart );
end
   
loc_agency = tline(46:48);
    
tpart = tline(49:51);
if isStringBlank( tpart )
    nsta = NaN;
else
    nsta = str2double( tpart );
end
   
tpart = tline(52:55);
if isStringBlank( tpart )
    err = NaN;
else
    err = str2double( tpart );
end
   
tpart = tline(56:59);
if isStringBlank( tpart )
    mag = NaN;
else
    mag = str2double( tpart );
end
   
mag_type = tline(60);

mag_agency = tline(61:63);