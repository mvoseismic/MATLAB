% fetch_gps_auto_final_all
%
% Takes the latest auto-processed GPS, and creates MATLAB time series
%
% Creates a binary file containing data for ALL stations and components
%
% after Rod Stewart, UWI/SRU, 2010-10-19 and Paddy Smith, MVO 30-Apr-2012
%
% This version Paddy Smith, 18-Oct-2012 


global DIR_MVOPLOT

DIR_MVOPLOT=pwd;

%% station and component list:

stats={'AIRS';...
'CN62';...
'FRGR';...
'GERD';...
'MGOD';...
'HARR';...
'HERM';...
'MVO1';...
'NWBL';...
'OLVN';...
'RCHY';...
'RDON';...
'SGH1';...
'SSOU';...
'SPRI';...
'TRNT';...
'WTY2';...
'WTYD'};

comps=['r';'t';'v']; % radial, tangential, vertical


%% loooop over stations then components

for s=1:length(stats)

    stat = stats{s};
    
    for c = 1:3
        
        comp = comps(c);
        
%%

% Local directories
DATADIR = sprintf( '%s/%s', DIR_MVOPLOT, 'data/gps' );
DATADIRGPS = sprintf( '%s/%s', DATADIR, 'gps-auto-final' );

DateStart = datenum( 1995, 01, 01, 0, 0, 0 );
DateStartYear = 1995;
DateEnd = datenum( date ) ;
[DateEndYear dum1 dum2 dum3 dum4 dum5] = datevec( DateEnd );
days = DateEnd - DateStart + 1;
gps_Date = [ DateStart:DateEnd ];

datatime = [DateStart:1:DateEnd];
datatimecell = cellstr( datestr( datatime, 0) );

% Create time series for each type full of NaNs
% gps_GERDn = NaN( 1, days );
% gps_GERDe = NaN( 1, days );

% eval(sprintf('gps_%s%s = NaN( 1, days );', stat, comp));

gps_stat_comp = NaN( 1, days );
gps_stat_err = NaN( 1, days );

% Read all the data from Henry's .mat file:
%file_gps5 = fullfile( DATADIRGPS, 'gpsGG.mat' );
% use GERD:
%src='GERD';
% src= stat;
% 
% file_gps_auto = fullfile( DATADIRGPS, 'gerd10-11.mat' );
% 
% temp=load( file_gps5 );
% 
% DATA=temp.gerd;
% 
% clear temp

file_gps_auto = fullfile( DATADIRGPS, ['final_',stat,'_GPSa_',comp,'.txt']);

DATA = load(file_gps_auto);

%datadate = datenum( DATA(:,1), DATA(:,2), DATA(:,3) );
datadate= DATA(:,1);
% NB column 2 is N component
gps_data = DATA(:,2);
% Error Estimates
gps_err = DATA(:,3);

nobs = length(gps_data);

for ii = 1:nobs
%    datadate2 = ( datadate(ii) - DateStart ) + 1;
    datadate2 = ( datadate(ii) - DateStart ) + 2;    
    if datadate2 <= DateEnd
        gps_stat_comp( int32( datadate2 ) ) = gps_data(ii);
        gps_stat_err( int32( datadate2 ) ) = gps_err(ii);
    end
end

label=[stat,'_',comp];

gps_auto.(label) = timeseries( gps_stat_comp', datatimecell, 'name', [stat,' ',comp]);
gps_auto_err.(label) = timeseries( gps_stat_err', datatimecell, 'name', [stat,' e'] );

    end
end

cd( DATADIR );
save gps_auto_final_all gps_auto gps_auto_err;

% Return to home directory
cd( DIR_MVOPLOT );

clear all;

