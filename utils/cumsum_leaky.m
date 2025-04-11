function Vout = cumsum_leaky( Vin )
%
% Just like cumsum, but restarts at zero when a zero is encountered
%
% Only works for vectors
%
% Rod Stewart, SRC, 2010-12-11

Vout = zeros( size( Vin ) );

n = length( Vin );

vcum = 0.0;

for ii = 1:n
    
    if Vin(ii) > 0.0
        vcum = vcum + Vin(ii);
    else
        vcum = 0.0;
    end

    Vout(ii) = vcum;
    
end

return
