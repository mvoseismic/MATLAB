function HypoOut = hypoSubsetRanges( HypoIn, Ranges )
%
% Returns a subset of the Hypo structure based on ranges of key items
%
% R.C. Stewart 9-Jan-2020

id_all = ones( 1, length( HypoIn ) );

for var = {'rms','errOtime','errLat','errLon','errDep','gap','nph','mag', ...
        'lat', 'lon', 'dep'}
    
    svar = string( var );
    if isfield( Ranges, svar )
            
        range = [Ranges.(svar)];
        
        if range(1) ~= range(2)
        
            vals = [HypoIn.(svar)];
        
            id_ran = vals >= range(1) & vals <= range(2);
        
            id_all = id_all & id_ran;
            
        end
        
    end
    
end

HypoOut = HypoIn(id_all);
