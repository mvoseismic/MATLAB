function wout = ws_enveloped( win, nwin )
%
% Takes a waveform structure and changes each signal to an envelope
%
% Rod Stewart, 2011-01-26
%

if nargin == 1
    nwin = 101;
end

wout = win;

nsta = length( win );


for ii = 1:nsta
    
    data = get( win(ii), 'data' );
    
    idnan = isnan(data);
    data( idnan ) = 0.0;
    
    hdata = abs( hilbert( data ) );
    hdata = nan_rmedian( hdata, nwin );
    
    hdata( idnan ) = nan;
    
    wout(ii) = set( wout(ii), 'data', hdata );
    wout(ii) = set( wout(ii), 'Units', 'Envelope' );

end

return
