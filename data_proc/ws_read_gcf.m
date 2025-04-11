function wbig = ws_read_gcf( datim_start_num, datim_stop_num, scnls )
%
% Reads data from gcf files and puts them into a waveform
% structure
%
% Rod Stewart, 2010-01-24
%

wbig = [];

nsta = length( scnls );
progress = [ num2str( nsta ) ' stations' ];
m_progress( mfilename, 'D', progress );

for ii = 1:nsta
    
    scnl = scnls(ii);
    
    dir_gcf = gcf_dir_find( scnl );
    data_files = gcf_files_find( datim_start_num, datim_stop_num, dir_gcf );
    
    nfiles = length( data_files );
    
    data_station = [];
    
    for jj = 1:nfiles           
        fname = data_files(ii).name;
        fname = fullfile( dir_gcf, fname );
        m_progress( mfilename, 'D', fname );

        [data,streamID,sps,ist] = readgcffile(fname);
        
        progress = [ 'npts in file: ' num2str( length(data) ) ];
        m_progress( mfilename, 'D', progress );

        data_station = [data_station; data];
        
        station = get( scnl, 'station' );
        channel = get( scnl, 'channel' );
        freq = 1.0 / sps;
        
    end
    
    progress = [ 'npts for station: ' num2str( length(data_station) ) ];
    m_progress( mfilename, 'D', progress );

    w = waveform(station, channel, freq, datim_start_num, data_station);
    wbig = combine( [wbig w] );
            
end

return
