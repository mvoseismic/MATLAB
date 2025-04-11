function rsams = rsam_smooth( rsam, npts, method )
%
% Smooths RSAM data in timeseries collection using a variety of methods
%
% Rod Stewart, 2011-12-06

global DP_RSAM_NSMOOTH

if nargin < 3
    method = 'median';
end
if nargin < 2
    npts = DP_RSAM_NSMOOTH;
end

nmin = 1;

% Create times-series collection object
datim = rsam.Time;
rsams = tscollection( datim );
rsams.TimeInfo.Units = 'days';

stations = gettimeseriesnames( rsam );

nsta = length( stations );

for ii = 1:nsta
    
    station = char( stations(ii) );
    
    ts = get( rsam, station );
    data = ts.Data;
    
    switch method
        case 'median'
            datas = nan_rmedian( data, npts, nmin );
        case 'mean'
            datas = nan_rmean( data, npts );
    end
        
    % Create time series object
    ts = timeseries( datas, datim, 'name', station );
    ts.TimeInfo.Units = 'days';
    
    % Add to time series collection
    rsams = addts( rsams, ts );

end


