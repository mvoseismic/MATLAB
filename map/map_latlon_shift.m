function [lat_shift,lon_shift] = map_latlon_shift( where )
%
% Returns shifts required to fix things
%
% Rod Stewart, 2010-05-12

switch where
    case {'Dominica', 'DominicaN', 'DominicaNW', 'DominicaPlus' }
        lon_shift = km2deg( 1.0 );
        lat_shift = km2deg( 0.1 );
    otherwise
        lon_shift = 0.0;
        lat_shift = 0.0;
end


return
