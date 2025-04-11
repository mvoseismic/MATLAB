function signalStruct = readReadMSEEDFast( fileData )
%
% If ReadMSEEDFast returns a multi-chunk signalStruct, attempts to get it
% into one signalStruct
%
% R.C. Stewart 6 June 2020

signalStruct1 = ReadMSEEDFast( fileData );

nchunk = length( signalStruct1 );

if  nchunk == 1
    
    signalStruct = signalStruct1;
    %fprintf( 'One chunk\n' );
    
else
    
    %fprintf( '%d chunks\n', nchunk );
    
    stationRef = signalStruct1(1).station;
    sampleRateRef = signalStruct1(1).sampleRate;
    
    datimBeg = signalStruct1(1).matlabTimeVector(1);
    datimEnd = signalStruct1(nchunk).matlabTimeVector(end);
    
    %disp( datestr( datimBeg ) );
    %disp( datestr( datimEnd ) );
    nsamp = int32( (datimEnd - datimBeg) * 24 * 60 * 60 * sampleRateRef );
    fprintf( '%d samples needed\n', nsamp );
    
    data = NaN( nsamp, 1 );
    datim = linspace( datimBeg, datimEnd, nsamp );
    datim = datim';
    
    for istruct = 1:nchunk
        
        station = signalStruct1(istruct).station;
        sampleRate = signalStruct1(istruct).sampleRate;
        
        if ~strcmp( station, stationRef )
            disp( 'PANIC stations dont match' );
            break;
        end
            
        if sampleRate ~= sampleRateRef
            disp( 'PANIC sample rates dont match' );
            break;
        end
        
        tdata = signalStruct1(istruct).data;
        tdatim = signalStruct1(istruct).matlabTimeVector;
        tdatim1 = tdatim(1);
        [val,idx]=min(abs(datim-tdatim1));
        if length(idx) ~= 1
            disp( 'PANIC indexing failure' );
            break;
        end
        ndata = length(tdata);
        idx1 = idx;
        idx2 = idx1 + ndata - 1;
        data(idx1:idx2) = tdata;
        
    end
        
    signalStruct = signalStruct1(1);
    signalStruct.sampleCount = nsamp;
    signalStruct.numberOfSamples = nsamp;
    signalStruct.data = data;
    signalStruct.matlabTimeVector = datim;
    
end