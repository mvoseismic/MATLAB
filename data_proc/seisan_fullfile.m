function ret = seisan_fullfile( file, dir_seisan )
%
% Given a Seisan file name, attempts to work out where to find it
%
% Rod Stewart, 2011-05-24

% Directory of Seisan WAV files
if dir_seisan
    % passed as argument
else
    % work it out
end

% Get year and month from file name
year = file(1:4);
mont = file(6:7);

ret = fullfile( dir_seisan, year, mont, file );

return;