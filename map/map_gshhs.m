function map_gshhs( where )
%
% Draws gshhs coastlines on maps
%
% Rod Stewart, 2010-05-12

[lat_lim, lon_lim] = map_define( where );

% Average dimension of map, in degrees
dim_ave = mean( [lat_lim(2)-lat_lim(1) lon_lim(2)-lon_lim(1)] );

% Set resolution to use
if dim_ave >= 90.0
    file_name = 'gshhs_c.b';
elseif dim_ave >= 30.0
    file_name = 'gshhs_l.b';
elseif dim_ave >= 10.0
    file_name = 'gshhs_i.b';
elseif dim_ave >= 5.0
    file_name = 'gshhs_h.b';
else
    file_name = 'gshhs_f.b';
end

% GSHHS file
dir_gshhs = '/Users/stewart/data/_local/geographic/VectorData/gshhs/gshhs1.10';
file_name = fullfile( dir_gshhs, file_name );

%index_name = gshhs(file_name, 'createindex');
gshhs_data = gshhs(file_name,lat_lim, lon_lim);

[lat_shift,lon_shift] = map_latlon_shift( where );

if lon_shift ~= 0.0
    for ii = 1:length(gshhs_data)
        gshhs_data(ii).Lon = gshhs_data(ii).Lon + lon_shift;
    end
end

if lat_shift ~= 0.0
    for ii = 1:length(gshhs_data)
        gshhs_data(ii).Lat = gshhs_data(ii).Lat + lat_shift;
    end
end

geoshow( gshhs_data, 'FaceColor', [0.5 0.7 0.5] );
setm( gca, 'FFaceColor', 'cyan' );

return
