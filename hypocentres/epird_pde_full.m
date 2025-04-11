function epi = epird_pde_full( filename )
%
% epird_usgs_pde-full
%
% Reads epicentres from USGS NEIC PDE text file
%
% Rod Stewart, 2008-09-15

epi = struct(   'otime', {}, ...
                'latitude', {}, ...
                'longitude', {}, ...
                'mb', {}, ...
                'depth', {} );
            
% Grep the file to get a temporary file
cmd = sprintf( 'grep ^\\ PDE %s > temp.txt', filename );
system( cmd );

% open the file
fid = fopen( 'temp.txt' );

% Get the data into the file

[C] = textscan( fid, '%9n%d %d %d %f %f %f %d%12n%f' );

n_epi = length( C );

for ii=1:n_epi
    
    epi(ii).latitude = C(ii,5);
    epi(ii).longitude = C(ii,6);
    epi(ii).mb = C(ii,8);
    epi(ii).depth = C(ii,7);
    
    d_yr = C(ii,1);
    d_mo = C(ii,2);
    d_da = C(ii,3);
    
    stim = sprintf( '%09.2f', C(ii,4) );
    stim2 = sprintf( '%2s:%2s:%5s', stim(1:2), stim(3:4), stim(5:9) );
    s_day = datestr( d_yr, d_mo, d_da );
    
    epi(ii).otime = [s_day ' ' stim2];
    
end

