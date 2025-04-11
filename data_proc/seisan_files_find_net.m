function ret = seisan_files_find_net( start, stop, dir_seisan, network )
%
% Returns a structure with file names of seisan files for a certain
% time period.
% Version 2 works at both SRC and MVO and uses environment variables
%
% Rod Stewart, 2009-12-09

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
    ret1 = dir( look_string );
    ret = [ret; ret1];
end

% nfiles = length( ret );
% progress = [ num2str( nfiles ) ' seisan files found' ];
% m_progress( mfilename, 'D', progress );

return;