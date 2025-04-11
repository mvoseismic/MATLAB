function signalStructOut = sigEnvelope( signalStructIn )
%
% Calculates envelope function for a signal stucture
%
% R.C. Stewart, 16-Mar-2020

nwin = 101;

signalStructOut = signalStructIn;

nsig = length( signalStructIn );

for isig = 1:nsig

    data = [signalStructIn(isig).data];
    data = data - nanmean_rod( data );

    idnan = isnan(data);
    data( idnan ) = 0.0;
    
    hdata = abs( hilbert( data ) );
    hdata = nan_rmedian( hdata, nwin );
    
    hdata( idnan ) = nan;

    [signalStructOut(isig).data] = hdata;
    
end
