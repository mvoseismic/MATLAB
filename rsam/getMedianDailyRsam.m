function [datimRsamMD, dataRsamMD] = getMedianDailyRsam(datimRsam,dataRsam)
%
% Calculates median daily RSAM from one-minute RSAM data
%
% R.C. Stewart, 2025-04-15

datimRsamMD = [];
dataRsamMD = [];

datimBeg = floor( datimRsam(1) );
datimEnd = floor( datimRsam(end) );

dataRsam( dataRsam < 0 ) = NaN;

iDatim = 0;
for datim = datimBeg:datimEnd
    iDatim = iDatim+1;

    idWant = datimRsam >= datim & datimRsam < datim+1;

    datimRsamMD(iDatim) = datim;
    dataRsamMD(iDatim) = median( dataRsam(idWant), 'omitnan' );

end


