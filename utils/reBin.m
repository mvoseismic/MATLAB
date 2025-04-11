function [datim2, count2] = reBin( datim, count, nsum )
%
% Rebins data given two vectors input of datims and counts
%
% R.C. Stewart, 23-Mar-2020

%{
datim2 = downsample( datim, nsum );

count = [ 0 count ];
count = cumsum( count );
count2 = downsample( count, nsum );
count3 = diff( count2 );
count3 = [ count2(1) count3 ];

count2 = count3;
%}

ndata = length( datim );

datim2 = [];
count2 = [];
idata2 = 0;

for idata = 1:nsum:ndata
    
    idata2 = idata2 + 1;
    
    idataend = idata + nsum - 1;
    if idataend > ndata
        idataend = ndata;
    end
    
    count2t = sum( count(idata:idataend), 'omitnan' );
    count2 = [ count2 count2t ];
    
%    datim2t = mean( datim(idata:idataend) );
    datim2t = datim(idata) + nsum/2.0;
    datim2 = [ datim2 datim2t ];
    
end
    
    
