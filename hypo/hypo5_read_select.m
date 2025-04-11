function file_save = hypo5_read_select( file_select, file_save, stacode_in )
%
%
% Reads a select.out file and creates a bunch of arrays with all the data
% 
% Rod Stewart, 2010-11-19

if file_select
else
    file_select = 'select.out';
end
if strcmp( file_save, '' )
    file_save = 'Hypo5';
end

% Use egrep to get number of events in this file
command = sprintf( 'egrep "1$" %s | wc -l', file_select );
[status,result] = system( command );
nev = str2num( result );

% Arrays for hypocentre data
evid_str = '              ';                          % 14 char max
ev_id = repmat( evid_str, nev, 1 );
file_str = '                                        ';  % 40 char max
ev_file = repmat( file_str, nev, 1 );
agency_str = '    ';                                    %  4 char max
ev_agency = repmat( agency_str, nev, 1 );
ev_located = zeros(nev,1);
ev_otime = nan(nev,1);
ev_latitude = nan(nev,1);
ev_longitude = nan(nev,1);
ev_depth = nan(nev,1);
ev_rms = nan(nev,1);
ev_otime_hi = nan(nev,1);
ev_latitude_hi = nan(nev,1);
ev_longitude_hi = nan(nev,1);
ev_depth_hi = nan(nev,1);
ev_rms_hi = nan(nev,1);
ev_otime_err = nan(nev,1);
ev_lat_err = nan(nev,1);
ev_lon_err = nan(nev,1);
ev_dep_err = nan(nev,1);
ev_type = repmat( '  ', nev, 1 );
ev_subtype = repmat( ' ', nev, 1 );
ev_gap = nan(nev,1);
ev_cov_xy = nan(nev,1);
ev_cov_xz = nan(nev,1);
ev_cov_yz = nan(nev,1);
% Not implemented
%
% network
% subnet
% magnitude 1/2/3
% nsta


% If stacodes is not a cell array of station codes, need to get it from the
% data, using egrep
% Use egrep and awk to get the number of stations

if length(stacode_in) == 1
    nsta = length( stacode_in{1} );
    for ista = 1:nsta
        stacode(ista) = stacode_in{1}(ista);
    end
else
    % Use egrep again to get list of stations from file
    command = sprintf( 'egrep " $" %s | awk ''{print $1}'' | sort -u', file_select );
    [status,result] = system( command );
    stacode = regexp( strtrim(result), '\n', 'split' );
    nsta = length( stacode );
end

% Arrays for pick data
pk_p_time = nan(nev,nsta);
pk_p_qual = repmat( ' ', nev, nsta );
pk_p_wt = repmat( ' ', nev, nsta );
pk_p_pol = repmat( ' ', nev, nsta );
pk_p_amp = nan(nev,nsta);
pk_p_per = nan(nev,nsta);
pk_p_coda = nan(nev,nsta);
pk_s_time = nan(nev,nsta);
pk_s_qual = repmat( ' ', nev, nsta );
pk_s_wt = repmat( ' ', nev, nsta );

% Not implemented
%
% Lots
% Pn Pg etc etc

% Use egrep to get event lines from file
command = sprintf( 'egrep "1$" %s', file_select );
[status,result] = system( command );
ev_line = regexp( strtrim(result), '\n', 'split' );
nev = length( ev_line );

% Use perl script to split the file into many small files
command = sprintf( 'cat %s | ~/bin/select_split.pl', file_select );
system( command );
tmp_files = dir( 'tmp*.tmp' );

