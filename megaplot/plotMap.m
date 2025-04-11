function plotMap( setup, Hypo, whither )
%
% Plots hypocentre data on a map
%
% R.C. Stewart, 20-Feb-2020

if nargin < 3
    whither = 'Montserrat';
end
    
map_basemap( whither, 'gshhs' );

lat = [Hypo.lat];
lon = [Hypo.lon];

plotm( lat, lon, 'ro' );