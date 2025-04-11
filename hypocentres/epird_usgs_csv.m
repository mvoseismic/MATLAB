function epi = epird_usgs_csv( filename )
%
% epird_usgs_csv
%
% Reads epicentres from USGS csv file
%
% Rod Stewart, 2008-09-12

epi = struct(   'otime', {}, ...
                'latitude', {}, ...
                'longitude', {}, ...
                'mb', {}, ...
                'depth', {} );
            
commentlines = 1;

ALL = csvread( filename, commentlines, 0 );

[n_epi, n_fields] = size(ALL);

for ii=1:n_epi
    
    epi(ii).latitude = ALL(ii,5);
    epi(ii).longitude = ALL(ii,6);
    epi(ii).mb = ALL(ii,7);
    epi(ii).depth = ALL(ii,8);
    
    d_yr = ALL(ii,1);
    d_mo = ALL(ii,2);
    d_da = ALL(ii,3);
    
    stim = sprintf( '%09.2f', ALL(ii,4) );
    stim2 = sprintf( '%2s:%2s:%5s', stim(1:2), stim(3:4), stim(5:9) );
    s_day = datestr( d_yr, d_mo, d_da );
    
    epi(ii).otime = [s_day ' ' stim2];
    
end

