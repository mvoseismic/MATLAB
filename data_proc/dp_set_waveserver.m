function [server, port] = dp_set_waveserver( source )
%
% dp_set_waveserver
%
% Determines ip address and port of desired, or local
% waveserver, based on some rules
%
% Rod Stewart, 2009-12-07

if strcmp( source, 'waveserver' )
    source = getenv( 'DP_WAVESERVER' );
end
    
colons = findstr( source, ':' );

if length( colons ) == 2
    
    colons = findstr( source, ':' );
    [server, port] = server_port( source(colons(1)+1:length(source)) );
    
elseif length( colons ) == 1
    
    [server, port] = server_port( source );
    
else
    
    server = 'unknown';
    port = 0;
    m_progress( mfilename, 'E', 'cannot establish waveserver' );

end
    
progress = sprintf( 'waveserver: %s %d', server, port );
m_progress( mfilename, 'I', progress );
    
return;
