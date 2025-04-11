function rsam = rsam_get_save( datim_beg, datim_end, save_file, source, tsamp )
%
% Gets RSAM data for a number of stations for a time period
% and puts the data into a MATLAB time series object
%
% Updated to deal with MVO BOB and VME data, including 10-second data
%
% This one has a save_file, so you can save the data for later
%
% Rod Stewart, 2011-12-02


% Deal with optional fourth and fifth arguments
if nargin < 5
    tsamp = 1;
end
if nargin < 4
    source = 'earthworm';
end

rsam = rsam_get( datim_beg, datim_end, source, tsamp );

save( save_file, 'rsam' );

return