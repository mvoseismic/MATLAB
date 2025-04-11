function scnl_string = dp_scnl_to_string( scnl )
%
% dp_scnl_to_string
%
% Creates a dotted string describing an scnl object
%
% Rod Stewart, 2009-12-09

sta = get( scnl, 'station' );
cha = get( scnl, 'channel' );
net = get( scnl, 'network' );
loc = get( scnl, 'location' );

scnl_string = [ char(sta) '.' char(cha) '.' char(net) '.' char(loc) ];

return;