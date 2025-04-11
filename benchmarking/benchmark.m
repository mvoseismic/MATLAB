clear;

%{
setup = setupGlobals;
hostname = setup.Hostname;

t = mean( bench(16) );
fileSave = sprintf( '%s.mat', hostname );
save( fileSave, "hostname", "t" );
%}

nameTests = {'Mean','LU','FFT','ODE','Sparse','2-D','3-D'};

%fileOthers = fullfile(matlabroot, 'toolbox','matlab','general','bench.dat');
fileOthers = 'bench.dat';

others = readtable( fileOthers );
nameOthers = others.Var1;
tOthers = table2array( others(:,2:7));
mtOthers = mean( tOthers');


figure_size( 'l' );
plot( 1./tOthers', '-o', 'MarkerFaceColor','auto' );
hold on;


load 'opsproc3.mat';
nameOthers = [nameOthers;'opsproc3: Debian 12, 6-core Intel Xeon Gold 6128 @ 3.4GHz'];
mtOpsproc3 = mean( t );
plot( 1./t, 'r-o', 'LineWidth', 2.0, 'MarkerFaceColor', 'r', 'MarkerSize', 9 );

load 'hafevo.mat';
nameOthers = [nameOthers;'hafevo: Mint Linux 21, 12-core AMD Ryzen 9 7900X @ 4.7 GHz'];
plot( 1./t, 'b-o', 'LineWidth', 2.0, 'MarkerFaceColor', 'b', 'MarkerSize', 9 );
mtHafevo = mean( t );

set(gca,'ColorOrderIndex',1)
plot(0,(1./mtOthers), 'o');
plot( 0, 1/mtOpsproc3, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 9 );
plot( 0, 1/mtHafevo, 'bo', 'MarkerFaceColor', 'b', 'MarkerSize', 9 );

nameOthers = [nameOthers;''];
ylabel( 'Speed' );
xlabel( 'MATLAB benchmark' );
xticks( 0:6 );
xticklabels( nameTests );
xlim( [-0.5 6.5] );
legend( nameOthers, 'location', 'northwest' );

