function wout = ws_extract_rel( win, wtimes, start, stop )
%
% Extracts a time slice from a waveform structure
% Times are in secods relative to array of P times
%
% Rod Stewart, 25-May-2020

nch = length( win );


for ii = 1:nch
    
    wtmp = win(ii);
    
    start = wtimes(ii) - start/(60*60*24);
    stop = wtimes(ii) + stop/(60*60*24);
    
    wtmp2 = extract( wtmp, 'TIME', start, stop );
    wout(ii) = wtmp2;
    
end

return