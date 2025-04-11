function MOMENT = mag2moment( MAG )
%
% converts magnitudes to moments

magNoLoc = 1.0;
magNoDet = 0.5;
nev = length(MAG);
MOMENT = NaN( 1, nev );

for iev = 1:nev
        
    if isnan( MAG(iev) ) 
        mag = magNoLoc;
    elseif isempty( MAG(iev) )
        mag = magNoLoc;
    else
        mag = MAG(iev);
    end
        
    mw = 0.6667 * mag + 1.15;
    MOMENT(iev) = 10 ^ (1.5 * (mw + 6.07));
        
end
