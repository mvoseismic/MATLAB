function savefile = ws_fetch( datim_event, sec_pre, sec_post, scnls )
%
% Returns data for a network for a time period
%
% Rod Stewart, 2009-10-30

global DIR_SEISAN_CONT
global NETWORK

%data_dir = '/Users/stewart/Data-local/MVO/seismic/seisan-cont';
%network = 'MVO';

%s = ws_scnl_MVO;

stime_event = datenum( datim_event );
stime_start = stime_event - sec_pre/(60.0*60.0*24.0);
stime_stop = stime_event + sec_post/(60.0*60.0*24.0);

data_files = seisan_files_find( stime_start, stime_stop, DIR_SEISAN_CONT, NETWORK );

w = ws_read_seisan( DIR_SEISAN_CONT, data_files, scnls );

wc = extract( w, 'TIME', datestr(stime_start), datestr(stime_stop) );

w = ws_deflatline( wc );

savefile = datestr( datenum(datim_event), 'yyyymmdd_HHMMSS' );
savefile = sprintf( '%s_%s_%d', 'ws', savefile, sec_pre+sec_post );

save( savefile, 'w', 'datim_event', 'stime_event', 'stime_start', 'stime_stop' );

return