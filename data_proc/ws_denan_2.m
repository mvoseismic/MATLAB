function wout = ws_denan_2( win )
%
% Takes a waveform structure and replaces any nans in data with the mean of
% surrounding points
%
% Rod Stewart, 2012-06-20
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    data = get(win(ii),'data');
    ndata = length( data );
    idnans = find(isnan(data));
    
    for jj = 1:length(idnans)
        inan = idnans(jj);
        if inan == 1
            data(inan) = data(2);
        elseif inan == ndata
            data(inan) = data(ndata-1);
        else
            data(inan) = nanmean( [data(inan-1), data(inan+1)] );
        end
    end
    wout(ii) = set( wout(ii), 'data', data );
end

return
