function wbig = ws_read_seisan_long( source_dir, data_files, scnls )
%
% Takes list of seisan files and reads them into one 
% waveform structure.
% Use this version for very long data
%
% Rod Stewart, 2009-08-14
% Modified 2017-11-23 because it didn't work.
%

global DP_VERBOSE

nfiles = length( data_files );

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
        % RS 2017-11-23
        %station = get(scnls(iii),'station');
        %channel = get(scnls(iii),'channel');
        sscnl = char(scnls(iii));
        parts = split( sscnl, '.' );
        station = char( parts(1) );
        channel = char( parts(2) );
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

wbig = [];
    
for ii = 1:nfiles
                
    fname = data_files(ii).name;
    fname = fullfile( source_dir, fname );
            
    m_progress( mfilename, 'D', fname );

    ds = datasource( 'seisan', fname );

    w = waveform( fname, 'seisan' );  
    w2 = ws_subset_scnl( w, scnls2 );
    w = w2;
%    w = waveform( ds, scnls, starttime, stoptime );        
    
%    save tmp w;
    
    if ii > 1
        load tmp;
        wbig = combine( [wbig w] );
        save tmp wbig -v7.3;
        clear wbig w;
    else
        wbig = w;
        save tmp wbig -v7.3;
        clear wbig w;
    end
            
end

load tmp;

return
