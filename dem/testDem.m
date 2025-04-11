clear;
setup = setupGlobals;

figure_size('l');

[I2,R2] = fetchDem2014shaded( setup );
[I1,R1] = fetchDem2014( setup );

[X1,Y1,Z1] = dem2xyz( I1, R1 );
[X2,Y2,Z2] = dem2xyz( I2, R2 );

latSummit =  16.7109182;
lonSummit = -62.1774199;
X1 = deg2km( X1 - lonSummit );
Y1 = deg2km( Y1 - latSummit );
X2 = deg2km( X2 - lonSummit );
Y2 = deg2km( Y2 - latSummit );

subplot(2,2,1);
mapshow(I1,R1);
colormap gray;

subplot(2,2,2);
mapshow(I2,R2);
colormap gray;

subplot(2,2,3);
imagesc(X1,Y1,Z1);
set(gca,'YDir','normal')

subplot(2,2,4);
imagesc(X2,Y2,Z2);
set(gca,'YDir','normal')
colormap bone;


%{
I(isnan(I)) = 0.0;
[X,Y,Z] = dem2xyz( I, R );

latSummit =  16.7109182;
lonSummit = -62.1774199;
X = deg2km( X - lonSummit );
Y = deg2km( Y - latSummit );

imagesc(X,Y,Z);
colormap bone;
xLimits = [-3.1 3.1];
yLimits = xLimits;

%}

