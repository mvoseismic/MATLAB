function savefile = ws_fetch_waves( scnls, datim_event, sec_pre, sec_post, source )
%
% Returns data for a network for a time period, for different data sources
% 
% scnls -        scnl object
% datim_event -  time of event, can be a MATLAB time variable, or the two 
%                special values 'now' or 'yesterday'
%                'now' uses the current time, but if sec_post is positive, it 
%                rounds up to the next hour
%                'yesterday' gives data for all 24 hours of yesterday
% sec_pre -      seconds of data before datim_event
% sec_post -     seconds of data after datim_event
% source -       source of data, either the path to a bunch of seisan files
%                or a waveserver address
%                The waveserver should be specified as, for example:
%                "waveserver:192.168.1.250:16022". If it is only "wave",
%                the script tries to work it out for itself.
%                The path is used, unless it is "seisan", when it uses 
%                the local continuous seisan database. or "rbuffers"
%                where it uses the recent rbuffers.
%
% This function requires the path to the swarm library in your javaclasspath
%
%
% Rod Stewart, 2009-12-07

% Java path for swarm

datim_event_num = datenum( datim_event );
datim_start_num = datim_event_num - sec_pre/(60.0*60.0*24.0);
datim_stop_num = datim_event_num + sec_post/(60.0*60.0*24.0);
datim_start_string = datestr( datim_start_num );
datim_stop_string = datestr( datim_stop_num );

if strcmp( source(1:3), 'wav' )
    
    m_progress( mfilename, 'I', 'using waveserver' );
    
    dir_home = getenv( 'HOME' );
    dir_swarm = fullfile( dir_home, 'Software', 'swarm-bin-2.0.0-beta-12b', 'swarm', 'lib', 'swarm.jar' );
    javaaddpath( dir_swarm );

    [server,port] = dp_set_waveserver( source );
    
    ds = datasource( 'winston', server, port );
    
    % This can fail, so use a try-catch structure
    try
    
        ws = waveform( ds, scnls, datim_start_num, datim_stop_num );
    
    catch WS
    
        m_progress( mfilename, 'E', 'call to waveform' );
        rethrow( WS );
    
    end

elseif strcmp( source(1:3), 'gcf' )
    
    m_progress( mfilename, 'I', 'using gcf files' );
        
    ws = ws_read_gcf( datim_start_num, datim_stop_num, scnls );

else
    
    m_progress( mfilename, 'I', 'using seisan files' );
    
    if strcmp( source, 'rbuffers' )
        dir_seisan = getenv( 'DP_DIR_RBUFFERS' );
    elseif strcmp( source, 'seisan' )
        dir_seisan = getenv( 'DP_DIR_SEISAN_CONT' );
    else
        dir_seisan = source;
    end
 
    data_files = seisan_files_find( datim_start_num, datim_stop_num, dir_seisan );
    
%    for iii = 1:length( data_files )
%        progress = char( data_files(iii).name );
%        m_progress( mfilename, 'D', progress );
%    end
    
    % This can fail if there are no files
    if isempty( data_files )
        
        ws = [];

    else
        
        w = ws_read_seisan( dir_seisan, data_files, scnls );
        ws = extract( w, 'TIME', datim_start_string, datim_stop_string );
    
    end
end


w = ws_deflatline( ws );

savefile = datestr( datenum(datim_start_num), 'yyyymmdd_HHMMSS' );
savefile = sprintf( '%s_%s_%d', 'ws', savefile, sec_pre+sec_post );

save( savefile, 'w', 'datim_event_num', 'datim_start_num', 'datim_stop_num' );

return