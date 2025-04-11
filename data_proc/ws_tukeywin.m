function wout = ws_tukeywin( win, frac )
%
% Applies Tukey tapering window to waveform object data
%
% Rod Stewart, SRC, 2009-08-15

wout = win;

for iwave = 1:length(win)

    wdata = get( wout(iwave), 'data' );
    window = tukeywin(length(wdata),frac);
    wdata = wdata .* window;
    wout(iwave) = set( wout(iwave), 'data', wdata );
end

return