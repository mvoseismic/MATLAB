function datim_start_num = dp_datim_24hrs( when )
%
% dp_datim_24hrs
%
% Returns a 24 hour time span as a date number for the start
%
% Single argument string
% 'yesterday' returns the times marking the previous day
% 'today' returns the times marking today
% 'now' returns the times marking the 24 hours up to the end of 
% the current hour
%
% Rod Stewart, 2009-12-09

global DP_VERBOSE

if strcmp( when, 'now' )
    DV = datevec( datestr_utc );
    DV(5) = 0;
    DV(6) = 0;
    datim_start_num = datenum( DV );
    datim_start_num = datenum( DV ) - 1.0;
elseif strcmp( when, 'yesterday' )
    DV = datevec( datestr_utc );
    DV(4) = 0;
    DV(5) = 0;
    DV(6) = 0;
    datim_start_num = datenum( DV ) - 1.0;
elseif strcmp( when, 'today' )
    DV = datevec( datestr_utc );
    DV(4) = 0;
    DV(5) = 0;
    DV(6) = 0;
    datim_start_num = datenum( DV );
else
    datim_start_num = datestr( when );
end

if DP_VERBOSE
    progress = [ 'timespan start: ' datestr( datim_start_num ) ];
    m_progress( mfilename, 'I', progress );
end

return;
