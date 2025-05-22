function fetchGps( setup )
%
% Asks if you want to re-fetch data from GPS files
%
% R.C. Stewart, 2024-10-25

if  nargin == 0
    setup = setupGlobals();
end

if strcmp( [setup.Mode], 'interactive' )
    getGps = inputd( 'Do you want to re-fetch GPS data? Y/N', 's', 'N' );
else
    getGps = 'Y';
end

if strcmpi( getGps, 'Y' )

    tic;
    disp( 'reFetchGps: please wait' );

    fprintf( 1, "==== copying GPS text files\n" );
    cd '/home/seisan/src/megaplot/data/gps/gps-auto-final';
    dirGpsFinal = '/mnt/volcano01/Deformation/GPS_auto/data/final';
    copyfile( [dirGpsFinal '/*.txt'], '.' );

    cd '/home/seisan/src/megaplot';
    fprintf( 1, "==== fetch_gps_auto_final_all\n" );
    fetch_gps_auto_final_all;

    elapsedTime = toc;
    fprintf( 1, 'done, elapsed time: %6.1f seconds\n', elapsedTime );

end