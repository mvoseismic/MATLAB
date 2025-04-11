function events = read_events_spreadsheet( setup )
% Reads Excel spreadsheet for events
% R.C. Stewart, 18-Mar-2021

data_file = 'SeismicityDiary.xlsx';
fileSeismicVtstrings = fullfile( setup.DirSeismicData, data_file );

w = warning ('off','all');
try
    EV = readtable( fileSeismicVtstrings, 'Sheet', 'Events' );
catch
    errID = 'read_string_spreadsheet:CantOpenFile';
    msg = 'Unable to open spreadsheet, maybe it is open already.';
    baseException = MException(errID,msg);
    throw( baseException );
end
warning(w);

evId = EV.ID;
evDatimStart = EV.DateTimeStart;
evWhat = EV.What;
evWhere = EV.Where;
evFirstSta = EV.FirstStation;

events = struct( 'Id', {evId}, ...
                    'What', {evWhat}, ...
                    'Where', {evWhere}, ...
                    'DatimStart', evDatimStart, ...
                    'FirstSta', {evFirstSta} );

