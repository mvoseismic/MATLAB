function fetchRsamDaily( setup, ouf )
% 
% Fetches RSAM data, calculates daily medians and stores in file
%
% R.C. Stewart 15-Nov-2023

setup = setupGlobals();

yearBeg = 2004;
datimEnd = now;
datimEndVec = datevec( datimEnd );
yearEnd = datimEndVec(1);

stachas = [ "MBLG_EHZ", "MBLG_HHZ", "MSS1_SHZ" ];

fileRsamDaily = fullfile( setup.DirMegaplotData, 'fetchedRsamDaily.mat' );

minutesInDay = 24*60;

datimRsamDaily = [];
dataRsamDaily = [];

for istacha = 1:length( stachas )


    dataRsamDailySta = [];

    for year = yearBeg:yearEnd

        datim1 = datenum( year, 1, 1, 0, 0, 0);
        datim2 = datenum( year+1, 1, 1, 0, 0, 0) - 1;
        datimRsamDailyYear = datim1:datim2;
        datimRsamDailyYear = datimRsamDailyYear + 0.5;

        fileRsam = sprintf( "%s/%4d_rsam_%s_60sec.dat", ...
            setup.DirRsam, year, stachas(istacha) );

        if isfile(fileRsam)

            [dataRsam1,~] = readRsamFile( fileRsam );

            dim2 = size( dataRsam1, 1 ) / minutesInDay;
            dim1 = size( dataRsam1, 1 ) / dim2;
            dataRsamByDay = reshape( dataRsam1', dim1, dim2 );

            dataRsamDailyYear = median( dataRsamByDay, "omitmissing" );

            dataRsamDailySta = [ dataRsamDailySta dataRsamDailyYear ];

        else
            fprintf( "Does not exist: %s\n", fileRsam );
            dataRsamDailySta = NaN( size( datimRsamDailyYear ) );
        end

        if istacha == 1
            datimRsamDaily = [ datimRsamDaily datimRsamDailyYear ];
        end
    end

    dataRsamDaily(istacha,:) = dataRsamDailySta;

end

save( fileRsamDaily, 'stachas', 'datimRsamDaily', 'dataRsamDaily' );