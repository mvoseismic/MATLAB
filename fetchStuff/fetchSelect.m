function fetchSelect( setup, ouf, infile )
% 
% Fetches seismic event info produced by select and saves them as Hypo
% structure
%
% R.C. Stewart 3-Mar-2020

%{
% Initialise arrays
select_datims = [];
select_latitudes = [];
select_longitudes = [];
select_depths = [];
select_types = [];
select_locagencys = [];
select_nstas = [];
select_errs = [];
select_mags = [];
select_magtypes = [];
select_magagencys = [];
select_volctypes = [];
select_locateds = [];
select_isin_strings = [];
%}

% Read data from file
if nargin == 3
    data_file = infile;
else
    data_file = 'select.out';
    data_file = fullfile( setup.DirSeisanCounts, data_file );
end
fid = fopen(data_file,'r');

% date for change in depth datum
datim_change = datenum( 2014, 11, 1 );
 
tline = fgetl(fid);
evid = 0;

while ischar(tline)
    
    card = tline(80);
        

    switch card
        
            
        case '1'
            
            evid = evid + 1;
            %Hypo(evid) = defineHypo();
            
            ipick = 0;
    
            [datim, type, lat, lon, dep, loc_agency, nsta, ....
                err, mag, mag_type, mag_agency] = parseSelectLine1( tline );
            
            if datim < datim_change
                dep = dep - 0.541;
            else
                dep = dep - 1.241;
            end
    
            
            switch type
        
                case {'L ','R ','D '}
                    Hypo(evid).type = type(1);
            
                case 'LV'
                    Hypo(evid).type = 'V';
            
                otherwise
                    Hypo(evid).type = ' ';
            
            end
            
    
            if ~isnan( lat )
        
                Hypo(evid).located = 1;
                Hypo(evid).otime = datim;          
                Hypo(evid).datim = datim - 20.0/(24.0*60.0*60.0);
                Hypo(evid).lat = lat;            
                Hypo(evid).lon = lon;           
                Hypo(evid).dep = dep; 
                Hypo(evid).depRef = 's';
                Hypo(evid).locAgency = loc_agency;
                Hypo(evid).mag = mag;  
                Hypo(evid).magType = mag_type;  
                Hypo(evid).magAgency = mag_agency; 
                Hypo(evid).rms = err;
                Hypo(evid).nph = nsta;
                Hypo(evid).moment = 10 ^ (1.5 * ((0.6667 * mag + 1.15) + 6.07));
        
            else
        
                Hypo(evid).located = 0;
                Hypo(evid).datim = datim;  
                Hypo(evid).otime = datim + 20.0/(24.0*60.0*60.0);
                Hypo(evid).lat = NaN;            
                Hypo(evid).lon = NaN;           
                Hypo(evid).dep = NaN; 
                Hypo(evid).depRef = '';
                Hypo(evid).locAgency = '';
                Hypo(evid).mag = NaN;  
                Hypo(evid).magType = '';  
                Hypo(evid).magAgency = ''; 
                Hypo(evid).rms = NaN;
                Hypo(evid).nph = NaN;
        
            end
    

              
            
        case 'H'
                
            Hypo(evid).located = 1;
            [otime, lat, lon, dep, err] = parseSelectLineH( tline );
            
            if datim < datim_change
                dep = dep - 0.541;
            else
                dep = dep - 1.241;
            end
            
            Hypo(evid).otime = otime;
            Hypo(evid).lat = lat;
            Hypo(evid).lon = lon;
            Hypo(evid).dep = dep;
            Hypo(evid).rms = err;
            Hypo(evid).depRef = 's';
    
            
        case 'E'
            
            [gap, err_ot, err_lat, err_lon, err_dep, ...
                cov_xy, cov_xz, cov_yz] = parseSelectLineE( tline );
            
            Hypo(evid).gap = gap;
            Hypo(evid).err_ot = err_ot;
            Hypo(evid).err_lat = err_lat;
            Hypo(evid).err_lon = err_lon;
            Hypo(evid).err_dep = err_dep;
            Hypo(evid).cov_xy = cov_xy;
            Hypo(evid).cov_xz = cov_xz;
            Hypo(evid).cov_yz = cov_yz;
            
            
            
        case '3'
            
            if strncmp( tline, ' VOLC MAIN', 10 )
                
                Hypo(evid).volctype = tline(12);
                
            end
            
            
            
        case '6'
            
            filename = tline(2:end-1);
            Hypo(evid).file = strtrim( filename );
            
            
            
        case ' '
            
            if strncmp(tline, ' M', 2)  % THIS IS DODGY!
                
                ipick = ipick + 1;
                
                Hypo(evid).Pick(ipick).sta = (tline(2:6));
                Hypo(evid).Pick(ipick).cha = (tline(7:8));
                Hypo(evid).Pick(ipick).weightf = tline(9);
                Hypo(evid).Pick(ipick).quality = tline(10);
                Hypo(evid).Pick(ipick).phase = tline(11:14);
                Hypo(evid).Pick(ipick).weighting = tline(15);
                Hypo(evid).Pick(ipick).flag = tline(16);
                Hypo(evid).Pick(ipick).first_motion = tline(17);
                Hypo(evid).Pick(ipick).hour = str2double(tline(19:20));
                Hypo(evid).Pick(ipick).min = str2double(tline(21:22));
                Hypo(evid).Pick(ipick).sec = str2double(tline(23:28));
                Hypo(evid).Pick(ipick).duration = str2double(tline(30:33));
                Hypo(evid).Pick(ipick).amplitude = str2double(tline(34:40));
                Hypo(evid).Pick(ipick).period = str2double(tline(42:45));
                Hypo(evid).Pick(ipick).direction_of_approach = str2double(tline(47:51));
                Hypo(evid).Pick(ipick).phase_velocity = str2double(tline(53:56));
                Hypo(evid).Pick(ipick).angle_of_incidence = str2double(tline(57:60));
                Hypo(evid).Pick(ipick).azimuth_residual = str2double(tline(61:63));
                Hypo(evid).Pick(ipick).time_residual = str2double(tline(64:68));
                Hypo(evid).Pick(ipick).weight = str2double(tline(69:70));
                Hypo(evid).Pick(ipick).epicentral_distance = str2double(tline(71:75));
                Hypo(evid).Pick(ipick).azimuth_at_source = str2double(tline(77:79)); 
                
            end
            
            
    end
    
    tline = fgetl(fid);
    