% Treat one event at a time, slow I know, but easiest
for iev = 1:nev
    
    file_in = tmp_files(iev).name;
    %fprintf( '%3d %s\n', iev, char(ev_line(iev)) );
    %fprintf( '%s\n', file_in );
    
    fid = fopen( file_in );
    tline = fgetl( fid );
    
    while ischar(tline)

        if length(tline) > 79
            card = tline(80);
            
            switch card
                case '1'
                    yr = str2double(tline(2:5));
                    mo = str2double(tline(7:8));
                    da = str2double(tline(9:10));
                    hr = str2double(tline(12:13));
                    min = str2double(tline(14:15));
                    sec = str2double(tline(17:20));
                    ev_otime(iev) = datenum( yr, mo, da, hr, min, sec );
                    ev_type(iev,:) = tline(22:23);
                    ev_latitude(iev) = str2double(tline(24:30));
                    ev_longitude(iev) = str2double(tline(31:38));
                    ev_depth(iev) = str2double(tline(39:43));
                    ev_agency(iev,:) = tline(45:48);
                %n_sta = str2double(tline(49:51));
                    ev_rms(iev) = str2double(tline(52:55));
                %magnitude1 = str2double(tline(56:59));
                %magnitude1_type = tline(60);
                %magnitude1_agency = tline(61:63);
                %magnitude2 = str2double(tline(64:67));
                %magnitude2_type = tline(68);
                %magnitude2_agency = tline(69:71);
                %magnitude3 = str2double(tline(72:75));
                %magnitude3_type = tline(76);
                %magnitude3_agency = tline(77:79);
                

                case 'E'
                    ev_located(iev) = 1;
                    ev_gap(iev) = str2double(tline(6:8));
                    ev_otime_err(iev) = str2double(tline(15:20));
                    ev_lat_err(iev) = str2double(tline(25:30));
                    ev_lon_err(iev) = str2double(tline(33:38));
                    ev_dep_err(iev) = str2double(tline(39:43));
                    ev_cov_xy(iev) = str2double(tline(44:55));
                    ev_cov_xz(iev) = str2double(tline(56:67));
                    ev_cov_yz(iev) = str2double(tline(68:79));
                case 'H'
                    ev_located(iev) = 2;
                    yr = str2double(tline(2:5));
                    mo = str2double(tline(7:8));
                    da = str2double(tline(9:10));
                    hr = str2double(tline(12:13));
                    min = str2double(tline(14:15));
                    sec = str2double(tline(17:22));
                    ev_otime_hi(iev) = datenum( yr, mo, da, hr, min, sec );
                    ev_latitude_hi(iev) = str2double(tline(24:32));
                    ev_longitude_hi(iev) = str2double(tline(34:44));
                    ev_depth_hi(iev) = str2double(tline(45:52));
                    ev_rms_hi(iev) = str2double(tline(54:59));

                case 'I'
                    ev_id(iev,:) = tline(61:74);
                case '3'
                    if strncmp( tline, ' VOLC', 5 )
                        if strncmp( tline, ' VOLC MAIN', 10 )
                            ev_subtype(iev) = tline(12:12);
                        end
                    else
                        %ev_subnet = strtrim(tline(1:79));
                    end
                case '6'
                     file_name = strtrim(tline(2:79));
                     ev_file(iev,1:length(file_name)) = file_name;
                case 'F'
                case ' '
                    pick_sta = strtrim(tline(2:6));
                    pick_cha = (tline(7:8));
                    %pick_weight = tline(9);
                    pick_quality = tline(10);
                    pick_phase = tline(11:14);
                    pick_weighting = tline(15);
                    %pick_flag = tline(16);
                    pick_polarity = tline(17);
                    pick_hour = str2double(tline(19:20));
                    pick_min = str2double(tline(21:22));
                    pick_sec = str2double(tline(23:28));
                    pick_coda = str2double(tline(30:33));
                    pick_amplitude = str2double(tline(34:40));
                    pick_period = str2double(tline(42:45));
                    %pick_direction_ofapproach = str2double(tline(47:51));
                    %pick_phase_velocity = str2double(tline(53:56));
                    %pick_angle_of_incidence = str2double(tline(57:60));
                    %pick_azimuth_residual = str2double(tline(61:63));
                    %pick_time_residual = str2double(tline(64:68));
                    %pick_weight = str2double(tline(69:70));
                    %pick_epicentral_distance = str2double(tline(71:75));
                    %pick_azimuth_at_source = str2double(tline(77:79)); 
                    
                    % ID of station
                    id_sta = strcmp( cellstr(stacode), pick_sta );
                                 
                    if sum(id_sta) ==1
                        ista = find( id_sta );
                        if strncmpi( pick_phase, 'A', 1 )
                            pk_p_amp(iev,ista) = pick_amplitude;
                            pk_p_per(iev,ista) = pick_period;
                        else
                            pick_time = datenum( [yr, mo, da, ...
                                pick_hour, pick_min, pick_sec] );
                            if pick_hour ~= hr
                                move_hrs = pick_hour - hr;
                                move_hrs = abs( move_hrs );
                                pick_time = pick_time + (move_hrs/24.0);
                            end
                            if strncmpi( pick_phase, 'P', 1 )
                                pk_p_time(iev,ista) = pick_time;
                                pk_p_wt(iev,ista) = pick_weighting;
                                pk_p_qual(iev,ista) = pick_quality;
                                pk_p_pol(iev,ista) = pick_polarity;
                                pk_p_coda(iev,ista) = pick_coda;
                            elseif strncmpi( pick_phase, 'S', 1 )
                                pk_s_time(iev,ista) = pick_time;
                                pk_s_wt(iev,ista) = pick_weighting;
                                pk_s_qual(iev,ista) = pick_quality;
                            end
                        end
                        
                    elseif sum(id_sta) > 1
                        disp( 'Appear to have found multiple stations' );
                    end

            end
        end
        
        tline = fgetl( fid);
    end

    
    fclose( fid );
    delete( file_in );
    
