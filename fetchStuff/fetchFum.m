function fetchFum( setup )
%
% Asks if you want to re-fetch data from fumarole remperature csv file
%
% R.C. Stewart, 2024-11-13

if  nargin == 0
    setup = setupGlobals();
end

if strcmp( [setup.Mode], 'interactive' )
    getFum = inputd( 'Do you want to re-fetch fumarole temperature data? Y/N', 's', 'N' );
else
    getFum = 'Y';
end

if strcmpi( getFum, 'Y' )

    tic;
    disp( 'reFetchFum: please wait' );

    dirFum = fullfile( setup.DirHome, 'projects/megaplot/data/fumarole_temps' );

    cd( dirFum );
    F = readtable( 'Fumarole_Temps_For_Megaplot.csv' );
    fdatim = datenum( F.Date );
    fdata = F.AverageT__C_;

    save( 'fumarole_temps.mat', 'fdatim', 'fdata' );

    cd '/home/seisan/projects/megaplot';

    elapsedTime = toc;
    fprintf( 1, 'done, elapsed time: %6.1f seconds\n', elapsedTime );

end