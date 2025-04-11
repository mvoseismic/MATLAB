function wbig = ws_combine( w1, w2 )
%
% Takes two waveform structures and combines them
% Total hack because I don't understad structures
%
% Rod Stewart, 2011-01-17
%

wbig = waveform;

nw1 = length( w1 );
nw2 = length( w2 );

for ii = 1:nw1
    wbig(ii) = w1(ii);
    
end

for ii = nw1+1:nw1+nw2
    wbig(ii) = w2(ii - nw1);
    
end

wbig = wbig';
return
