function isit = isleap( iyear )
%
% Tests if year is leap year
%
% Rod Stewart, SRC/UWI 2011-12-02

ndays = datenum( [iyear+1 1 1 0 0 0] ) - datenum( [iyear 1 1 0 0 0] );

if ndays == 366
    isit = true;
else
    isit = false;
end

return