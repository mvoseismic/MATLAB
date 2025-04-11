function w_new = ws_chunk( w, datim_beg_num, datim_end_num, n_chunk )
%
% Take a waveform object with only one channel and turn it into a multi
% channel object with time chunks.
%
% Rod Stewart, 2010-03-26

sta = get( w, 'station' );
cha = get( w, 'component' );
freq = get( w, 'freq' );
units = get( w, 'units' );

t_data = datim_end_num - datim_beg_num;
t_chunk = t_data / n_chunk;
s_chunk = int16( t_chunk * freq );

w_new(n_chunk,1) = waveform;

for ii = 1:n_chunk
    
    datim_1 = datim_beg_num + (ii-1) * t_chunk;
    datim_2 = datim_1 + t_chunk;
    
    w_tmp = extract(w,'TIME',datim_1,datim_2);
    data = get( w_tmp, 'data' );
    
    w_new(ii) = set( w_new(ii), 'freq', freq, ...
                    'data_length', s_chunk, ...
                    'start', datim_beg_num, ...
                    'units', units, ...
                    'station', sta, ...
                    'channel', cha );
    w_new(ii) = set( w_new(ii), 'data', data );
    
    
end

                
return