function arclen = epiDistUSGS( lonLatString )
%
% Calculates epicentral distance of an earthquake from a seismic station
% Station assumed to be MBFL
% arclen = epiDistUSGS( lonLatString )
% lonLatString is cut from USGS latest eartquakes info
%
% R.C. Stewart, 2024-07-19

out2 = sscanf(lonLatString, '%f°N %f°W');
lonQuake = out2(1);
latQuake = out2(2);

arclen = epiDist( latQuake, lonQuake );
