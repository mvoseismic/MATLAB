function fetchVolcstat( setup, ouf )
% 
% Fetches daily counts produced by volcstat and saves them as MATLAB arrays
%
% R.C. Stewart 01-Jan-2020

% Create arrays to hold data

datim_volcstat = ( setup.DataBeg : 1 : setup.DataEnd );

% I keep forgetting the codes!
%
%   t  vt      VTs
%   h  hy      hybrids
%   l  lp      LPs
%   e  lr      LP-rockfalls
%   r  ro      rockfalls
%   x  ex      explosions
%   s  sw      swarms
%   n  no      noises
%   m  mo      monochromatics
%      all
%      alllp   all LFs - lp + hy +lr
%      allrf   all rockfalls - rf + lr
%      vtstr   string VTs
%      vtnst   non-string VTs
%      nsta    number of stations

count_volcstat_vt = zeros( size(datim_volcstat) );
count_volcstat_hy = zeros( size(datim_volcstat) );
count_volcstat_lp = zeros( size(datim_volcstat) );
count_volcstat_lr = zeros( size(datim_volcstat) );
count_volcstat_ro = zeros( size(datim_volcstat) );
count_volcstat_ex = zeros( size(datim_volcstat) );
count_volcstat_sw = zeros( size(datim_volcstat) );
count_volcstat_no = zeros( size(datim_volcstat) );
count_volcstat_mo = zeros( size(datim_volcstat) );

count_volcstat_all = zeros( size(datim_volcstat) );
count_volcstat_alllp = zeros( size(datim_volcstat) );
count_volcstat_allrf = zeros( size(datim_volcstat) );
count_volcstat_vtstr = zeros( size(datim_volcstat) );
count_volcstat_vtnst = zeros( size(datim_volcstat) );

count_volcstat_nsta = zeros( size(datim_volcstat) );

% Loop round volcstat event types
for ev_type = ["t", "h", "l", "e", "r", "x", "s", "n", "m" ]
%for ev_type = ["t", "h", "l", "e", "r", "x" ]
    
    data_file = sprintf( 'volcstat_daily_%1c.out', ev_type );
%    data_file = sprintf( 'volcstat_daily_%1c-fixed.out', ev_type );
    
    data_file = fullfile( setup.DirSeisanCounts, data_file );
    
    fileInfo = dir( data_file );
    
    % Avoid empty and non-existent files
    if [fileInfo.bytes] > 0
    
        % Read and decode volcstat file
        A = readmatrix( data_file, 'FileType', 'text' );
        datim = A(:,1);
        count = A(:,2);
        yea = floor( datim / 10000 );
        mon = floor( ( datim - yea*10000 ) / 100 );
        day = floor( ( datim - yea*10000 - mon*100 ) );
        datim = datenum( yea, mon, day, 0, 0, 0 );
    
        % Assign data to data array
        for idatim = 1:length( datim )
        
            idd = ( datim_volcstat == datim( idatim ) );
        
            switch ev_type
            
                case "t"
                    count_volcstat_vt( idd ) = count( idatim );
        
                case "h"
                    count_volcstat_hy( idd ) = count( idatim );
        
                case "l"
                    count_volcstat_lp( idd ) = count( idatim );
        
                case "e"
                    count_volcstat_lr( idd ) = count( idatim );
        
                case "r"
                    count_volcstat_ro( idd ) = count( idatim );
        
                case "x"
                    count_volcstat_ex( idd ) = count( idatim );

                case "s"
                    count_volcstat_sw( idd ) = count( idatim );
        
                case "n"
                    count_volcstat_no( idd ) = count( idatim );
        
                case "m"
                    count_volcstat_mo( idd ) = count( idatim );
                
            end 
        end
    end
     
end
  
% Read VT string counts
data_file = fullfile( setup.DirSeisanCounts, 'volcstat_daily_t_string' );
A = readmatrix( data_file, 'FileType', 'text' );
datim = A(:,1);
count = A(:,3);
yea = floor( datim / 10000 );
mon = floor( ( datim - yea*10000 ) / 100 );
day = floor( ( datim - yea*10000 - mon*100 ) );
datim = datenum( yea, mon, day, 0, 0, 0 );
for idatim = 1:length( datim )    
    idd = ( datim_volcstat == datim( idatim ) );
    count_volcstat_vtstr( idd ) = count( idatim );
end

% Special to fix error in data file
count_volcstat_vtstr( count_volcstat_vtstr < 0 ) = 0;