end

fclose( fid );


% Set if in string time limit
idins = isInStrings( setup, [Hypo.otime] );
select_isin_strings = idins;
c = num2cell( idins );
[Hypo.isin_string] = c{:};


fprintf( 1, "==== fetchSelect\n" );
fprintf( 1, "total events:           %6d\n", length( Hypo ) );

nT = length( strfind( [Hypo.type], 'T' ) );
nR = length( strfind( [Hypo.type], 'R' ) );
nL = length( strfind( [Hypo.type], 'L' ) );
nLV = length( strfind( [Hypo.type], 'V' ) );
fprintf( 1, "total T events:         %6d\n", nT );
fprintf( 1, "total R events:         %6d\n", nR );
fprintf( 1, "total L events:         %6d\n", nL );
fprintf( 1, "total LV events:        %6d\n", nLV );

if nargin >= 2
    fprintf( ouf, "==== fetchSelect\n" );
    fprintf( ouf, "total events:           %6d\n", length( Hypo ) );
    fprintf( ouf, "total T events:         %6d\n", nT );
    fprintf( ouf, "total R events:         %6d\n", nR );
    fprintf( ouf, "total L events:         %6d\n", nL );
    fprintf( ouf, "total LV events:        %6d\n", nLV );
end

if nLV > 0
    for iloctype = 1:9
        switch iloctype
            case 1
                id = 't';
                vtype = 'VT';
            case 2
                id = 'h';
                vtype = 'hybrid';
            case 3
                id = 'l';
                vtype = 'LP';
            case 4
                id = 'e';
                vtype = 'LP/rockfall';
            case 5
                id = 'r';
                vtype = 'rockfall';
            case 6
                id = 'x';
                vtype = 'explosion';
            case 7
                id = 's';
                vtype = 'swarm';
            case 8
                id = 'n';
                vtype = 'noise';
            case 9
                id = 'm';
                vtype = 'monochromatic';
        end
    
        nLVT = length( strfind( [Hypo.volctype], id ) );
    
        fprintf( 1, "total LV %s events:      %6d   (%s)\n", id, nLVT, vtype );
        if nargin >= 2
            fprintf( ouf, "total LV %s events:      %6d   (%s)\n", id, nLVT, vtype );
        end
    
    end
end
           
nloc = sum( [Hypo.located] == 1 );
fprintf( 1, "total located events:   %6d\n", nloc );
ninst = sum( idins );
fprintf( 1, "total evs in strings:   %6d\n", ninst );
if nargin >= 2
    fprintf( ouf, "total located events:   %6d\n", nloc );
    fprintf( ouf, "total evs in strings:   %6d\n", ninst );
    fprintf( ouf, "\n" );
end

%{
% Save to file
if nargin == 3
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHyp.mat' );
else
    data_file = fullfile( setup.DirMegaplotData, 'fetchedSelect.mat' );
end
save( data_file, ...
    'select_datims', ...
    'select_latitudes', ...
    'select_longitudes', ...
    'select_depths', ...
    'select_types', ...
    'select_locagencys', ...
    'select_nstas', ...
    'select_errs', ...
    'select_mags', ...
    'select_magtypes', ...
    'select_magagencys', ...
    'select_locateds', ...
    'select_volctypes', ...
    'select_isin_strings' );
%}

% Save to file
if nargin == 3
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoSelectSpecial.mat' );
else
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoSelect.mat' );
end
save( data_file, 'Hypo' );