function fetchMSS1counts( setup, ouf )
% 
% Fetches manual seismic event counts from MSS1 and stores in 
% Count structures
%
% R.C. Stewart 27-Feb-2020

% Read data from file
data_file = 'SeismicityDiary.xlsx';
data_file = fullfile( setup.DirSeismicData, data_file );
A = readmatrix( data_file, 'NumHeaderLines', 1, 'Sheet', 'MSS1Counts' );

% Change all NaNs to 0
id_nan = isnan( A );
A( id_nan ) = 0;

datim = date_xl2mat( A(:,1) );
datim = datim';
counts = A(:,2);
counts1 = counts';
counts = A(:,3);
counts2 = counts';
counts = A(:,4);
counts3 = counts';
counts = A(:,5);
dataavail = counts';
counts = A(:,6);
nstring = counts';
counts = A(:,7);
nministring = counts';

ndata = length( datim );

datimBeg = datim(1);
datimEnd = datim(ndata) + 1.0;


% Normalise using data availability
id_da = dataavail > 0;
counts1(id_da) = counts1(id_da) * 100.0 ./ dataavail(id_da);
counts2(id_da) = counts2(id_da) * 100.0 ./ dataavail(id_da);
counts3(id_da) = counts3(id_da) * 100.0 ./ dataavail(id_da);

% Put -1.0 for days with no data
id_nd = dataavail == 0;
counts1(id_nd) = -1;
counts2(id_nd) = -1;
counts3(id_nd) = -1;

CountMss1ALL = defineCount;
CountMss1ALL.datimBeg = datimBeg;
CountMss1ALL.datimEnd = datimEnd;
CountMss1ALL.binFreq = 'daily';
CountMss1ALL.binWidth = 1.0;
CountMss1ALL.data = counts1;
CountMss1ALL.datim = datim + 0.5;
CountMss1ALL.title = 'Count of all events on MSS1';
CountMss1ALL.label = 'N';
%tsCountMss1ALL = timeseries( datim, counts1, 'Name', 'MSS1 All' );

CountMss1VT = defineCount;
CountMss1VT.datimBeg = datimBeg;
CountMss1VT.datimEnd = datimEnd;
CountMss1VT.binFreq = 'daily';
CountMss1VT.binWidth = 1.0;
CountMss1VT.data = counts2;
CountMss1VT.datim = datim + 0.5;
CountMss1VT.title = 'Count of larger VT events on MSS1';
CountMss1VT.label = 'VT';
%tsCountMss1VT = timeseries( datim, counts2, 'Name', 'MSS1 VTs' );

CountMss1RF = defineCount;
CountMss1RF.datimBeg = datimBeg;
CountMss1RF.datimEnd = datimEnd;
CountMss1RF.binFreq = 'daily';
CountMss1RF.binWidth = 1.0;
CountMss1RF.data = counts3;
CountMss1RF.datim = datim + 0.5;
CountMss1RF.title = 'Count of larger RF events on MSS1';
CountMss1RF.label = 'RF';
%tsCountMss1Rf = timeseries( datim, counts1, 'Name', 'MSS1 RFs' );

CountMss1DataAvail = defineCount;
CountMss1DataAvail.datimBeg = datimBeg;
CountMss1DataAvail.datimEnd = datimEnd;
CountMss1DataAvail.binFreq = 'daily';
CountMss1DataAvail.binWidth = 1.0;
CountMss1DataAvail.data = dataavail;
CountMss1DataAvail.datim = datim + 0.5;
CountMss1DataAvail.title = 'Data availability at MSS1';
CountMss1DataAvail.label = '%';
%tsCountMss1DataAvail = timeseries( datim, counts1, 'Name', 'MSS1 Data Availability' );

CountMss1String = defineCount;
CountMss1String.datimBeg = datimBeg;
CountMss1String.datimEnd = datimEnd;
CountMss1String.binFreq = 'daily';
CountMss1String.binWidth = 1.0;
CountMss1String.data = nstring;
CountMss1String.datim = datim + 0.5;
CountMss1String.title = 'Strings on MSS1';
CountMss1String.label = 'N';
%tsCountMss1String = timeseries( datim, counts1, 'Name', 'MSS1 Strings' );

id_nan = isnan( nministring );
nministring( id_nan) = 0;
CountMss1MiniString = defineCount;
CountMss1MiniString.datimBeg = datimBeg;
CountMss1MiniString.datimEnd = datimEnd;
CountMss1MiniString.binFreq = 'daily';
CountMss1MiniString.binWidth = 1.0;
CountMss1MiniString.data = nministring;
CountMss1MiniString.datim = datim + 0.5;
CountMss1MiniString.title = 'Ministrings on MSS1';
CountMss1MiniString.label = 'N';
%tsCountMss1MiniString = timeseries( datim, counts1, 'Name', 'MSS1 Ministrings' );


fprintf( 1, "==== fetchMSS1counts\n" );
fprintf( 1, "Days read:              %6d\n", ndata );
if nargin == 2
    fprintf( ouf, "==== fetchMSS1counts\n" );
    fprintf( ouf, "Days read:              %6d\n",  ndata );
    fprintf( ouf, "\n" );
end

% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedCountMss1.mat' );
save( data_file, ...
    'CountMss1ALL', ...
    'CountMss1VT', ...
    'CountMss1RF', ...
    'CountMss1DataAvail', ...
    'CountMss1String', ...
    'CountMss1MiniString' );
%{
    'tsCountMss1ALL', ...
    'tsCountMss1VT', ...
    'tsCountMss1RF', ...
    'tsCountMss1DataAvail', ...
    'tsCountMss1String', ...
    'tsCountMss1MiniString' );
    %}
