function fetchCollect( setup, ouf )
% 
% Fetches seismic event info produced by collect and saves them as Hypo
% structures
%
% R.C. Stewart 03-Feb-2020

%{
% Initialise arrays
collect_datims = [];
collect_latitudes = [];
collect_longitudes = [];
collect_depths = [];
collect_types = [];
collect_locagencys = [];
collect_nstas = [];
collect_errs = [];
collect_mags = [];
collect_magtypes = [];
collect_magagencys = [];
%}

% Read data from file
data_file = 'collect.out';
filename = fullfile( setup.DirSeisanCounts, data_file );
fid = fopen(filename,'r');

tline = fgetl(fid);
evid = 1;
while ischar(tline)
   
    Hypo(evid) = defineHypo();
    
    [datim, type, lat, lon, dep, loc_agency, nsta, ....
        err, mag, mag_type, mag_agency] = parseSelectLine1( tline );
  
    %{
    collect_d(evid) = datim;
    collect_types{evid} = type;
    collect_latitudes(evid) = lat;
    collect_longitudes(evid) = lon;
    collect_depths(evid) = dep;    
    collect_locagencys{evid} = loc_agency;
    collect_nstas(evid) = nsta;
    collect_errs(evid) = err;
    collect_mags(evid) = mag;
    collect_magtypes{evid} = mag_type;
    collect_magagencys{evid} = mag_agency;
    %}
    
      
    
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
        Hypo(evid).depRef = 'v';
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
        
    end
    
    tline = fgetl(fid);
    evid = evid+1;
    
end

fclose( fid );

fprintf( 1, "==== fetchCollect\n" );
fprintf( 1, "total events:           %6d\n", length( Hypo ) );
if nargin == 2
    fprintf( ouf, "==== fetchCollect\n" );
    fprintf( ouf, "total events:           %6d\n", length( Hypo ) );
end

nT = length( strfind( [Hypo.type], 'T' ) );
nR = length( strfind( [Hypo.type], 'R' ) );
nL = length( strfind( [Hypo.type], 'L' ) );
nLV = length( strfind( [Hypo.type], 'V' ) );
fprintf( 1, "total T events:         %6d\n", nT );
fprintf( 1, "total R events:         %6d\n", nR );
fprintf( 1, "total L events:         %6d\n", nL );
fprintf( 1, "total LV events:        %6d\n", nLV );
if nargin == 2
    fprintf( ouf, "total T events:         %6d\n", nT );
    fprintf( ouf, "total R events:         %6d\n", nR );
    fprintf( ouf, "total L events:         %6d\n", nL );
    fprintf( ouf, "total LV events:        %6d\n", nLV );
    fprintf( ouf, "\n" );
end

% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoCollect.mat' );
save( data_file, 'Hypo' );