count_volcstat_vtnst = count_volcstat_vt - count_volcstat_vtstr;
% Cheat to deal with volcstat bug
count_volcstat_vtnst( count_volcstat_vtnst < 0 ) = 0;
    
% Populate multi-type arrays
count_volcstat_alllp = count_volcstat_hy + count_volcstat_lp;
count_volcstat_allrf = count_volcstat_ro + count_volcstat_lr;
count_volcstat_all = count_volcstat_vt + count_volcstat_hy ...
    + count_volcstat_lp + count_volcstat_lr + count_volcstat_ro ...
    + count_volcstat_ex;

fprintf( 1, "==== fetchVolcstat\n" );
fprintf( 1, "total VTs:              %6d\n", sum( count_volcstat_vt ) );
fprintf( 1, "total hybrids:          %6d\n", sum( count_volcstat_hy ) );
fprintf( 1, "total LPs:              %6d\n", sum( count_volcstat_lp ) );
fprintf( 1, "total LP-rockfalls:     %6d\n", sum( count_volcstat_lr ) );
fprintf( 1, "total rockfalls:        %6d\n", sum( count_volcstat_ro ) );
fprintf( 1, "total explosions:       %6d\n", sum( count_volcstat_ex ) );
fprintf( 1, "total swarms:           %6d\n", sum( count_volcstat_sw ) );
fprintf( 1, "total noise:            %6d\n", sum( count_volcstat_no ) );
fprintf( 1, "total monochromatic:    %6d\n", sum( count_volcstat_mo ) );
fprintf( 1, "derived\n" );
fprintf( 1, "total all LF:           %6d\n", sum( count_volcstat_alllp ) );
fprintf( 1, "total all rockfall:     %6d\n", sum( count_volcstat_allrf ) );
fprintf( 1, "total all events:       %6d\n", sum( count_volcstat_all ) );
fprintf( 1, "VT subtypes\n" );
fprintf( 1, "total all VTs:          %6d\n", sum( count_volcstat_vt ) );
fprintf( 1, "total string VTs:       %6d\n", sum( count_volcstat_vtstr ) );
fprintf( 1, "total non-string VTs:   %6d\n", sum( count_volcstat_vtnst ) );

if nargin == 2
    fprintf( ouf, "==== fetchVolcstat\n" );
    fprintf( ouf, "total VTs:              %6d\n", sum( count_volcstat_vt ) );
    fprintf( ouf, "total hybrids:          %6d\n", sum( count_volcstat_hy ) );
    fprintf( ouf, "total LPs:              %6d\n", sum( count_volcstat_lp ) );
    fprintf( ouf, "total LP-rockfalls:     %6d\n", sum( count_volcstat_lr ) );
    fprintf( ouf, "total rockfalls:        %6d\n", sum( count_volcstat_ro ) );
    fprintf( ouf, "total explosions:       %6d\n", sum( count_volcstat_ex ) );
    fprintf( ouf, "total swarms:           %6d\n", sum( count_volcstat_sw ) );
    fprintf( ouf, "total noise:            %6d\n", sum( count_volcstat_no ) );
    fprintf( ouf, "total monochromatic:    %6d\n", sum( count_volcstat_mo ) );
    fprintf( ouf, "derived\n" );
    fprintf( ouf, "total all LF:           %6d\n", sum( count_volcstat_alllp ) );
    fprintf( ouf, "total all rockfall:     %6d\n", sum( count_volcstat_allrf ) );
    fprintf( ouf, "total all events:       %6d\n", sum( count_volcstat_all ) );
    fprintf( ouf, "VT subtypes\n" );
    fprintf( ouf, "total all VTs:          %6d\n", sum( count_volcstat_vt ) );
    fprintf( ouf, "total string VTs:       %6d\n", sum( count_volcstat_vtstr ) );
    fprintf( ouf, "total non-string VTs:   %6d\n", sum( count_volcstat_vtnst ) );
    fprintf( ouf, "\n" );
end

% Save to file
%{
data_file = fullfile( setup.DirMegaplotData, 'fetchedVolcstat.mat' );

save( data_file, 'datim_volcstat', ...
    'count_volcstat_vt', 'count_volcstat_hy', ...
    'count_volcstat_lp', 'count_volcstat_lr', ...
    'count_volcstat_ro', 'count_volcstat_ex', ...
    'count_volcstat_all', 'count_volcstat_alllp', 'count_volcstat_allrf', ...
    'count_volcstat_vtstr', 'count_volcstat_vtnst', ...
    'count_volcstat_sw', 'count_volcstat_no', 'count_volcstat_mo');
%}

