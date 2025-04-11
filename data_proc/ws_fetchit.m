scnls = scnlobject( '*','*' );

datim_string = input( 'Date and time of arrival: ', 's' );
min_pre = input( 'Minutes before [5]: ' );
if isempty(min_pre)
    min_pre = 5.0;
end
min_post = input( 'Minutes after [15]: ' );
if isempty(min_post)
    min_post = 15.0;
end

fprintf( 'Date of arrival: %s\n', datim_string );
fprintf( 'Minutes before: %f\n', min_pre );
fprintf( 'Minutes after: %f\n', min_post );
fprintf( 'Press any key to continue\n' );
pause;

datim_ev = datestr( datim_string );
sec_pre = min_pre * 60.0;
sec_post = min_post * 60.0;

source = '/users/stewart/data/_copy/MVO/seismic/seisan_cont';

savefile = ws_fetch_waves( scnls, datim_ev, sec_pre, sec_post, source );

fprintf( 'File saved as %s\n', savefile );