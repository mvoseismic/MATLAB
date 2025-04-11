function rsamc = rsam_combine( rsam1, rsam2 )
%
% Combines rsam ts collections
%
% They MUST have the same time data
%
% Rod Stewart, 2011-12-06

stations = gettimeseriesnames( rsam2 );
nsta = length( stations );

rsamc = rsam1;


for ii = 1:nsta

    station = char( stations(ii) );
    
    ts = get( rsam2, station );
    
    rsamc = addts( rsamc, ts );
end

return