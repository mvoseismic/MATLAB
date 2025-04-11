function fetchSoufriereHypos( setup, ouf, infile )
% 
% Fetches SRC seismic event info from *L.EVN files and saves them as MATLAB arrays
%
% R.C. Stewart 20-Feb-2020


% Read data from file
if nargin == 3
    data_file = infile;
else
    data_file = 'soufriere_events.txt';
end
filename = fullfile( setup.DirSRCData, data_file );
fid = fopen(filename,'r');


tline = fgetl(fid);
evid = 1;
while ischar(tline)
   
    Hypo(evid) = defineHypo;
    
    [otime, type, located, lat, lon, dep, loc_agency, nph, ...
    rms, mag, mag_type, mag_agency, felt] = parseSoufriereHypos( tline );
    
    Hypo(evid).otime = otime;
    Hypo(evid).lat = lat;
    Hypo(evid).lon = lon;
    Hypo(evid).dep = dep;
    Hypo(evid).mag = mag;
   
    Hypo(evid).felt = felt;
    Hypo(evid).rms = rms;
    Hypo(evid).nph = nph;
   
    Hypo(evid).located = located;
    
    
    tline = fgetl(fid);
    evid = evid+1;
    
end

fclose( fid );

nev = evid - 1;

fprintf( 1, "==== fetchSoufriereHypos\n" );
fprintf( 1, "total events:           %6d\n", nev );

if nargin >= 2
    fprintf( ouf, "==== fetchSoufriereHypos\n" );
    fprintf( ouf, "total events:           %6d\n", nev );
end

% Save Hypo structure to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoSoufriere.mat' );
save( data_file, 'Hypo' );