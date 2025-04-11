function script_status( prog, message, info )
%
% just prints to the screen a message
%
% Rod Stewart, 2009-05-31

fprintf( 1, '%8s %-20s %s %s\n', datestr( rem(now,1) ), prog, message, info );

return