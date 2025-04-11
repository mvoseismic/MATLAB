function rsams = rsam_subset( rsam )
%
% Returns subset of RSAM ts collection
%
% Rod Stewart, 2011-12-06

global DP_SCNL
global DP_VERBOSE

rsams = rsam;

stas = gettimeseriesnames( rsam );
nsta = length( stas );

for ista = 1:nsta

    sta = char( stas(ista) );
    
    keep = false;
    
    for ista_sub = 1:length( DP_SCNL )
        
        scnl = regexp( char( DP_SCNL(ista_sub) ), '\.', 'split' );
        sta_sub = char( scnl(1) );
        
        if strcmp( sta, sta_sub )
            
            keep = true;

        end
        
    end
    
    if ~keep
        rsams = removets( rsams, sta );
    end
    
end

return