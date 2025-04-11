function wout = ws_deflatline( win )
%
% Takes a waveform structure and deflatlines all teh channels in it
% waveform structure.
%
% Rod Stewart, 2009-06-13
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    data = deflatline( data );
    wout(ii) = set( wout(ii), 'data', data );
end

return
