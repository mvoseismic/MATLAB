function justnow = datestr_utc
%
% Returns curent date and time in UTC as a datestring
%
% Rod Stewart, 2009-12-09

cmd = 'date -u +"%Y-%m-%d %H:%M:%S"';

[status, ret] = unix( cmd );

lenret = length( ret );

justnow = ret(1:lenret-1);
