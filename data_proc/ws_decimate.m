function w_out = ws_decimate( w, ndec )
%
% Decimates a waveform object by a factor of ndec
%
% Rod Stewart, 2009-08-14

w_station = get( w, 'station' );
w_channel = get( w, 'channel' );
w_samplerate = get( w, 'freq' );
w_starttime = get( w, 'start' );

w_samplerate = w_samplerate / ndec;

w_out = w;

%w_out = set( w_out, 'station', char(w_station) );
%w_out = set( w_out, 'channel', char(w_channel) );
w_out = set( w_out, 'freq', w_samplerate );
%w_out = set( w_out, 'start', w_starttime );

nrec = length( w );

for irec = 1:nrec
    w_data = get( w(irec), 'data' );
    w_data = decimate( w_data, ndec );
    w_out(irec) = set( w_out(irec), 'data', w_data );
end

return

