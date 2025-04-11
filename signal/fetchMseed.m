function [ data, datim, fs ] = fetchMseed( cha, datimBeg, datimEnd )
%
% Returns one channel of seismic data from a 24-hour miniSeed file
%
% R.C. Stewart, 17 June 2020
%

%dirData = '/Users/stewart/data/_copy/MVO/mseed';
dirData = '/mnt/mvohvs3/MVOSeisD6/mseed/MV/MBFR';

% Assume datimBeg and datimEnd are on same day
datestrYD = dateToDoy( datestr( datimBeg ) );

C = strcat( cha, '.', datestrYD, '.mseed' );
fileData = strjoin( C, '.' );
fileData = fullfile( dirData, fileData );

disp( fileData );

signalStruct = readReadMSEEDFast( fileData );

data = signalStruct.data;
datim = signalStruct.matlabTimeVector;
fs = signalStruct.sampleRate;

idWant = datim >= datimBeg & datim < datimEnd;

data = data(idWant);
datim = datim(idWant);

