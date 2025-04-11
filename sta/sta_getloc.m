function LLD = sta_getloc( stations )
%
% Returns Lat, long and Depth of stations in a network
% Depth is in km
%
% Rod Stewart, 2009-05-23

% Location data text file
stalocfile = '/home/stewart/data/seismic/SeismicStations/locations.txt';

nsta = length( stations );

for ii = 1:nsta
    sta = char( stations(ii) );
%    fprintf( 1, '%s\n', sta );
    cmd = sprintf( 'grep %s %s | grep " y, "', sta, stalocfile );
%    fprintf( 1, '%s\n', cmd );
    [status, result] = unix( cmd );
    if status
        fprintf( 1, '%20s: error finding location for %s\n', 'sta_getloc', sta );
        Lat(ii) = NaN;
        Lon(ii) = NaN;
        Dep(ii) = NaN;
    else
        idx = findstr( result, ',' );
        Lat(ii) = str2num( result(idx(1)+1:idx(2)-1) );
        Lon(ii) = str2num( result(idx(2)+1:idx(3)-1) );
        Dep(ii) = str2num( result(idx(3)+1:idx(4)-1) );
        Dep(ii) = Dep(ii) / 1000.0;
    end
end

LLD = [Lat' Lon' Dep'];

return