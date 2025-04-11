function dp_scnls( scnl_string )
%
% Sets the DP_SCNL cell string array for a bunch of stations
% These are either passed as a comma-seperated string or
% prompted for
%
% Rod Stewart, 2010-01-24

global DP_SCNL                      % SCNLs of data used (cell string)
global DP_VERBOSE 


% test if location string passed as argument, if not, ask for it
if (nargin == 0)
    
    scnl_string = input( 'SCNL string (comma seperated): ', 's' );
    
end

scnls = regexp(scnl_string, ',', 'split');

DP_SCNL = scnls;

return