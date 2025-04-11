function trigs = sigTriggers( signalStruct, secSTA, secLTA, secWait, ratTrig )
%
% Calculates triggers using STA/LTA algorithm on a signal structure
% Returns a MATLAB vector of trigger times
%
% NB = only works for one channel at the mo
%
% R.C. Stewart, 16-Mar-2020

if nargin == 1
    secSTA = 1.0;
    secLTA = 8.0;
    secWait = 5.0;
    ratTrig = 2.5;
end

secInDay = 60 * 60 * 24;

sfreq = signalStruct.sampleRate;

nsampSTA = sfreq * secSTA;
nsampLTA = sfreq * secLTA;
nsampWait = sfreq * secWait;

nsig = length( signalStruct );

for isig = 1:nsig
    
    nsamp = signalStruct(isig).sampleCount;
    datim = signalStruct(isig).matlabTimeVector;
    seism = signalStruct(isig).data;
    
    trigs = [];
    ntrig = 0;
    
    for isamp = nsampLTA:nsamp
        
        sta = mean( abs( seism(isamp-nsampSTA+1:isamp) ) );
        lta = mean( abs( seism(isamp-nsampLTA+1:isamp) ) );
        
        if( (sta/lta) > ratTrig )
            
            trig_datim = datim( isamp );
            
            if ntrig == 0 | ( secInDay * ( trig_datim - trigs(ntrig) ) ) > secWait
                
                ntrig = ntrig + 1;
                trigs( ntrig ) = trig_datim;
                
            end
            
        end
        
    end
    
end

    
    
