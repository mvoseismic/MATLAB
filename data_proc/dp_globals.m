function dp_globals( setup )
%
% Sets globals for DP software
%
% Rod Stewart, 2010-01-24

global DP_OS                        % Operating system
global DP_WHERE                     % Which place I am
global DP_DATA                      % What data I want
global DP_DIR_RSAM                  % RSAM data directory
global DP_DIR_RSAM_SUMMARY          % RSAM summary directory
global DP_MODE                      % login or cron
global DP_DIR_GCF                   % GCF data directory root
global DP_DIR_BOB                   % BOB data for early MVO days

global DP_SEISAN_CONT               % Continuous seisan data
global DP_NETWORK                   % Code of network
global DP_NETWORK_SEISAN            % Code used by SEISAN for network

global DP_SCNL                      % SCNLs of data used (cell array of strings)
global DP_RSAM_NSMOOTH              % # pts in running-median filter        

global DP_VERBOSE                   % Flag for messages

DP_OS = setup.OS;
DP_WHERE = lower( setup.Where );
DP_DATA = setup.What;
if strcmp( setup.Mode, 'interactive' )
    DP_MODE = 'login';
else
    DP_MODE = 'cron';
end

%{
% Get DP_VERBOSE from environment variable
if strcmp( getenv( 'DP_VERBOSE' ), 'true' );
    DP_VERBOSE = true;
else
    DP_VERBOSE = false;
end
%}

if DP_VERBOSE
    progress = sprintf( 'OS: %s  Where: %s  Data: %s', DP_OS, DP_WHERE, DP_DATA );
    m_progress( mfilename, 'D', progress );
end

switch DP_OS
    case 'darwin'
        switch DP_WHERE
            case 'mvo'
                switch DP_DATA
                    case 'ecsn'
                    case 'mvo'                          % Darwin.mvo.mvo
                        DP_DIR_RSAM = '/Volumes/Seismic_Data/monitoring_data/rsam';
                        DP_DIR_RSAM_SUMMARY = '/Volumes/Seismic_Data/monitoring_data/rsam_summary';
                        DP_DIR_GCF = '';
                end
            case 'src'
                switch DP_DATA
                    case 'ecsn'
                    case 'mvo'
                end
            case 'offline'
                switch DP_DATA
                    case 'ecsn'                         % Darwin.offline.ecsn
                        DP_SEISAN_CONT = '/Users/stewart/data/_copy/ECSN/data/seisan_cont';
                        
                    case 'mvo'                          % Darwin.offline.mvo
                        DP_SEISAN_CONT = '/Users/stewart/data/_copy/MVO/seisan_cont';
                        DP_DIR_RSAM = '/Users/stewart/data/_copy/MVO/seismic/rsam';
                        DP_DIR_GCF = '/Users/stewart/data/_copy/MVO/seismic/gcf';
                        DP_DIR_BOB = '/Users/stewart/data/_copy/MVO/data_BOB-1995-1997';
                    case 'src'
                        DP_DIR_GCF = '/Users/stewart/data/_copy/SRC/seismic/gcf';
                        
                end
        end
    case 'linux'
        switch DP_WHERE
            case 'mvo'
                switch DP_DATA
                    case 'ecsn'
                    case 'mvo'
                end
            case 'src'
                switch DP_DATA
                    case 'ecsn'
                    case 'mvo'
                end
            case 'offline'
                switch DP_DATA
                    case 'ecsn'
                    case 'mvo'
                end
        end
end

switch DP_DATA
    case 'ecsn'
        DP_NETWORK_SEISAN = 'MAN';
    case 'mvo'
        DP_NETWORK_SEISAN = 'MVO';
end
%{
    otherwise
        fprintf(1,'%s\n', 'String, enter values');
        DP_DIR_RSAM = inputd('RSAM data directory', 's', '.' );
        DP_DIR_GCF = inputd('GCF data directory', 's', '.' );
        DP_WHERE = inputd('DP_WHERE', 's', '.' );
        DP_DATA = inputd('DP_DATA', 's', '.' );
       
end
%}


DP_RSAM_NSMOOTH = int32( 51 );
