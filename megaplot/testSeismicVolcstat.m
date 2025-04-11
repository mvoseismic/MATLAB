% Test Volcstat plots

setup = setupGlobals();
setup.PlotBeg = datenum( 2019, 1, 1, 0, 0, 0 );
setup.PlotEnd = datenum( 2020, 3, 1, 0, 0, 0 );
setup.CountBinResamp = 'no';

plotSeismicCounts( setup, 'vtt' );

