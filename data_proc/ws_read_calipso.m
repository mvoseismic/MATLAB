function wcal = ws_read_calipso( station, fs, datim_start, datim_stop )
%
% Reads CALIPSO data and returns a waveform structure
%
% Rod Stewart, SRC, 2011-01-18

endian = 'le';

switch station
    case 'AIRS'
        sta = 'as';
    case 'GERS'
        sta = 'ge';
    case 'OLVT'
        sta = 'ol';
    case 'TRNT'
        sta = 'tr';        
end

wcal = [];

dir_data_root = '/Users/Stewart/data/_copy/MVO/CALIPSO';

[yr1 mo1 da1 hr1 mi1 se1] = datevec( datim_start );
[yr2 mo2 da2 hr2 mi2 se2] = datevec( datim_stop );

switch fs
    case 1
        datim_beg_file = datenum( [yr1 mo1 da1 0 0 0] );
        datim_end_file = datenum( [yr2 mo2 da2 0 0 0] );
        datim_jump = 1.0;
    case 50
        datim_beg_file = datenum( [yr1 mo1 da1 hr1 0 0] );
        datim_end_file = datenum( [yr2 mo2 da2 hr2 0 0] );
        datim_jump = 1.0/24.0;
    otherwise
        disp( 'Bad fs' );
end

for ichan = 1:2
    
    switch ichan
        case 1              % Pressure
            cha = 'bar';
            units = 'mbar';
            switch fs
                case 1
                    channel = 'LDU';
                case 50
                    channel = 'BDU';
            end
        case 2              % Strain
            cha = 'a1s';
            units = 'nanostrain';
            switch fs
                case 1
                    channel = 'LV';
                case 50
                    channel = 'BV';
            end
    end
    
    for datim_file = datim_beg_file:datim_jump:datim_end_file
        [yr mo da hr mi se] = datevec( datim_file );
        
        switch fs
            case 1
                dir_data = sprintf( '%s/%s/%04d/%02d', ...
                        dir_data_root, sta, ...
                        yr, mo );
                file_data = sprintf( '%s.%s.%04d.%02d.%02d.00.00.00.1s.sac', ...
                        sta, cha, ...
                        yr, mo, da );
            case 50
                dir_data = sprintf( '%s/%s/%04d/%02d/%02d', ...
                        dir_data_root, sta, ...
                        yr, mo, da );
                file_data = sprintf( '%s.%s.%04d.%02d.%02d.%02d.00.00.50.sac', ...
                        sta, cha, ...
                        yr, mo, da, hr );
        end
        
        fprintf( '%s     %s\n', dir_data, file_data );
        
        if exist( fullfile( dir_data, file_data ) )
            
            w = ws_read_a_sac( dir_data, file_data, endian );
            w = set( w, 'station', station );
            w = set( w, 'channel', channel );
            w = set( w, 'units', units );
            
            wcal = combine( [ wcal w ] );
            
        else
            
            fprintf( 'File does not exist\n' );
            
        end
        
    end
    
    
end

wcal = ws_extract( wcal, datim_start, datim_stop );

return