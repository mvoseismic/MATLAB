function epi = epifilt( epi_in, lim_lat, lim_lon, lim_mb, lim_depth )
%
% epifilt
%
% Filters epicentres
%
% Rod Stewart, 2008-09-16

epi = struct(   'otime', {}, ...
                'latitude', {}, ...
                'longitude', {}, ...
                'mb', {}, ...
                'depth', {} );
    
%if datenum(lim_otime(1)) == datenum(lim_otime(2))
%    lim_otime(1) = '01-Jan-1200';
%    lim_otime(2) =date;
%end

if lim_lat(1) == lim_lat(2)
    lim_lat(1) = -90.0;
    lim_lat(2) = 90.0;
end

if lim_lon(1) == lim_lon(2)
    lim_lon(1) = -180.0;
    lim_lon(2) = 180.0;
end

if lim_mb(1) == lim_mb(2)
    lim_mb(1) = -10.0;
    lim_mb(2) = 10.0;
end

if lim_depth(1) == lim_depth(2)
    lim_depth(1) = 0.0;
    lim_depth(2) = 1000.0;
end
    
n_epi = length( epi_in );

i_epi = 0;

for ii=1:n_epi

    if      ( epi_in(ii).latitude >= lim_lat(1) ) && ...     
            ( epi_in(ii).latitude <= lim_lat(2) ) && ...
            ( epi_in(ii).longitude >= lim_lon(1) ) && ...
            ( epi_in(ii).longitude <= lim_lon(2) ) && ...
            ( epi_in(ii).mb > lim_mb(1) ) && ...
            ( epi_in(ii).mb <= lim_mb(2) ) && ...
            ( epi_in(ii).depth > lim_depth(1) ) && ...
            ( epi_in(ii).depth <= lim_depth(2) )
        i_epi = i_epi + 1;
        epi(i_epi) = epi_in(ii);
    end

end

