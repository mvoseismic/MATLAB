function [XYZ,STACODE] = sta_utm( net )
%
% Returns UTM coordinates for a network
%
% Rod Stewart, SRC, 2010-12-08

[S,T] = sta_get( net );

lat_sta = S(:,1);
lon_sta = S(:,2);
alt_sta = S(:,3);

% Get UTM xone
p1 = [ lat_sta(1), lon_sta(1) ];
zone = utmzone(p1);

% Set UTM thing
utmstruct = defaultm('utm'); 
utmstruct.zone = zone; 
utmstruct.geoid = utmgeoid(zone); 
utmstruct = defaultm(utmstruct);

% transform stations to UTM
[x,y] = mfwdtran(utmstruct,lat_sta,lon_sta);
nsta = length(x);
z = alt_sta;

STACODE = T;
XYZ = [x, y, z];

return