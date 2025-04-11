function arclen = epiDist( latQuake, lonQuake, latSta, lonSta )
%
% Calculates epicentral distance of an earthquake from a seismic station
% Station assumed to be MBFL if not given as argument
% arclen = epiDist( latQuake, lonQuake, <latSta>, <lonSta> )
%
% R.C. Stewart, 2022-11-11

if ~exist('lonSta','var')
    latSta = 16.7485; % MBFL
    lonSta = -62.2125;
end

[arclen,az] = distance(latSta,lonSta,latQuake,lonQuake);
arckm = deg2km( arclen );

fprintf( '  distance: %7.1f degrees\n', arclen );
fprintf( '  distance: %7.0f km\n', arckm );
fprintf( '  azimuth:  %7.1f degrees\n', az );

