function wout = ws_mean_norm_3c( win )
%
% Takes a waveform structure and removes mean and normalises the data
% This version works for 3C sets
%
% Rod Stewart, 2009-06-13
%

nsta = length( win );

wout = win;

for ii = 1:3:nsta-2
    
    datae = get(win(ii),'data');
    datan = get(win(ii+1),'data');
    dataz = get(win(ii+2),'data');
    rangee = nanmax(datae) - nanmin(datae);
    rangen = nanmax(datan) - nanmin(datan);
    rangez = nanmax(dataz) - nanmin(dataz);
    range = max( [rangee rangen rangez] );

    if ~isempty(range)
        datae = mean_norm_nan( datae ) * rangee/range;
        datan = mean_norm_nan( datan ) * rangen/range;
        dataz = mean_norm_nan( dataz ) * rangez/range;
    
        wout(ii) = set( wout(ii), 'data', datae );
        wout(ii+1) = set( wout(ii+1), 'data', datan );
        wout(ii+2) = set( wout(ii+2), 'data', dataz );
    end
    
end

return
