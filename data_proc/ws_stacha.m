function ws_stacha( w )
%
% just prints out stations and channels for a ws wavform file
%
% Rod Stewart, 2010-04-26

nch = length( w );

fprintf( 'Channels: %d\n', nch );

for ii = 1:nch
    sta = get(w(ii),'station');
    cha = get(w(ii),'channel');
    
    fprintf(1, '%3d %6s %4s\n', ii, sta, cha);
end