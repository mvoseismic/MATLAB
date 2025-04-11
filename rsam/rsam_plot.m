function rsam_plot( rsam, plot_flags )
%
% Plots an rsam ts collection passed to it
%
% Rod Stewart, 2011-12-06

stations = gettimeseriesnames( rsam );
nsta = length( stations );

if nargin == 1
    plot_flags(1:nsta) = 'X';
end

n_flags = length( plot_flags );

if n_flags == 1
    all_flags = char( plot_flags(1) );
    plot_flags(1:nsta) = all_flags;
elseif n_flags ~= nsta
    m_progress( mfilename, 'E', 'probably plot_flags is incorrect' );
end

posn_subplot = subplot_pos_tight( nsta );

for ii = 1:nsta

    posn = posn_subplot(ii,:);
    subplot('position',posn);
    

    station = char( stations(ii) );
    
    ts = get( rsam, station );
    data = get( ts, 'data' );
    
    flag = char( plot_flags(ii) );
    
    ylimits = [];
    plot_symbol_line = 'b-';
    
    % sub-plot options for different types of data
    switch flag
        
        case 'n'            % normalise the plot
            data_mean = nanmean( data );
            data = data / data_mean;
            ylimits = [0 5];
                      
        case 'l'            % logarithmic
            data = log( data );
            data_max = nanmax( data );
            data_min = nanmin( data );
            data_lim = max( abs(data_min), abs(data_max) );
            ylimits = [ -1.0*data_lim data_lim ];
            
        case 'a'            % plotting angles
            data = data * 360.0 / (2.0 * pi);
            ylimits = [0 90];
            
        case 'c'            % event count
            data( data == 0 ) = NaN;
            plot_symbol_line = 'b-';
            
        case 'C'            % event count, but with symbols, not stems
            data( data == 0 ) = NaN;
            plot_symbol_line = 'b*';
            
        otherwise
                     
    end
    
    datim = ts.Time;
    ndata = length(data);
        
    if strcmp( flag, 'c' )
        stem( datim, data, plot_symbol_line );
    else
        plot( datim, data, plot_symbol_line );
    end
    
    % Temp for maximums
    %rsammax = max( data );
    %rsammaxdatim = datestr( datim( data == rsammax ), 0 );
    %fprintf( 1, '%s   %s\n', station, rsammaxdatim );
    
    if ii == 1
        set(gca,'XAxisLocation', 'top' );
    elseif ii == nsta
        set(gca,'XAxisLocation', 'bottom' );
    else
        set(gca,'XTickLabel', [] );
    end
    
    xlim( [datim(1) datim(ndata)] );
    datetick( 'x', 'keeplimits' );
    grid on;
    ylabel( string_tidy( station ) );
    
    if ~isempty( ylimits )
        ylim( ylimits );
    end
    

end

return