% fetch_temps
%
% Fetches tempearture data for fumaroles
% 

DIR_MVOPLOT=pwd;
DATADIR = sprintf( '%s/%s', DIR_MVOPLOT, '/data/gas' );

% Directory with source files
SOURCEFILE = fullfile( DATADIR, 'SO2_traverse_data_from_TC_latest.csv' );

xls_data = csvread(SOURCEFILE);

cd( DATADIR ); 

DateStart = datenum( 2011, 01, 01, 0, 0, 0 );
 DateEnd = datenum( date ) ;
DateEndYear = str2num(datestr(date,'yyyy'));
days = DateEnd - DateStart + 1;
gas_Date = DateStart:DateEnd ;

% Create time series for each type full of NaNs
gas_SO2 = NaN( 1, days );
%gas_SO2_weekly = NaN( 1, days );

     
datadate = datenum(xls_data(:,1:3));
gas_dates = datadate;

    
% remove any spurious values, eg headers etc
datadate(iszero(datadate)) = NaN;
ind = ~isnan(datadate);
datadate = datadate(ind);
    
datadate = ( datadate - DateStart ) + 1;

SO2 = xls_data(:,4);
SO2 = SO2(ind);
ERR = xls_data(:,5);
ERR = ERR(ind);
SO2(iszero(SO2)) = NaN;
ERR(iszero(ERR)) = NaN;
          
gas_dates = gas_dates(ind);
gas_so2_trav = SO2;
gas_err = ERR;


save gas_so2_traverse gas_dates gas_so2_trav gas_err;

% Return to home directory
cd( DIR_MVOPLOT );

