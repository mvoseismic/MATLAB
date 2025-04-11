function mem = sysMemory
%
% Returns system memory in Linux
%
% R.C. Stewart 2024-01-19
%

datimNow = datestr( now, 31 );
[status,memory] = unix( 'free -m -L' );
mem = append( datimNow, ':   ', strtrim( memory ) );

end