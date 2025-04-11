function fetchSoufriereCounts( setup, ouf )
% 
% Fetches SRC seismic count event info from Joan's spreadsheet and saves them as MATLAB arrays
%
% R.C. Stewart 25-Feb-2020

% Initialise arrays
soufcounts_datims = [];
soufcounts_counts = [];


data_file = '20200219_Monty_1992-1995_Glenn_Thompson.xlsx';
filename = fullfile( setup.DirSRCData, data_file );

A = readmatrix( filename, 'NumHeaderLines', 2 );

datim = date_xl2mat( A(:,1) );
soufcounts_datims = datim';
counts = A(:,2);
soufcounts_counts = counts';
ndata = length( soufcounts_counts );

CountSoufriere = defineCount;
CountSoufriere.datimBeg = soufcounts_datims(1);
CountSoufriere.datimEnd = soufcounts_datims(ndata) + 1;
CountSoufriereg.binFreq = 'daily';
CountSoufriere.binWidth = 1.0;
CountSoufriere.data = soufcounts_counts;
CountSoufriere.datim = soufcounts_datims + 0.5;
CountSoufriere.title = 'SRC manual event counts';
CountSoufriere.label = 'N';

fprintf( 1, "==== fetchSoufriereCounts\n" );
fprintf( 1, "Days read:              %6d\n", length( counts ) );
if nargin == 2
    fprintf( ouf, "==== fetchSoufriereCounts\n" );
    fprintf( ouf, "Days read:              %6d\n", length( counts ) );
    fprintf( ouf, "\n" );
end

% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedCountsSoufriere.mat' );
save( data_file, 'CountSoufriere' );
