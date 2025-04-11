function wout = ws_mean_norm_1( win )
%
% Takes a waveform structure and removes mean and normalises the data
% This version normalises all to the largest channel
%
% Rod Stewart, 2010-03-26
%

nsta = length( win );

wout = win;

for ii = 1:nsta
    
    data = get(win(ii),'data');
    
    switch ii
        case 1
            data_all = data;
        otherwise
            data_all = [ data_all; data ];
    end
    
end

range_all = nanmax(data_all) - nanmin(data_all);

for ii = 1:nsta
    
    data = get(win(ii),'data');
    range = nanmax(data) - nanmin(data);
    if ~isnan( range )
        data = mean_norm_nan( data ) * range/range_all;
    end
    
    wout(ii) = set( wout(ii), 'data', data );
    
end

return
