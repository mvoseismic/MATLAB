function fetchVTstrings( setup, ouf )
% 
% Fetches VT string data
%
% R.C. Stewart 7-Jan-2020


VT = read_string_spreadsheet( setup );

vtstring_ids = VT.Id;
vtstring_datim_begs = datenum( VT.DatimFirst );
vtstring_durs = VT.Duration;
vtstring_nev_seisans = VT.NumSeisan;
vtstring_nev_locateds = VT.NumLocated;
vtstring_nev_totals = VT.NumTotal;
vtstring_max_MLs = VT.MaxMl;
vtstring_datim_ends = datenum( VT.DatimLast );
vtstring_whats = VT.What;
vtstring_activitys = VT.SurfaceActivity;
vtstring_repeatings = VT.RepeatingEvents;
vtstring_puritys = VT.Purity;
vtstring_MSS1 = VT.MSS1;
vtstring_first = VT.StaFirst;
vtstring_form = VT.Form;
vtstring_comment = VT.Comment;

%isVTstring = strcmp( vtstring_whats, 'VT string' );

fprintf( 1, "==== fetchVTstrings\n" );
fprintf( 1, "VT strings read:        %6d\n", length( vtstring_ids ) );
if nargin == 2
    fprintf( ouf, "==== fetchVTstrings\n" );
    fprintf( ouf, "VT strings read:        %6d\n", length( vtstring_ids ) );
    fprintf( ouf, "\n" );
end

% Save to file
data_file = fullfile( setup.DirMegaplotData, 'fetchedVTstrings.mat' );
save( data_file, ...
    'vtstring_ids', ...
    'vtstring_datim_begs', ...
    'vtstring_durs', ...
    'vtstring_nev_seisans', ...
    'vtstring_nev_locateds', ...
    'vtstring_nev_totals', ...
    'vtstring_max_MLs', ...
    'vtstring_datim_ends', ...
    'vtstring_whats', ...
    'vtstring_activitys', ...
    'vtstring_repeatings', ...
    'vtstring_puritys', ...
    'vtstring_MSS1', ...
    'vtstring_first', ...
    'vtstring_form', ...
    'vtstring_comment' );
