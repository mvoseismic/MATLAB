function [dataRsam1,datimRsam1] = readRsamFiles( year, sta, cha )
%
% Reads RSAM data from a day files created by mseed2rsam
%
% R.C Stewart, 2023-03-13

dirMseedRsam = '~/STUFF/data/MVO/Seismic_Data/rsamMseed';

filesAll = dir( dirMseedRsam );
names = {filesAll.name};
ind = cellfun(@any, regexp(names, strcat( sprintf('%4d', year), '.*rsamMseed_', sta, '_', cha, '.*\.txt' ) ) );
filesMseedRsam = names(ind);

for ifile = 1:length( filesMseedRsam )

    fileMseedRsam = char( filesMseedRsam{ifile} );
    fileYear  = substr( fileMseedRsam, 0, 4 );
    fileMonth = substr( fileMseedRsam, 5, 2 );
    fileDay   = substr( fileMseedRsam, 7, 2 );
    fileMseedRsam = fullfile( dirMseedRsam, fileMseedRsam );
    A = readmatrix( fileMseedRsam );
    minutesOfDay = A(:,1);
    rsamMseed = A(:,2);

    datim = (minutesOfDay/1440) + datenum( str2num(fileYear), str2num(fileMonth), str2num(fileDay), 0, 0, 0 );

    switch ifile
        case 1
            dataRsam1 = rsamMseed;
            datimRsam1 = datim;
        otherwise
            dataRsam1 = [ dataRsam1; rsamMseed ];
            datimRsam1 = [ datimRsam1; datim ];
    end


end

