function savefile = ws_fetch_seisan( datim_event, sec_pre, sec_post, scnls )
%
% Returns data for a network for a time period
%
% Rod Stewart, 2009-12-09

m_script = 'ws_fetch_seisan';

global DP_SEISAN_CONT
global DP_SCNL
global DP_VERBOSE                   % Flag for messages

stime_event = datenum( datim_event );
stime_start = stime_event - sec_pre/(60.0*60.0*24.0);
stime_stop = stime_event + sec_post/(60.0*60.0*24.0);

% If scnls isn't defined, use DP_SCNL
if not(scnls)
    scnls = DP_SCNL;
end
% Always use DP_SCNL
scnls = DP_SCNL;

data_files = seisan_files_find( stime_start, stime_stop, DP_SEISAN_CONT );

%w = ws_read_seisan( DP_SEISAN_CONT, data_files, scnls );
w = ws_read_seisan_long( DP_SEISAN_CONT, data_files, scnls );

wc = extract( w, 'TIME', datestr(stime_start), datestr(stime_stop) );

w = ws_deflatline( wc );

savefile = datestr( datenum(datim_event), 'yyyymmdd_HHMMSS' );
savefile = sprintf( '%s_%s_%d', 'ws', savefile, int32(sec_pre+sec_post) );

save( savefile, 'w', 'datim_event', 'stime_event', 'stime_start', 'stime_stop', '-v7.3' );

clear w;

return