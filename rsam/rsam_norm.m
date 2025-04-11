function rsamn = rsam_norm( rsam, method )
%
% Normalises RSAM data to median value
%
% Rod Stewart, 2011-12-05

if nargin == 1
    method = 'median';
end

% Create time-series collection for normed data
rsamn = rsam;
datim = rsamn.Time;

stations = gettimeseriesnames( rsam );
nsta = length( stations );

% Normalise each ts to its median
for ii = 1:nsta
    
    station = char( stations(ii) );
    ts = get( rsamn, station );
    data = ts.Data;
    
    rsamn = removets(rsamn,station) ;
    
    switch method
        case 'median'
            data_normer = nanmedian( data );
        case 'mean'
            data_normer = nanmean( data );
        case 'max'
            data_normer = nanmax( ts );
        otherwise
            data_normer = 1.0;

    end
               
    data = data / data_normer;
    
    ts = timeseries( data, datim, 'name', station );
    ts.TimeInfo.Units = 'days';
    
    rsamn = addts( rsamn, ts );
        
end

return