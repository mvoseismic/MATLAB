function [datimMean,depMean,latMean,lonMean] = hypoMean( setup, Hypo, ndays )
%
% Returns new Hypo structue with mean values
%
% R.C. Stewart, 20-Feb-2020

if nargin < 3
    ndays = 30;
end

datim = extractfield( Hypo, 'otime' );
dep = extractfield( Hypo, 'dep' );
lat = extractfield( Hypo, 'lat' );
lon = extractfield( Hypo, 'lon' );

idWant = ~isnan(datim);
datim = datim( idWant );
dep = dep( idWant );
lat = lat( idWant );
lon = lon( idWant );

datimBeg = setup.DataBeg;
datimEnd = setup.DataEnd;

nNotDays = ceil( (datimEnd-datimBeg+1) / ndays );

datimMean = NaN(1,nNotDays);
depMean = NaN(1,nNotDays);
latMean = NaN(1,nNotDays);
lonMean = NaN(1,nNotDays);

iCt = 0;
for iDatim = datimBeg:ndays:datimEnd
    iCt = iCt + 1;
    datimMean(iCt) = iDatim + ndays/2;
    idWant = datim >= iDatim & datim < iDatim+ndays;
    depMean(iCt) = mean( dep(idWant), 'omitnan' );
    latMean(iCt) = mean( lat(idWant), 'omitnan' );
    lonMean(iCt) = mean( lon(idWant), 'omitnan' );

end
