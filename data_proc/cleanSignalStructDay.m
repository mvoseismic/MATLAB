function signalStructOut = cleanSignalStructDay( signalStructIn )
%
% Attempts to clean a signalStruct that should have 24 hours worth of data
%
% R.C. Stewart 23-Jul-2020

signalStructOut = signalStructIn;

data = signalStructIn.data;
ndata = length( data );
datim = signalStructIn.matlabTimeVector;
fs = signalStructIn.sampleRate;

ndataExpected = 24*60*60*fs;

if ndataExpected == ndata
    fprintf( 1, 'cleanSignalStructDay - no problems\n' );
    
elseif ndataExpected > ndata
    fprintf( 1, 'cleanSignalStructDay, %d pts missing\n', ndataExpected-ndata );
    datim2 = (0:1/(24*60*60*fs):1);
    datim2 = datim2(1:end-1);
    datim2 = datim2 + floor(datim(1));
    data2 = NaN( size (datim2 ) );
    for idata = 1:length(data2)
        idx = datim == datim2(idata);
        if idx > 0
            data2(idata) = data(idata);
        end
    end
            
else
    fprintf( 1, 'cleanSignalStructDay, %d pts too many\n', ndata-ndataExpected );
    
end


    