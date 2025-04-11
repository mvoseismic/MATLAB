function reFetch( setup )
%
% Asks if you want to re-fetch data from seisan files
%
% R.C. Stewart, 6-Jan-2019

if  nargin == 0
    setup = setupGlobals();
end

setup.Mode = 'interactive';

if strcmp( [setup.Mode], 'interactive' )
    getSeismic = inputd( 'Do you want to re-fetch seismic data? Y/N', 's', 'N' );
end

if strcmpi( getSeismic, 'Y' )
    
    tic;
    disp( 'reFetch: please wait' );
    
    out_file = 'reFetch.out';
    out_file = fullfile( setup.DirMegaplotData, out_file );
    ouf = fopen( out_file, 'w' );
    
    fprintf( ouf, "reFetch: %s\n", datestr(now) );
    fprintf( ouf, "\n" );
    
    fetchVTstrings( setup, ouf );
    fetchVolcstat( setup, ouf );
    %fetchCollect( setup, ouf );
    fetchSelect( setup, ouf );
    fetchMSS1counts( setup, ouf );
    fetchSoufriereCounts( setup, ouf );
    fetchSoufriereHypos( setup, ouf );
    %fetchRsamDaily( setup, ouf );         DOESN'T WORK!!
        
    elapsedTime = toc;
    fprintf( 1, 'done, elapsed time: %6.1f seconds\n', elapsedTime );
    fprintf( ouf, 'done, elapsed time: %6.1f seconds\n', elapsedTime );
    
    fclose( ouf );

end
