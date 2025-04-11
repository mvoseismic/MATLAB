function HypoGot = getHypo( setup )
%
% Loads Hypo data and returns it in a structure
%
% R.C. Stewart, 8-Jan-2020

% Load file
data_file = fullfile( setup.DirMegaplotData, 'fetchedHypoSelect.mat' );
load( data_file );

HypoGot = Hypo;