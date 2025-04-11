function datestr_ydoy = dateToDoy( sdate )
%
% Returns the string for yyyy.doy for any date string
%
% R.C. Stewart, 9-Apr-2020

[yyyy,mmmm,dddd] = datevec( sdate );

datimd = datetime( yyyy, mmmm, dddd );

datestr_ydoy = strcat( datestr( datimd, 10 ), ...
            '.', ...
            sprintf( '%03d', day( datimd, 'dayofyear' ) ) );
        