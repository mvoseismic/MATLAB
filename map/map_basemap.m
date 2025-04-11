function map_basemap( whither, what )
%
% Draws the basemap
%
% where is a string indicating extent of map
% what is a string indicating data to be used
%
% Rod Stewart, 2010-05-12

[lat_lim, lon_lim] = map_define( whither );

worldmap( lat_lim, lon_lim );

switch what
    case 'gshhs'
        map_gshhs( whither );
    case 'vmap0'
        map_vmap0( whither );
    case 'imm'
        map_imm( whither );
    case 'gis'
        map_gis_data( whither );
    case 'mvo_basemap'
        map_mvo_basemap( whither );
end

        
return
