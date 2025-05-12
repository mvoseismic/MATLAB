function arclen = epiDistUSGS( lonLatString )
%
% Calculates epicentral distance of an earthquake from a seismic station
% Station assumed to be MBFL
% arclen = epiDistUSGS( lonLatString )
% lonLatString is cut from USGS latest eartquakes info
%
% R.C. Stewart, 2024-07-19

out2 = sscanf(lonLatString, '%f°%c %f°%c');

if out2(2) == 83
    latQuake = -1 * out2(1);
else
    latQuake = out2(1);
end

if out2(4) == 87
    lonQuake = -1 * out2(3);
else
    lonQuake = out2(3);
end

arclen = epiDist( latQuake, lonQuake );
