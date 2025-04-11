function wbig = ws_read_seisan( source_dir, data_files, scnls )
%
% Takes list of seisan files and reads them into one 
% waveform structure.
%
% Rod Stewart, 2009-06-13
% Modified 2017-11-23 because it didn't work.
%

global DP_VERBOSE

nfiles = length( data_files );

wbig = [];

starttime = datenum( '01-Jan-1900' );
stoptime = datenum( '01-Jan-2900' );

nsta = length( scnls );
if DP_VERBOSE
    m_message = [ num2str( nsta ) ' stations' ];
    m_progress( mfilename, 'D', m_message );
end

scnls2 = [];

% For reasons unknown, this method doesn't seem to like the network and
% location code to be set.
% Also, because some rescued files have weird channel codes, we have to do
% a bit extra

if nsta == 0
    scnls2 = scnlobject( '*', '*' );
else
    for iii = 1:nsta
        % RS 2017-11-23, 2022-10-27
        station = get(scnls(iii),'station');
        channel = get(scnls(iii),'channel');
        %sscnl = char(scnls(iii));
        %parts = split( sscnl, '.' );
        %station = char( parts(1) );
        %channel = char( parts(2) );
        if DP_VERBOSE
            m_message = [ 'station: ', station ];
            m_progress( mfilename, 'V', m_message );
            m_message = [ 'channel: ', channel ];
            m_progress( mfilename, 'V', m_message );
        end
        scnl = scnlobject( station, channel );
        scnls2 = [scnls2 scnl];
        if channel ~= '*'
            channel = sprintf( '%2s %1s', channel(1:2), channel(3) );
            scnl = scnlobject( station, channel );
            scnls2 = [scnls2 scnl];
        end
%        progress = dp_scnl_to_string( scnls2 );
%        m_progress( mfilename, 'D', progress );
    end
end

for ii = 1:nfiles
                
    fname = string( data_files(ii).name );
    if contains( fname, '.msd' )
        fileType = 'miniseeed';
    else
        fileType = 'seisan';
    end
  
    fname = fullfile( source_dir, fname );
    
    m_progress( mfilename, 'D', fname );

            
    ds = datasource( fileType, fname );

    w = waveform( ds, scnls2, starttime, stoptime );        
    %w = waveform( fname, fileType );  
    w2 = ws_subset_scnl( w, scnls2 );
    wbig = combine( [wbig w2] );
            
end

return
