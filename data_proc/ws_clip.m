function wout = ws_clip( win, clips )
%
% Takes a waveform structure and artificially clips
% each channel at +1 scales
% Rod Stewart, 2009-06-13
%

wout = win;

nsta = length( win );
nsca = length( clips );

if nsca == 1
    clips = clips * ones( nsta, 1 );
elseif nsta ~= nsca
    script_status( 'ws_scale', 'Arrays', 'unmatched' );
    script_status( 'ws_scale', 'nsta', num2str(nsta) );
    script_status( 'ws_scale', 'nsca', num2str(nsca) );
    return
end

for ii = 1:nsta
    data = get(win(ii),'data');

    iclip = data > clips(ii);
    data(iclip) = clips(ii);
    
    iclip = data < -1.0*clips(ii);
    data(iclip) = -1.0*clips(ii);
    
    wout(ii) = set( wout(ii), 'data', data );
end

return