% Read data availability
dirDaRsam = fullfile( setup.DirHome, '/projects/seismic_data_availability' );
load( fullfile( dirDaRsam, 'dataavail_RSAM.mat'));
YDnsta = sum( YD );
for idatim = 1:length( XD )
        idd = ( datim_volcstat == XD( idatim ) );
        count_volcstat_nsta( idd ) = YDnsta( idatim );
end

% Create Count structures
CountVolcstatVT = createCountVolcstat( datim_volcstat, count_volcstat_vt, 'VT' );
CountVolcstatHY = createCountVolcstat( datim_volcstat, count_volcstat_hy, 'HY' );
CountVolcstatLP = createCountVolcstat( datim_volcstat, count_volcstat_lp, 'LP' );
CountVolcstatLR = createCountVolcstat( datim_volcstat, count_volcstat_lr, 'LR' );
CountVolcstatRO = createCountVolcstat( datim_volcstat, count_volcstat_ro, 'RO' );
CountVolcstatEX = createCountVolcstat( datim_volcstat, count_volcstat_ex, 'EX' );
CountVolcstatALL = createCountVolcstat( datim_volcstat, count_volcstat_all, 'ALL' );
CountVolcstatALLLP = createCountVolcstat( datim_volcstat, count_volcstat_alllp, 'ALLLP' );
CountVolcstatALLRF = createCountVolcstat( datim_volcstat, count_volcstat_allrf, 'ALLRF' );
CountVolcstatVTSTR = createCountVolcstat( datim_volcstat, count_volcstat_vtstr, 'VTSTR' );
CountVolcstatVTNST = createCountVolcstat( datim_volcstat, count_volcstat_vtnst, 'VTNST' );
CountVolcstatSW = createCountVolcstat( datim_volcstat, count_volcstat_sw, 'SW' );
CountVolcstatNO = createCountVolcstat( datim_volcstat, count_volcstat_no, 'NO' );
CountVolcstatMO = createCountVolcstat( datim_volcstat, count_volcstat_mo, 'MO' );
CountVolcstatNSTA = createCountVolcstat( datim_volcstat, count_volcstat_nsta, 'NSTA' );

% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedCountVolcstat.mat' );

save( data_file, 'CountVolcstatVT', 'CountVolcstatHY', 'CountVolcstatLP', ...
    'CountVolcstatLR', 'CountVolcstatRO', 'CountVolcstatEX', 'CountVolcstatALL', ...
    'CountVolcstatALLLP', 'CountVolcstatALLRF', 'CountVolcstatVTSTR', ...
    'CountVolcstatVTNST', 'CountVolcstatVTNST', 'CountVolcstatSW', ...
    'CountVolcstatNO', 'CountVolcstatMO', 'CountVolcstatNSTA' );


return

function Count = createCountVolcstat( datim, data, ev_type )

Count = defineCount();

Count.datimBeg = datim(1);
Count.datimEnd = datim(length(datim)) + 1.0;

Count.binFreq = 'daily';
Count.binWidth = 1.0;

Count.data = data;
Count.datim = datim;

switch ev_type
    case 'VT'
        pt = 'VT events';
        pl = 'VTs';
    case 'HY'
        pt = 'Hybrid events';
        pl = 'Hybrids';
    case 'LP'
        pt = 'LP events';
        pl = 'LPs';
    case 'LR'
        pt = 'LP/RF events';
        pl = 'LP/RFs';
    case 'RO'
        pt = 'Rockfalls';
        pl = 'Rockfalls';
    case 'EX'
        pt = 'Explosions';
        pl = 'Explosions';
    case 'ALL'
        pt = 'All events';
        pl = 'All';
    case 'ALLLP'
        pt = 'All LF events';
        pl = 'All LFs';
    case 'ALLRF'
        pt = 'All rockfalls';
        pl = 'All rockfalls';
    case 'VTSTR'
        pt = 'string VT events';
        pl = 'string VTs';
    case 'VTNST'
        pt = 'non-string VT events';
        pl = 'non-string VTs';
    case 'SW'
        pt = 'Swarms';
        pl = 'Swarms';
    case 'NO'
        pt = 'Noise events';
        pl = 'Noise';
    case 'MO'
        pt = 'Monochromatic events';
        pl = 'Monochromatics';
    case 'NSTA'
        pt = 'Number of stations';
        pl = 'nsta';
    case 'VTSTRPC'
        pt = '% string VT events';
        pl = '% string VTs';
end

Count.title = pt;
Count.label = pl;
