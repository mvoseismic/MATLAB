function picks = ws_pick( win, what )
%
% Attempts to pick things from waveform objects
%
% Rod Stewart, 2011-05-24
%

win = ws_demean( win );
win = ws_denan( win );

nsta = length( win );

switch what
    case 'o_p_e'        % P and end
        picks = nan( nsta, 3 );
end

for ii = 1:nsta
    
    sta = get( win(ii), 'station' );
    data = get( win(ii), 'data' );
    freq = get( win(ii), 'freq' );
    start = get( win(ii), 'start' );
    ndata = length( data );
    
    picked = seismo_pick( data, 'maximise_rms_ratio' );
    pick_o_pts = picked(1);
    pick_p_pts = picked(2);
    pick_e_pts = picked(3);
    
    pick_o = start + (pick_o_pts)/(freq*24.0*60.0*60.0);
    pick_p = start + (pick_p_pts)/(freq*24.0*60.0*60.0);
    pick_e = start + (pick_e_pts)/(freq*24.0*60.0*60.0);
%    fprintf( '%s     start: %s      pick_o: %s      pick_p: %s     pick_e: %s\n', ...
%        sta, ...
%        datestr( start, 'HH:MM:SS.FFF' ), ...
%        datestr( pick_o, 'HH:MM:SS.FFF' ), ...
%        datestr( pick_p, 'HH:MM:SS.FFF' ), ...
%        datestr( pick_e, 'HH:MM:SS.FFF' ) );
    
    picks( ii, 1 ) = pick_o;
    picks( ii, 2 ) = pick_p;
    picks( ii, 3 ) = pick_e;
    
end

return
