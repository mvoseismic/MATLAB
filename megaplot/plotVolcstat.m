function plotVolcstat( setup, ev_type, plot_type, plot_symcol, cum )
%
% Plots data from volcstat output files
%
% R.C. Stewart 1-Jan-2020
% rewritten for Count structures, 27-Feb-2020

data_file = fullfile( setup.DirMegaplotData, 'fetchedCountVolcstat.mat' );
load( data_file );

switch ev_type
    case 'vt'
        Count = CountVolcstatVT;
    case 'vtstr'
        Count = CountVolcstatVTSTR;
    case 'vtnst'
        Count = CountVolcstatVTNST;
    case 'hy'
        Count = CountVolcstatHY;
    case 'lp'
        Count = CountVolcstatLP;
    case 'ex'
        Count = CountVolcstatEX;
    case 'ro'
        Count = CountVolcstatRO;
    case 'lr'
        Count = CountVolcstatLR;
    case 'all'
        Count = CountVolcstatALL;
    case 'alllp'
        Count = CountVolcstatALLLP;
    case 'allrf'
        Count = CountVolcstatALLRF;
    case 'sw'
        Count = CountVolcstatSW;
    case 'mo'
        Count = CountVolcstatMO;
    case 'no'
        Count = CountVolcstatNO;
    case 'nsta'
        Count = CountVolcstatNSTA;
end

plotCount( setup, Count, plot_type, plot_symcol, cum );

