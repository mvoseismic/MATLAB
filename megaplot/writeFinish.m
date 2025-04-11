function writeFinish( setup )
%
% Writes megaplot2 finish information to screen and file
%
% R.C. Stewart, MVO, 23-Jan-2020

file_log = fullfile( setup.DirLog, setup.FileLog );

elapsed_time = toc( setup.Tstart );

if setup.Log2File
    fid = fopen( file_log, 'a+' );
    writeFinishOne( fid, setup, elapsed_time );  
    fclose( fid );
end


if setup.Log2Screen
    writeFinishOne( 1, setup, elapsed_time );  
end   


end


function writeFinishOne( fid, setup, elapsed_time )


fprintf( fid, '\n' );

fprintf( fid, ' Finished                          %s\n', datestr( now ) );
fprintf( fid, '  Elapsed time:                    %d seconds\n', elapsed_time );


end
