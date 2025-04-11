function signalStructOut = sigTrim( signalStructIn, trimSec1, trimSec2 )
%
% Trimns data from a signal stucture
%
% R.C. Stewart, 26-Nov-2020

signalStructOut = signalStructIn;

nsig = length( signalStructIn );

nOff1 = trimSec1 * signalStructIn.sampleRate;
nOff2 = trimSec2 * signalStructIn.sampleRate;
if nOff2 > signalStructIn.numberOfSamples
    nOff2 = signalStructIn.numberOfSamples;
end

data = signalStructIn.data;
dataTrim = data( nOff1 : nOff2 );

signalStructOut.startTime = signalStructIn.startTime + (trimSec1/signalStructIn.sampleRate)/(24*60*60);
signalStructOut.sampleCount = length( dataTrim );
signalStructOut.numberOfSamples = signalStructOut.sampleCount;
signalStructOut.data = dataTrim;
