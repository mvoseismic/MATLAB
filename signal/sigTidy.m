function signalStructOut = sigTidy( signalStructIn )
%
% Tidies data for a signal stucture
%
% R.C. Stewart, 5-Apr-2020

nwin = 21;

signalStructOut = signalStructIn;

nsig = length( signalStructIn );

for isig = 1:nsig

    data = [signalStructIn(isig).data];
    data = data - nanmean_rod( data );

    idnan = isnan(data);
    data( idnan ) = 0.0;
    
    sdata = filloutliers( data, 'linear', 'movmedian', nwin );

    [signalStructOut(isig).data] = sdata;
    
end