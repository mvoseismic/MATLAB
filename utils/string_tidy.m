function stringout = string_tidy( stringin )
%
% Tidies strings that are used in MATLAB graphics
%
% Rod Stewart, 2009-01-05

% Replace _ with space, otherwise you get subscripts after the _
stringout = regexprep( stringin, '_', ' ' );

% Add a space at the end as many strings seem to be trimmed unneccesarily.
stringout = sprintf( '%s ', stringout );

return