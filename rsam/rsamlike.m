function rsamout = rsamlike( data, fs, window_minutes )
%
% returns an RSAM array (using RMS)
%
% Rod Stewart, 2009-04-14

npts = length( data );
window_pts = int32( window_minutes * 60.0 * fs );

rsamout = [];

for ii = 1:window_pts:npts
    iend = ii+window_pts-1;
    if iend > npts
        iend = npts;
    end
    rmsout = rms( data(ii:iend) );
    rsamout = [rsamout; rmsout];
end