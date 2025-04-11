function wbig = ws_read_infrasound_MNT( source_dir, data_files )
%
% Takes list of MNT infrasound files and reads them into one 
% waveform structure.
%
% Rod Stewart, 2011-01-17
%

[data_time, data] = read_infrasound_MNT( source_dir, data_files );

fs = 50;

start_time = data_time(1);
npts = length(data_time);
stop_time = data_time( npts );

[nwav,npts] = size( data );

for ii = 1:nwav
    
    station = sprintf( 'MIC%d', ii );
    channel = 'HDF';
    
    w = waveform( station, channel, fs, start_time, data(ii,:)' ); 

    if ii == 1
        wbig = w;
    else
        wbig = combine( [wbig w] );
    end
    
end

wbig = wbig';
return
