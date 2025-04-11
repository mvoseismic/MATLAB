function datestr_ymd = dateToTrad( sdate )
%
% Returns the string for date for a yyy.doy string
%
% R.C. Stewart, 9-Apr-2020

sdates = split( sdate, '.' );

yyyy = str2double( sdates(1) );
doy = str2double( sdates(2) );

datim1 = datenum( yyyy, 1, 1 );
datim2 = datim1 + doy - 1;

datestr_ymd = datestr( datim2, 29 );
        