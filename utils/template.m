clear;
close all;

setup = setupGlobals();
reFetch( setup );

figure;
figure_size( 'l', 1200 );

fileSave = sprintf( "%s.png", mfilename );
saveas( gcf, fileSave );