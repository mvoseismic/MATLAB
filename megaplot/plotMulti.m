function plotMulti( setup, data_types, plot_types, plot_looks, nmeans, cums )
%
% Plots combination of data types
%
% R.C. Stewart 30-Dec-2019


% Check for double entries to create larger panes
[unique_data_types,~,idx] = unique(data_types,'stable');
count = hist(idx,unique(idx));

ndatas = length( data_types );
npanes = length( unique_data_types );

if strcmp( setup.SubplotSpace, 'tight' )
    [ha, pos] = tight_subplot( npanes, 1, 0, [0.1 0.12], 0.1);
end

for ip = 1:npanes
    
    data_type = data_types{ip};
    plot_type = plot_types{ip};
    plot_look = plot_looks{ip};
    nmean = nmeans(ip);
    cum = cums(ip);
    
    tmp1 = split( data_type, "_" );
    data_source = tmp1{1};
    data_type = tmp1{2};
    
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
             
    switch data_source
        
        case "volcstat"
            plotVolcstat( setup, data_type, plot_type, plot_look, cum );
                
        case { 'collect', 'select', 'mss1' }
            plotCollectSelect( setup, data_source, data_type, plot_type, plot_look, cum );
            
        case "chron"
            plotChronology( setup, data_type, plot_type, plot_look );
                
        case "blank"
            plotBlank( setup );
            
    end
            
                
    end

end