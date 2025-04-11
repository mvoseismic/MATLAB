%
% Askes a couple of questions and returns seisan data
%
% Rod Stewart, 2010-04-26

dp_globals;
datim_event = input('Time: ', 's');
sec_pre = input('Seconds pre: ');
sec_post = input('Seconds post: ');
sta_group = input('Station group: ', 's' );

dp_stations( sta_group );

file_data = ws_fetch_seisan( datim_event, sec_pre, sec_post, '' );

fprintf( 1, 'Data saved in %s\n', file_data );