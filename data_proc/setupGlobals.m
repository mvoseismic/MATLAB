function setup = setupGlobals
%
% Sets up global-type variables for megaplot2
%
% R.C. Stewart, 1-Jan-2020

% Mode
%if java.lang.System.getProperty('java.awt.headless')
if usejava('desktop')
    mode = 'interactive';
else
    mode = 'batch';
end
if desktop('-inuse')
    dispVariableWithName( mode );
end
setup.Mode = mode;

% Hostname and Operating System
if ismac
    OS = 'mac';
elseif isunix
    OS = 'linux';
elseif ispc
    OS = 'win';
end
if desktop('-inuse')
    dispVariableWithName( OS );
end
setup.OS = OS;

% Hostname
[ret, name] = system('hostname');
hostname = strtrim( name );
if desktop('-inuse')
    dispVariableWithName( hostname );
end
setup.Hostname = hostname;

% Where we are, physically
switch setup.Hostname
    case 'RodsMacbookProVI.local'
        if exist( '/Volumes/Seismic_Data/', 'dir' )
            where = 'MVO';
        elseif exist( '/Volumes/Travelling', 'dir' )
            where = 'travelling';
        else
            where = 'unknown';
        end
    case 'opsproc3'
        where = 'MVO';
    case 'rodsnuke'
        where = 'home';
end
if desktop('-inuse')
    dispVariableWithName( where );
end
setup.Where = where;

% What data we are working on
what = 'mvo';
if desktop('-inuse')
    dispVariableWithName( what );
end
setup.What = what;

% Base data directory
switch setup.Hostname
    case 'RodsMacbookProVI.local'
        switch setup.Where
            case 'MVO'
                setup.DirBase = '/Volumes/Seismic_Data';
                setup.DirBase2 = 'unknown';
                setup.DirStuff = 'unknown';
            case 'travelling'
                setup.DirBase = '/Volumes/Travelling/data-mvofls2-Seismic_Data';
                setup.DirBase2 = 'unknown';
                setup.DirStuff = 'unknown';
            otherwise
                setup.DirBase = 'unknown';
                setup.DirBase2 = 'unknown';
                setup.DirStuff = 'unknown';
        end
    case 'opsproc3'
        switch setup.Where
            case 'MVO'
                setup.DirBase = '/mnt/mvofls2/Seismic_Data';
                setup.DirBase2 = '/mnt/mvohvs3/MVOSeisD6';
                setup.DirStuff = '/home/seisan';
            otherwise
                setup.DirBase = 'unknown';
                setup.DirBase2 = 'unknown';
                setup.DirStuff = 'unknown';
        end
    case 'rodsnuke'
        setup.DirBase = '/media/stewart/Travelling';
        setup.DirBase2 = 'unknown';
        setup.DirStuff = '/home/stewart/Dropbox/STUFF';
    end  



% Input file
setup.FileInput = '';

% Output files and directories
setup.DirLog = '.';
setup.FileLog = 'megaplot2.out';

% Data directories
setup.DirMonitoring = fullfile( setup.DirBase, 'monitoring_data' );
setup.DirSeisanCounts = fullfile( setup.DirBase, 'monitoring_data/seisan' );
setup.DirMegaplotData = fullfile( setup.DirBase, 'monitoring_data/megaplot2' );
setup.DirHome = getenv('HOME');
setup.DirSeismicData = fullfile( setup.DirHome, 'projects/SeismicityDiary' );
setup.DirSeismicity = fullfile( setup.DirHome, 'projects/Seismicity' );
setup.DirRsam = fullfile( setup.DirBase, 'monitoring_data/rsam' );
setup.DirSRCData = fullfile( setup.DirBase, 'monitoring_data/seismic/SRC' );
setup.DirWAV = fullfile( setup.DirBase, 'WAV/MVOE_' );
setup.DirChronology = fullfile( setup.DirHome, 'STUFF/MATLAB/megaplot2/chronology' );
setup.DirNDBC = fullfile( setup.DirStuff, 'data/weather/NationalDataBuoyCenter' );
setup.DirWeather = fullfile( setup.DirStuff, 'data/weather/MVO' );
setup.DirMeteostat = fullfile( setup.DirStuff, 'data/weather/Meteostat' );
setup.DirKestrel = fullfile( setup.DirStuff, 'data/weather/Kestrel5500--LOCAL_TIME' );
setup.DirMseed = fullfile( setup.DirBase2, 'mseed' );
setup.DirDem = fullfile( setup.DirStuff, 'data/geographic/DEM/SHV_DEM_data' );
setup.DirStatus = fullfile( setup.DirBase, 'monitoring_data/status' );
setup.DirStatusMonitoring = fullfile( setup.DirBase, 'monitoring_data/statusMonitoring' );

% Output options
setup.Log2File = true;
setup.Log2Screen = true;
setup.Plot2File = true;
setup.Plot2Screen = true;

% Dates for data arrays
setup.DataBeg = datenum( 1995, 1, 1, 0, 0, 0 );
setup.DataEnd = dateCommon( 'endDay' );

% Dates for plots
setup.PlotBeg = setup.DataBeg;
setup.PlotEnd = setup.DataEnd;

% Limits for plots
setup.PlotDatimLim = [setup.DataBeg setup.DataEnd];
setup.PlotMagLim = [-inf inf];
setup.PlotDepLim = [0 inf];

% Do you want to rebin daily counts
setup.CountBinResamp = 'yes';

% Plot defaults
setup.plot.Size = 'A4';
setup.plot.Orientation = 'landscape';
setup.plot.Type = 'symbol';
setup.plot.Colour = 'r';
setup.plot.Symbol = 'o';
setup.plot.Line = '-';
setup.plot.FontSize = 14;
setup.SubplotSpace = 'normal';
setup.PlotXaxis = 'normal';
setup.plot.NPanes = 1;
setup.plot.Footer = sprintf( 'MVO, %s', datestr( now, 1 ) );

% Overall name
setup.Name = '';

% Special plots
setup.Standard ='';
setup.Period = '';









