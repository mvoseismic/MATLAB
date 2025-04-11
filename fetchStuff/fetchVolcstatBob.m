function fetchVolcstatBob( setup, ouf )
% 
% Fetches daily counts from BOB data files and saves them as MATLAB arrays
%
% R.C. Stewart 2024-08-29

% Create arrays to hold data


% I keep forgetting the codes!
%
%   t  vt      VTs
%   h  hy      hybrids
%   l  lp      LPs
%   r  ro      rockfalls
%      pl      plinks
%      tr      tremor
%      all
%      alllp   all LPs - lp + hy

dirBob = '/home/seisan/projects/megaplot2a/data/bob';
fileBob = fullfile( dirBob, "COUNT.DAT" );

opts = fixedWidthImportOptions( ...
    'VariableNamesLine',3, ...
    'DataLines',5, ...
    'NumVariables',7, ...
    'VariableWidths',[15 4 4 4 4 4 6], ...
    'VariableTypes',{'datetime','double','double','double','double','double','double'});
opts = setvaropts(opts,1,'InputFormat','dd MMM yy HH:mm','DatetimeFormat','preserveinput');
B = readtable(fileBob,opts);
B = standardizeMissing(B,-998);
B = B(1:607,:);


datim_volcstat_bob = datenum( B.Var1 );

count_volcstat_bob_vt = B.VT;
count_volcstat_bob_lp = B.LP;
count_volcstat_bob_hy = B.HYB;
count_volcstat_bob_ro = B.RF;
count_volcstat_bob_pl = B.PLK;
count_volcstat_bob_tr = B.Var7;

% Create Count structures
CountVolcstatBobVT = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_vt, 'VT' );
CountVolcstatBobHY = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_hy, 'HY' );
CountVolcstatBobLP = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_lp, 'LP' );
CountVolcstatBobRO = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_ro, 'RO' );
CountVolcstatBobPL = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_pl, 'PL' );
CountVolcstatBobTR = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_tr, 'TR' );

% Remove NaNs for sums
count_volcstat_bob_vt(isnan(count_volcstat_bob_vt)) = 0;
count_volcstat_bob_hy(isnan(count_volcstat_bob_hy)) = 0;
count_volcstat_bob_lp(isnan(count_volcstat_bob_lp)) = 0;
count_volcstat_bob_ro(isnan(count_volcstat_bob_ro)) = 0;
count_volcstat_bob_pl(isnan(count_volcstat_bob_pl)) = 0;
count_volcstat_bob_tr(isnan(count_volcstat_bob_tr)) = 0;

count_volcstat_bob_all = count_volcstat_bob_lp + count_volcstat_bob_hy + ...
    count_volcstat_bob_vt + count_volcstat_bob_ro + count_volcstat_bob_pl;
count_volcstat_bob_alllp = count_volcstat_bob_lp + count_volcstat_bob_hy;

CountVolcstatBobALL = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_all, 'ALL' );
CountVolcstatBobALLLP = createCountVolcstat( datim_volcstat_bob, count_volcstat_bob_alllp, 'ALLLP' );


% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedCountVolcstatBob.mat' );

save( data_file, 'CountVolcstatBobVT', 'CountVolcstatBobHY', 'CountVolcstatBobLP', ...
    'CountVolcstatBobRO', 'CountVolcstatBobPL', 'CountVolcstatBobALL', ...
    'CountVolcstatBobALLLP', 'CountVolcstatBobTR' );


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
    case 'RO'
        pt = 'Rockfalls';
        pl = 'Rockfalls';
    case 'ALL'
        pt = 'All events';
        pl = 'All';
    case 'ALLLP'
        pt = 'All LP events';
        pl = 'All LPs';
    case 'PL'
        pt = 'MGAT plink events';
        pl = 'Plinks';
    case 'TR'
        pt = 'Tremor';
        pl = 'Tremor';
end

Count.title = pt;
Count.label = pl;
