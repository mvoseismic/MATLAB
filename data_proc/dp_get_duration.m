function days = dp_get_duration( span_str )
%
% Turns a string like '24H' or '7w' or '1D' or '5Y'
% into a number of days
%
% Rod Stewart, 2010-01-26

[numb_str idx] = regexp( span_str, '\d{1,}', 'match', 'start' );
[hdwmy_str idx] = regexp( span_str, '[hHdDwWmMyY]', 'match', 'start' );
numb = str2num( char( numb_str ) );

switch char(hdwmy_str)
    case { 'h', 'H' }
        days = numb / 24.0;
    case { 'd', 'D' }
        days = numb;
    case { 'w', 'W' }
        days = numb * 7.0;
    case { 'm', 'M' }
        days = numb * 31.0;
    case { 'y', 'Y' }
        days = numb * 365.0;
end

return
