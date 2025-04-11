function m_progress( mscript, mtype, message )

% Used to generate log and error messages from MATLAB scripts
%
% Use the function mfilename as the first argument
%
% Rod Stewart, 2009-12-07
%

    fprintf( 1, '%s  ', datestr_utc );

    switch mtype
        case { 'I', 'Info', 'INFO' }
            fprintf( 1, '%s  ', 'Info   ' );
        case { 'W', 'Warning', 'WARNING' }
            fprintf( 1, '%s  ', 'Warning' );
        case { 'E', 'Error', 'ERROR' }
            fprintf( 1, '%s  ', 'Error  ' );
        case { 'D', 'Debug', 'DEBUG' }
            fprintf( 1, '%s  ', 'Debug  ' );
        case { 'V', 'Variable', 'VARIABLE' }
            fprintf( 1, '%s  ', 'Variable  ' );
        case { 'F', 'Fatal', 'FATAL' }
            fprintf( 1, '%s  ', 'Fatal  ' );
            fprintf( 1, '%s  ', mscript );
            fprintf( 1, '%s\n', message );
            error( 'mProgress:Fatal', message );
    end

    fprintf( 1, '%s  ', mscript );
    
    fprintf( 1, '%s\n', message );


return;