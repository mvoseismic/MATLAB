function boxLatLon( distKm, lat, lon )
%
% Calculates sides of box out to distKm from lat, lon.
%
% R.C. Stewart, 2025-05-08

if ~exist('lon','var')
    lat = 16.7485; % MBFL
    lon = -62.2125;
end

degOffset = km2deg( distKm );

latMin = lat - degOffset;
latMax = lat + degOffset;
lonMin = lon - degOffset;
lonMax = lon + degOffset;


fprintf( 'Box %7.1f km around %8.3f, %8.3f\n', distKm, lat, lon );
fprintf( 'Latitude: %8.3f, to %8.3f\n', latMin, latMax );
fprintf( 'Longitude: %8.3f, to %8.3f\n', lonMin, lonMax );

