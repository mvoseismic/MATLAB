function plotCollectSelect( setup, data_source, data_type, plot_type, plot_symcol, cum )
%
% Plots data from collect and select output files
%
% R.C. Stewart 1-Jan-2020
%
% Modified 2023-11-08, but only works for collect!
% 

switch data_source
    
    case 'collect'
        data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoCollect.mat' );
        load( data_file );
        
        X = extractfield(Hypo,"datim");

        switch data_type
            case 'mag'
                Y = extractfield(Hypo,"mag");
                plot_title = 'ML';
                plot_ylabel = 'ML';
            case 'dep'
                Y = extractfield(Hypo,"dep");
                plot_title = 'depth (km)';
                plot_ylabel = 'depth';
            case 'nst'
                Y = extractfield(Hypo,"nstaLoc");
                plot_title = 'nsta';
                plot_ylabel = 'nsta';
            case 'mom'
                Y = extractfield(Hypo,"moment");
                plot_title = 'moment';
                plot_ylabel = 'Mo';
        end

        
    case 'select'
%data_file = fullfile( setup.DirMegaplotData, 'fetchedSelect.mat' );
%load( data_file );


        
        X = select_datims;

        switch data_type
            case 'mag'
                Y = select_mags;
                plot_title = 'ML';
                plot_ylabel = 'ML';
            case 'dep'
                Y = select_depths;
                plot_title = 'depth (km)';
                plot_ylabel = 'depth';
            case 'nst'
                Y = select_nstas;
                plot_title = 'nsta';
                plot_ylabel = 'nsta';

        end
        
    case 'mss1'
        data_file = fullfile( setup.DirMegaplotData, 'fetchedMSS1counts.mat' );
        load( data_file );
        
        X = mss1_datims;
        
        switch data_type
            case 'count1'
                Y = mss1_counts_1;
            case 'count2'
                Y = mss1_counts_2;
        end
        
        plot_title = 'Earthquakes/day on MSS1';
        plot_ylabel = 'MSS1 eqs';

    case 'soufriere'
        data_file = fullfile( setup.DirMegaplotData, 'fetchedSoufriereCounts.mat' );
        load( data_file );
        
        X = soufcounts_datims;
        Y = soufcounts_counts;
        
        plot_title = 'Earthquakes/day counted on SRC system';
        plot_ylabel = 'SRC eqs';

end

% We only want non-Nan values
idy = isfinite( Y );
X = X(idy);
Y = Y(idy);

if cum
    Y = cumsum( Y );
    plot_title = strcat( plot_title, " (cumulative)" );
    plot_ylabel = strcat( "Cumulative ", plot_ylabel );
end

switch data_type
    case {'counts','count1','count2'}
        bins = calcCountBins( setup );
        switch bins
            case 'weekly'
                nb = 7;
                plot_title = strrep( plot_title, 'day', 'week' );
            case 'monthly'
                nb = 31;
                plot_title = strrep( plot_title, 'day', 'month' );
            otherwise
                nb = 1;
        end
        
        if nb > 1
            
            Y2 = [];
            X2 = [];
            
            for ix = 1:nb:length(X)
                ixend = ix + nb + 1;
                if ixend > length(X)
                    ixend = length(X);
                end
                sum_nb = sum( Y(ix:ixend) );
                Y2 = [ Y2 sum_nb ];
                X2 = [ X2 mean( X(ix:ixend) ) ];
            end
            
            X = X2;
            Y = Y2;
        end
                
    otherwise
end
    
switch plot_type
    case 'bar'
        bar( X, Y, 'FaceColor', plot_symcol, 'EdgeColor', plot_symcol, 'BarWidth', 1 );
    case 'symbol'
        plot( X, Y, plot_symcol );
    case 'line'
        plot( X, Y, plot_symcol, 'LineWidth', 2 );
    case 'stem'
        stem( X, Y, plot_symcol );
end
   
xlim( [setup.PlotBeg setup.PlotEnd] );
datetick( 'x', 'keeplimits' );

ax = gca;

ax.XMinorTick = 'on';
ax.TickDir = 'both';
ax.XGrid = 'on';

switch data_type
    case {'dep','hypodep','hypodepgood'}
        axis ij;
        ylim( [0 7] );
end

switch setup.SubplotSpace
    case 'normal'
        title( plot_title );
    case 'tight'
        ylabel( plot_ylabel );
        switch setup.PlotXaxis
            case 'top'
                ax.XAxisLocation = 'top';
            case 'bottom'
                ax.XAxisLocation = 'bottom';
                ylabs = ax.YTickLabel;
                ylabs(length(ylabs)) = '';
                ax.YTickLabel = ylabs;
            case 'none'
                ax.XAxisLocation = 'bottom';
                ax.XTickLabel = {};
                %ylabs = ax.YTickLabel;
                %ylabs(length(ylabs)) = '';
                %ax.YTickLabel = ylabs;
        end
          
end

hold on;
