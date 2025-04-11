function calcSpanRates( setup, ev_type, Vlines )
%
% Calculates mean event rates based on Vlines
%
% R.C. Stewart, 30-Jan-2020

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
end
  
datims = [Count.datim];
counts = [Count.data];

nspan = length( Vlines );

fprintf( 1, 'event type: %5s\n', ev_type );

for ispan = 1:nspan+1
    
    if ispan == nspan+1
        
        datim_beg = Vlines(1).datim;
        datim_end = dateCommon( 'begDay' ) - 1;
        
    else
    
        datim_beg = Vlines(ispan).datim;
    
        if ispan == nspan        
            datim_end = dateCommon( 'begDay' ) - 1;  
        else
            datim_end = Vlines(ispan+1).datim - 1 ;
        end
        
    end
    
    idwant1 = datims >= datim_beg;
    idwant2 = datims <= datim_end;
    idwant = idwant1 & idwant2;
    
    ndays = sum( idwant );
    nevs = sum( counts( idwant ) );
    evrate = nevs / ndays;
    
    fprintf( 1, '  %s - %s', datestr( datim_beg, 20 ), datestr( datim_end, 20 ) );
    fprintf( 1, '  %4d', ndays );
    fprintf( 1, '  %6d', nevs );
    fprintf( 1, '  %6.2f\n', evrate );
    
end
   

