function rsam = rsam_get_seisan_counts( datim_beg, datim_end, tsamp )
%
% Gets the events counts from SEISAN database and returns them in an RSAM timeseries
%
% Rod Stewart, 2011-12-06

% Things needed
m_script = 'rsam_get_seisan_counts';

% Deal with optional third and fourth arguments
if nargin < 3
    tsamp = 1;
end

% file with pre-calculated counts
dir_counts = '/Users/stewart/projects/Montserrat/Event_Counts/from_select_outs';
file_counts = sprintf( 'rate_%dhr.mat', tsamp );

file_counts = fullfile( dir_counts, file_counts );

% Turns dates into numbers, rounding down to nearest hour
DatimBegVec = datevec( datim_beg );
DatimEndVec = datevec( datim_end );
    DatimBegVec(6) = 0;
    DatimEndVec(6) = 0;
    DatimBegVec(5) = 0;
    DatimEndVec(5) = 0;
DatimBeg = datenum( DatimBegVec );
DatimEnd = datenum( DatimEndVec );

% Read data from file
load( file_counts );

% Get indices of points we want
idw = (datim >= DatimBeg) & (datim<=DatimEnd);

datim_ts = datim(idw);

% Create time-series collection for rsam data 
rsam = tscollection( datim_ts );
rsam.TimeInfo.Units = 'days';

% Create timeserieses and add to collection
data_ts = all_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'all' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

data_ts = qua_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'qua' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

data_ts = vt_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'vt' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

data_ts = hy_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'hy' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

data_ts = lp_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'lp' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

data_ts = rf_per(idw);
data_ts = data_ts';
ts = timeseries( data_ts, datim_ts, 'name', 'rf' );
ts.TimeInfo.Units = 'days';
rsam = addts( rsam, ts );

return
