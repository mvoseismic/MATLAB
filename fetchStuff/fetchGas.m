function fetchGas( setup )
%
% Asks if you want to re-fetch data from gas files
%
% R.C. Stewart, 2024-11-12

if  nargin == 0
    setup = setupGlobals();
end

if strcmp( [setup.Mode], 'interactive' )
    getGas = inputd( 'Do you want to re-fetch Gas data? Y/N', 's', 'N' );
else
    getGas = 'Y';
end

if strcmpi( getGas, 'Y' )

    tic;
    disp( 'reFetchGas: please wait' );

    fetch_so2_traverse;

    elapsedTime = toc;
    fprintf( 1, 'done, elapsed time: %6.1f seconds\n', elapsedTime );

end