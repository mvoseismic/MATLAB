function [S,T] = sta_get( net )
%
% Gets station locations using SeismicStations data
%
% Rod Stewart, 2010-05-10

setup = setupGlobals();

dir_here = pwd;
%dir_ss = '/Users/stewart/trav/data/seismic/SeismicStations';
%dir_ss = '/Users/stewart/OneDrive - The University of the West Indies/data/seismic/SeismicStations';
dir_ss = fullfile( setup.DirStuff, 'data/seismic/SeismicStations' );

cd( dir_ss );

command = sprintf( './net2locy %s | awk ''{print $2 $3 $4}'' > temp.csv', net );
system( command );

command = sprintf( './net2locy %s | awk -F, ''{print $1}'' > temp.txt', net );
system( command );

cd( dir_here );

St = dlmread( fullfile( dir_ss, 'temp.csv' ) );
S = St(:,1:3);

fid = fopen( fullfile( dir_ss, 'temp.txt' ) );
T = textscan( fid, '%s' );
fclose( fid );

return
