function sdataf = filter_nan(Hd,sdata,minwin)
%
% Applies the MATLAB filter for data with NaNs in it
%
% Rod Stewart, 2009-06-14

npts = length( sdata );

idnan = isnan( sdata );
idnan = [idnan; 1];

nnan = sum( idnan );

if nnan <= 1
    sdataf = filter(Hd,sdata);
else
    sdataf = sdata;
    id1 = 0;
    for ii = 1:npts+1
        if idnan(ii)
            id2 = ii;
            p1 = id1+1;
            p2 = id2-1;
            nptsw = id2-id1-1;
            if nptsw > minwin
                sdftemp = sdataf(p1:p2);
                sdfmean = mean( sdftemp );
                sdftemp = sdftemp - sdfmean;
                sdftemp = filter(Hd,sdftemp);
                sdataf(p1:p2) = sdftemp+sdfmean;
            else
                sdataf(p1:p2) = nan(1,nptsw);
            end
            id1 = id2;
        end
    end
end

return