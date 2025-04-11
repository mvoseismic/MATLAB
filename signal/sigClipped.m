function isIt = sigClipped( data )
%
% Tests if waveform data is clipped or not
%
% R.C.Stewart, 15 June 2020

dataMax = max( data );
dataMin = min( data );
nMax = sum( data == dataMax );
nMin = sum( data == dataMin );
    
nClip = nMax + nMin;

if nClip > 3
    isIt = true;
else
    isIt = false;
    
end