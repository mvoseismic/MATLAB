function dist = distSlessP( tdiff, vp )
%
% Calculates distance of a seismic source given S-P time and P velocity
%
% R.C. Stewart, 2024-02-17

vs = vp/1.73;

dist = tdiff / ( 1/vs - 1/vp );