end

delete( tmp_files(nev+1).name );


% Create time-sorted version of ev_otime
[ev_otime_seq, id_seq] = sort( ev_otime );

% Reorder all the arrays
ev_id(:,:) = ev_id(id_seq,:);
ev_file(:,:) = ev_file(id_seq,:);
ev_agency(:,:) = ev_agency(id_seq,:);
ev_located = ev_located(id_seq);
ev_type(:,:) = ev_type(id_seq,:);
ev_subtype(:,:) = ev_subtype(id_seq,:);
ev_otime = ev_otime( id_seq );
ev_rms = ev_rms( id_seq );
ev_latitude = ev_latitude( id_seq );
ev_longitude = ev_longitude( id_seq );
ev_depth = ev_depth( id_seq );
ev_otime_hi = ev_otime_hi( id_seq );
ev_rms_hi = ev_rms_hi( id_seq );
ev_latitude_hi = ev_latitude_hi( id_seq );
ev_longitude_hi = ev_longitude_hi( id_seq );
ev_depth_hi = ev_depth_hi( id_seq );
ev_cov_xy = ev_cov_xy( id_seq );
ev_cov_xz = ev_cov_xz( id_seq );
ev_cov_yz = ev_cov_yz( id_seq );
pk_p_time(:,:) = pk_p_time(id_seq,:);
pk_s_time(:,:) = pk_s_time(id_seq,:);
pk_p_wt(:,:) = pk_p_wt(id_seq,:);
pk_s_wt(:,:) = pk_s_wt(id_seq,:);
pk_p_qual(:,:) = pk_p_qual(id_seq,:);
pk_s_qual(:,:) = pk_s_qual(id_seq,:);
pk_p_pol(:,:) = pk_p_pol(id_seq,:);
pk_p_coda(:,:) = pk_p_coda(id_seq,:);
pk_p_amp(:,:) = pk_p_amp(id_seq,:);
pk_p_per(:,:) = pk_p_per(id_seq,:);

save( file_save,    'ev_id', 'ev_file', 'ev_agency', ...
                    'ev_located', 'ev_type', 'ev_subtype', ...
                    'ev_otime', 'ev_rms', ...
                    'ev_latitude', 'ev_longitude', 'ev_depth', ...
                    'ev_otime_hi', 'ev_rms_hi', ...
                    'ev_latitude_hi', 'ev_longitude_hi', 'ev_depth_hi', ...
                    'ev_gap', 'ev_cov_xy', 'ev_cov_xz', 'ev_cov_yz', ...
                    'pk_p_time', 'pk_s_time', ...
                    'pk_p_wt', 'pk_s_wt', ...
                    'pk_p_qual', 'pk_s_qual', ...
                    'pk_p_pol', 'pk_p_coda', ...
                    'pk_p_amp', 'pk_p_per', ...
                    'stacode' );

return

