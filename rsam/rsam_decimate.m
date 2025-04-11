function rsamd = rsam_decimate( rsam, idec )
%
% Decimates RSAM data
%
% Rod Stewart, 2011-12-05

% Create time-series collection for rsamd data

stations = gettimeseriesnames( rsam );
station = char( stations(1) );
ts = get( rsam, station );
datim = get( ts, 'Time' );
n_datim = length( datim );
tsamp = (datim(end) - datim(1)) / (n_datim-1);
msamp = tsamp * 24 * 60;

datim2 = [];
days_shift = msamp * (0.5*idec-0.5) / 60.0 / 24.0;

for jj = 1:idec:n_datim
    datim_shift = datim(jj) + days_shift;
    datim2 = [datim2; datim_shift];
end

rsamd = tscollection( datim2 );
rsamd.TimeInfo.Units = 'days';
    
nsta = length( stations );

% Decimate each
for ii = 1:nsta
    
    station = char( stations(ii) );
    ts = get( rsam, station );
    data = ts.Data;

    
%    data = cumsum( data );
    ndata = length( data );
    data2 = [];
    for jj = 1:idec:ndata
        p1 = jj;
        p2 = jj+idec-1;
        if p2 > ndata
            p2 = ndata;
        end
        datachunk = data(p1:p2);
        datapt = nanmean( datachunk );
        data2 = [data2; datapt];
    end
    
%    data = [ data2(1); diff(data2) ];
%    data2 = data;

    ts2 = timeseries( data2, datim2, 'name', station );
    ts2.TimeInfo.Units = 'days';
    rsamd = addts( rsamd, ts2 );
        
end

return