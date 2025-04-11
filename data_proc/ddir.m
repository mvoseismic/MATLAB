function ddir( locstring )
%
% Sets data directories for seismic and other data
%
% Rod Stewart, 2008-12-26

global DIR_RSAM
global DIR_SGRAM
global DIR_RSAM_ANALYSIS
global DIR_WEATHER
global DIR_DOAS
global DIR_MVOPLOT
global DIR_WUNDERGROUND
global DIR_SEISAN_CONT_RECENT
global DIR_SEISAN_CONT
global DIR_PANPLOT
global DIR_WAVESERVER_V
global NETWORK

% test if location string passed as argument, if not, ask for it
if (nargin == 0)
    
    fprintf( 1, '%s\n', 'Select' );
    locstring = input( 'Select location: ', 's' );
    
end
    
% current directory
if strmatch( locstring, '.' )
    DIR_RSAM = '.';
    DIR_SGRAM = '.';
    DIR_RSAM_ANALYSIS = '.';
    DIR_WEATHER = '.';
    DIR_MVOPLOT = '.';
    DIR_WUNDERGROUND = '.';
    DIR_SEISAN_CONT_RECENT = '.';
        
% mvo
elseif strmatch( locstring, 'mvo' )
    DIR_RSAM = '/Volumes/monitoring_data/rsam';
    DIR_SGRAM = '/Volumes/monitoring_data/sgram';
    DIR_RSAM_ANALYSIS = '/Users/seisan/data/rsam-analysis';
    DIR_WEATHER = '/Users/rod/data/Climate_Weather';
    DIR_DOAS = '/Users/rod/data/DOAS';
%    DIR_SEISAN_CONT_RECENT = '/Volumes/monitoring_data/rbuffers';
    DIR_SEISAN_CONT_RECENT = '/Users/rod/src/panacea/data';
    DIR_WAVESERVER_V = '172.20.0.163:16022';

% mvo data at sru
elseif strmatch( locstring, 'mvo@src' )
    DIR_RSAM = '/home/stewart/data-sru/mvo/rsam';
    DIR_SGRAM = '/home/stewart/data-sru/mvo/sgram';
    DIR_RSAM_ANALYSIS = '/home/stewart/data-sru/mvo/rsam-analysis';
    DIR_WEATHER = '/home/stewart/data/Climate_Weather';
    DIR_DOAS = '/home/stewart/data/DOAS';
    DIR_MVOPLOT = '/home/stewart/projs/Montserrat/MVOMonitoringPlot';
    DIR_WUNDERGROUND = '/home/stewart/data/Climate_Weather';
    
% mvo data on MacBook
elseif strmatch( locstring, 'mvo@macbook' )
    DIR_RSAM = '/Users/stewart/Data-local/MVO/seismic/rsam';
    DIR_SGRAM = '.';
    DIR_RSAM_ANALYSIS = '/Users/stewart/Projects/Montserrat/rsam-analysis';
    DIR_WEATHER = '';
    DIR_DOAS = '';
    DIR_SEISAN_CONT = '/Users/stewart/Data-local/MVO/seismic/seisan-cont';
    NETWORK = 'MVO';
    

% interactive
else    
    fprintf(1,'%s\n', 'Flag not recognised, enter directories');
    DIR_RSAM = inputd('RSAM data directory', 's', '.' );
    DIR_SGRAM = inputd('SGRAM data directory', 's', '.' );
    DIR_RSAM_ANALYSIS =  inputd('RSAM_ANALYSIS data directory', 's', '.' );
    DIR_WEATHER =  inputd('WUNDER data directory', 's', '.' );
    DIR_DOAS =  inputd('DOAS data directory', 's', '.' );
end
