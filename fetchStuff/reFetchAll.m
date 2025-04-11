function reFetchAll( setup )
%
% Asks if you want to re-fetch all data
%
% R.C. Stewart, 6-Jan-2019

if  nargin == 0
    setup = setupGlobals();
end

if strcmp( [setup.Mode], 'interactive' )

    fprintf( "WARNING: Only re-fetch data when source files are updated - it can take a long time\n" );
    getAll = inputd( 'Do you want to re-fetch source data? Y/N', 's', 'N' );

    if strcmpi( getAll, 'y' )
        reFetch( setup );
        fetchGps( setup );
        fetchGas( setup );
        fetchFum( setup );
    end

end
