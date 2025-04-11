function [XYZ,STACODE] = sta_xyz( net )
%
% Returns UTM coordinates for a network
% as x, y , z relative to mean
%
% Rod Stewart, SRC, 2010-12-08

[S,T] = sta_utm( net );

Sm = mean( S );

[nr,nc] = size( S );

Sm2 = repmat( Sm, [nr 1] );

XYZ = S - Sm2;

STACODE = T;

return