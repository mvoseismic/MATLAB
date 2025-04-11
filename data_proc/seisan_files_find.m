function ret = seisan_files_find( start, stop, dir_seisan )
%
% Returns a structure with file names of seisan files for a certain
% time period.
% Version 2 works at both SRC and MVO and uses environment variables
%
% Rod Stewart, 2009-12-09

global DP_VERBOSE 

global DP_NETWORK_SEISAN

network = DP_NETWORK_SEISAN;

if DP_VERBOSE
    m_message = [ 'network: ' network ];
    m_progress( mfilename, 'V', m_message );
end

ret = [];

sjump = 1.0/24.0;

start_date_vec = datevec( start );
stop_date_vec = datevec( stop );

if stop-start < sjump && start_date_vec(3) ~= stop_date_vec(3)
    sjump = stop-start;
end

for idate = start:sjump:stop
    look_date = datestr( idate, 'yyyy-mm-dd-HH' );
    look_string = sprintf( '%s*%s*', look_date, network );
    look_string = fullfile( dir_seisan, look_string );
%    if DP_VERBOSE
%        m_message = [ 'look_string: ' look_string ];
%        m_progress( mfilename, 'V', m_message );
%    end
    ret1 = dir( look_string );
    ret = [ret; ret1];
end

if DP_VERBOSE
    nfiles = length( ret );
    m_message = [ num2str( nfiles ) ' seisan files found' ];
    m_progress( mfilename, 'D', m_message );
end

return;