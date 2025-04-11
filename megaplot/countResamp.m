function CountOut = countResamp( setup, CountIn )
%
% Resamples (very roughly) a Count structure
%
% R.C. Stewart, 27-Feb-2020

CountOut = CountIn;

data = [CountIn.data];
datim = [CountIn.datim];
ndata = length( data );

ndays = 1;
switch [setup.CountBinResamp]
    case 'weekly'
        ndays = 7;
    case 'fortnightly'
        ndays = 14;
    case 'monthly'
        ndays = 30;
    case '3monthly'
        ndays = 92;
end
  
if ndays ~= 1
    
    data2= [];
    datim2 = [];
            
    for ix = 1:ndays:ndata
        ixend = ix + ndays + 1;
        if ixend > ndata
            ixend = ndata;
        end
        sum_ndays = sum( data(ix:ixend), 'omitnan' );
        data2 = [ data2 sum_ndays ];
        datim2 = [ datim2 mean( datim(ix:ixend) ) ];
    end
            
    [CountOut.data] = data2;
    [CountOut.datim] = datim2;
    [CountOut.binFreq] = setup.CountBinResamp;
    [CountOut.binWidth] = ndays;
    
end
        