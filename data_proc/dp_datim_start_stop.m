function [datim_start_num, datim_stop_num] = dp_datim_start_stop( datim_start, datim_stop )
%
% dp_datim_start_stop
%
% Returns a time span based on a number of things
%
% Single argument string
% 'yesterday','' returns the times marking the previous day
% 'today','' returns the times marking today
% 'now','nn' returns the times marking the nn hours up to the end of this hour
% 'past','nn' returns the times marking the nn days up to the end of
% the current day
%
% Rod Stewart, 2009-12-09

global DP_VERBOSE

if strcmp( datim_stop, '' )
    datim_stop = '24h';
end

if strcmp( datim_start, 'now' )
    DV = datevec( datestr_utc );
    DV(5) = 0.0;
    DV(6) = 0.0;
    span_days = dp_get_duration( datim_stop );
    datim_stop_num = datenum( DV ) + 1.0/24.0;
    datim_start_num = datim_stop_num - span_days;
elseif strcmp( datim_start, 'yesterday' )
    DV = datevec( datestr_utc );
    DV(4) = 0.0;
    DV(5) = 0.0;
    DV(6) = 0.0;
    datim_start_num = datenum( DV ) - 1.0;
    datim_stop_num = datim_start_num + 1.0;
elseif strcmp( datim_start, 'today' )
    DV = datevec( datestr_utc );
    DV(4) = 0.0;
    DV(5) = 0.0;
    DV(6) = 0.0;
    datim_start_num = datenum( DV );
    datim_stop_num = datim_start_num + 1.0;
elseif strcmp( datim_start, 'past' )
    DV = datevec( datestr_utc );
    DV(4) = 0.0;
    DV(5) = 0.0;
    DV(6) = 0.0;
    datim_stop_num = datenum(DV) + 1.0;
    span_days = dp_get_duration( datim_stop );
    datim_start_num = datim_stop_num - span_days;
elseif strcmp( datim_stop, 'now' )
    DV = datevec( datestr_utc );
    DV(5) = 0.0;
    DV(6) = 0.0;
    datim_stop_num = datenum( DV ) + 1.0/24.0;
    datim_start_num = datenum( datim_start );
else
    datim_start_num = datenum( datim_start );
    datim_stop_num = datenum( datim_stop );
end

if DP_VERBOSE
    progress = [ 'timespan start: ' datestr( datim_start_num ) ];
    m_progress( mfilename, 'I', progress );

    progress = [ 'timespan stop: ' datestr( datim_stop_num ) ];
    m_progress( mfilename, 'I', progress );
end

return;
