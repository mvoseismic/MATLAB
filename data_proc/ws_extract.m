function wout = ws_extract( win, start, stop )
%
% Extracts a time slice from a waveform structure
%
% Rod Stewart, 2010-08-10

wout = extract( win, 'TIME', start, stop );

return