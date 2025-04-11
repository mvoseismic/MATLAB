function signalStructOut = sigFiltHp( signalStructIn, fc )
%
% THigh-pass filters data from a signal stucture
%
% R.C. Stewart, 26-Nov-2020

signalStructOut = signalStructIn;

data = signalStructIn.data;

npoles = 4;
type = 'high';
nyq = 0.5 * signalStructIn.sampleRate;

[z,p,k] = butter(npoles,fc/nyq,type);
[sos,g] = zp2sos(z,p,k);
Hd = dfilt.df2sos(sos,g);
data2 = filter(Hd,data);
data2 = mean_norm_nan( data2 );

signalStructOut.data = data2;
