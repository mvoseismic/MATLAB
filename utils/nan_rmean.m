function back = nan_rmean( Data, nwin )
%
% Does a running mean filter on an array of data which has NaNs in it
% nwin has to be odd.
%
% Rod Stewart, SRC 2008-09-11

nwinend = (nwin-1)/2;

nData = length( Data );

DataOut = NaN(1,nData);

Data2 = [ NaN(1,nwinend) Data' NaN(1,nwinend) ];

for ii=1:nData
    DataOut (ii) = nanmean_rod( Data2(ii:ii+nwin-1) );
end

back = DataOut';
