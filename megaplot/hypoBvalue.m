function hypoBvalue( setup, Hypo )
%
% Creates plots for b-values
%
% R.C. Stewart, 14-Jan-2019

if  nargin == 0
    setup = setupGlobals();
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypo.mat' );
    load( data_file );
end

if nargin == 1
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypo.mat' );
    load( data_file );
end


mag = [Hypo.mag];


edges = [-0.5:0.25:5.5];

figure;

subplot( 2,1,1);
h = histogram( mag, edges );
xlabel( 'Magnitude (ML)' );

X = h.BinEdges;
X = X(1:length(X)-1);
Y = h.BinCounts;
Y = cumsum( Y, 'reverse' );

subplot( 2,1,2);
semilogy(X,Y, 'b*');
xlabel( 'Magnitude (ML)' );
ylabel( 'n, M >= ML' );
xlim( [-0.5 4] );
ylim( [1 2000] );