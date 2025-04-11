function [X,Y,Z] = dem2xyz( I, R )

X = linspace( R.XWorldLimits(1), R.XWorldLimits(2), size(I,2) );
Y = linspace( R.YWorldLimits(1), R.YWorldLimits(2), size(I,1) );

Z = flipud( I );
Y = flipud( Y );

