function setup = setInteractive( setup )

% Dates for plot

start = inputd( 'Start date (or special)', 's', 'Eruption' );

[datim_beg, datim_end] = dateSpanCommon( start );

if datim_beg == 0
        
    datim_beg = dateCommon( start );
    if datim_beg == 0
        datim_beg = datenum( start );
    end
    
    stop = inputd( 'End date (or special)', 's', 'now' );
    datim_end = dateCommon( stop );
    if datim_end == 0
        datim_end = datenum( stop );
    end
    
    setup.Name = sprintf( '%s to %s', datestr( datim_beg ), ...
        datestr( datim_end ) );
    
else
    
    setup.Name = start;
    
end
    
setup.PlotBeg = datim_beg;
setup.PlotEnd = datim_end; 


% Standards


% Panes

% Pane contents