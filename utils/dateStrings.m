function [ datestr_ymd, datestr_ydoy, datestr_dayname ] = dateStrings( datim )
%
% Returns two strings for a given date number
%
% R.C. Stewart, 6-Apr-2020

[yyyy,mmmm,dddd] = datevec( datim );

datimd = datetime( yyyy, mmmm, dddd );

datestr_ymd = datestr( datim, 26 );

datestr_ydoy = strcat( datestr( datim, 10 ), ...
            '-', ...
            sprintf( '%03d', day( datimd, 'dayofyear' ) ) );
        
datestr_dayname = string( day( datimd, 'name' ) );