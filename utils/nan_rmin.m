function back = nan_rmedian( Data, nwin )
%
% Does a running minimum value filter on an array of data which has NaNs in it
% nwin has to be odd.
%
% If nmin is set, it is the minimum no of points used to calc a median,
% NaN otherwise
%
% Rod Stewart, SRC 2020-12-31


nwinend = (nwin-1)/2;

nData = length( Data );

DataOut = NaN(nData,1);

Data2 = [ NaN(nwinend,1); Data; NaN(nwinend,1) ];

for ii=1:nData
    DataOut (ii) = min( Data2(ii:ii+nwin-1) );
end

back = DataOut;
