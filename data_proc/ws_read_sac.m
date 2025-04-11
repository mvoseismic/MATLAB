function wbig = ws_read_sac( source_dir, data_files, scnls )
%
% Takes list of SAC files and reads them into one 
% waveform structure.
%
% Rod Stewart, 2010-04-05
%

nfiles = length( data_files );

wbig = [];

starttime = datenum( '01-Jan-1900' );
stoptime = datenum( '01-Jan-2900' );

nsta = length( scnls );
progress = [ num2str( nsta ) ' stations' ];
m_progress( mfilename, 'D', progress );

scnls2 = [];

% For reasons unknown, this method doesn't seem to like the network and
% location code to be set.

for iii = 1:nsta
    scnl = scnlobject( get(scnls(iii),'station'), get(scnls(iii),'channel') );
    scnls2 = [scnls2 scnl];
    progress = dp_scnl_to_string( scnl );
    m_progress( mfilename, 'D', progress );
end

for ii = 1:nfiles
                
    fname = data_files(ii).name;
    fname = fullfile( source_dir, fname );
    
    m_progress( mfilename, 'D', fname );
            
    ds = datasource( 'sac', fname );

    w = waveform( ds, scnls2, starttime, stoptime );        
    wbig = combine( [wbig w] );
            
end

return
