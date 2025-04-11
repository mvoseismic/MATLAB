function w = ws_nanpad( w, datim_start_num, datim_stop_num )
%
% Checks if ws starts at required start time.
%
% If it doesn't pads the beginning with NaNs
%
% Rod Stewart, 2010-11-16

nchan = length( w );

for ii = 1:nchan
   
    start = get( w(ii), 'start' );
    ndata = get( w(ii), 'DATA_LENGTH' );
    fs = get( w(ii), 'freq' );
    
    ndata_want = fs * 60.0 * 60.0 * 24.0 * ( datim_stop_num - datim_start_num );
    ndata_want = ndata_want + 1;
        
    if ndata ~= ndata_want

        mstring = sprintf( 'Channel %d not enough data: %d (want %d)', ii, ndata, ndata_want );
        m_progress( mfilename, 'I', mstring );
    
        nmissing = ndata_want - ndata;
        
        data = get( w(ii), 'data' );
        
        data2 = [ data ; nan(nmissing,1) ];
        
        w(ii) = set( w(ii), 'data', data2 );
        
    end
    
    if start ~= datim_start_num
        
        mstring = sprintf( 'Channel %d bad start: %s (want %s)', ii, datestr(start), datestr(datim_start_num) );
        m_progress( mfilename, 'I', mstring );
    
        fpts_shift = (start - datim_start_num) * 60.0 * 60.0 * 24.0 * fs;
        npts_shift = ones(1,1) * round( fpts_shift );
                
        data = get( w(ii), 'data' );
        
        data2 = circshift( data, npts_shift );
        
        w(ii) = set( w(ii), 'data', data2 );
        w(ii) = set( w(ii), 'start', datim_start_num );
        
    end
    
end