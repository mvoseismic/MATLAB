function plotVolcstatMulti( setup, ev_types, plot_type, plot_symcol, Vlines )
%
% Plots combination of volcstat types
%
% R.C. Stewart 30-Dec-2019

setup.CountBinResamp = countResampBinSize( setup );

npanes = length( ev_types );

if strcmp( setup.SubplotSpace, 'tight' )
    [ha, pos] = tight_subplot( npanes, 1, 0, [0.1 0.12], 0.1);
end

for ip = 1:npanes
    
    ev_type = ev_types{ip};
    
    switch setup.SubplotSpace
        case 'tight'
            axes(ha(ip));
            switch ip
                case 1
                    setup.PlotXaxis = 'top';
                case npanes
                    setup.PlotXaxis = 'bottom';
                otherwise
                    setup.PlotXaxis = 'none';
            end
        otherwise
            subplot( npanes, 1, ip );
    end
    
            
    plotVolcstat( setup, ev_type, plot_type, plot_symcol, 0 );
    
    if nargin == 6
    
        plotVertLines( Vlines );
    
    end
    
end

switch [setup.CountBinResamp]
    case 'weekly'
        header_pt = 'Weekly';
    case 'fortnightly'
        header_pt = 'Fortnightly';
    case 'monthly'
        header_pt = 'Monthly';
    otherwise
        header_pt = 'Daily';
end

if strcmp( setup.SubplotSpace, 'tight' )
%    header = strcat( 'Volcano-Seismic Activity: ', header_pt, ' Event Counts' );
    header = [ 'Volcano-Seismic Activity: ' header_pt ' Event Counts' ];
    sgtitle( header );
end

