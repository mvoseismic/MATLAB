function XYZ = epi2xyz( epi )
%
% Gets lat and long out of the structure and returns X Y and Z
%
% Rod Stewart, 2008-09-16

n_epi = length( epi );

for ii=1:n_epi
    XYZ(ii,1) = epi(ii).longitude;
    XYZ(ii,2) = epi(ii).latitude;
    XYZ(ii,3) = -1.0 * epi(ii).depth;
end