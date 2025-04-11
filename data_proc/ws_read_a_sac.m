function w = ws_read_a_sac( dir_data, file_data, endian )
%
% Reads a single SAC file and returns it as a waveform object
%
% Rod Stewart, 2011-01-18
%

switch endian
    case 'be'
        type = 'ieee-be';
    case 'le'
        type = 'ieee-le';
end

[data, hdr] = readsac( fullfile( dir_data, file_data ), type);

datim_start = datenum( [ hdr.NZYEAR, 1, 1, hdr.NZHOUR, hdr.NZMIN, hdr.NZSEC ] );
datim_start = datim_start + hdr.NZJDAY -1;
fs = 1.0 / hdr.DELTA;
fs = floor( fs );
ndata = hdr.NPTS;

station = char( hdr.KSTNM' );
channel = char( hdr.KCMPNM' );

w = waveform( station, channel, fs, datim_start, data );

return
