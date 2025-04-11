function dp_globals_print
%
% Prints out all globals for DP software
%
% Rod Stewart, 2017-11-23

fprintf( 1, '%s\n', 'All DP GLOBALS' );

global DP_OS                        % Operating system
fprintf( 1, '  %-20s: %s\n', 'DP_OS', DP_OS );

global DP_WHERE                     % Which place I am
fprintf( 1, '  %-20s: %s\n', 'DP_WHERE', DP_WHERE );

global DP_DATA                      % What data I want
fprintf( 1, '  %-20s: %s\n', 'DP_DATA', DP_DATA );

global DP_DIR_RSAM                  % RSAM data directory
fprintf( 1, '  %-20s: %s\n', 'DP_DIR_RSAM', DP_DIR_RSAM );

global DP_DIR_RSAM_SUMMARY          % RSAM summary directory
fprintf( 1, '  %-20s: %s\n', 'DP_DIR_RSAM_SUMMARY', DP_DIR_RSAM_SUMMARY );

global DP_MODE                      % login or cron
fprintf( 1, '  %-20s: %s\n', 'DP_MODE', DP_MODE );

global DP_DIR_GCF                   % GCF data directory root
fprintf( 1, '  %s: %s\n', 'DP_DIR_GCF', DP_DIR_GCF );

global DP_DIR_BOB                   % BOB data for early MVO days
fprintf( 1, '  %-20s: %s\n', 'DP_DIR_BOB', DP_DIR_BOB );


global DP_SEISAN_CONT               % Continuous seisan data
fprintf( 1, '  %-20s: %s\n', 'DP_SEISAN_CONT', DP_SEISAN_CONT );

global DP_NETWORK                   % Code of network
fprintf( 1, '  %-20s: %s\n', 'DP_NETWORK', DP_NETWORK );

global DP_NETWORK_SEISAN            % Code used by SEISAN for network
fprintf( 1, '  %-20s: %s\n', 'DP_NETWORK_SEISAN', DP_NETWORK_SEISAN );

global DP_SCNL                      % SCNLs of data used (cell array of strings)

global DP_RSAM_NSMOOTH              % # pts in running-median filter        
fprintf( 1, '  %-20s: %s\n', 'DP_RSAM_NSMOOTH', DP_RSAM_NSMOOTH );

global DP_VERBOSE                   % Flag for messages
