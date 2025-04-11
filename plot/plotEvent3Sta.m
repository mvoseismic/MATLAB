% Plots an event in different ways for three nearest stations
%
% Assumes miniseed files in current directory created using createMseed.pl
% No other files allowed in this directory
%
% R.C. Stewart, 29-Nov-2021

dirDataMseed = '.';


% Get miniSEED files
filesMseed = dir( dirDataMseed );
%filesMseed = filesMseed(~ismember({filesMseed.name},{'.','..'}));
filesMseed = dir( strcat( dirDataMseed, '/', '*Z' ) );
nfiles = length( filesMseed );
if nfiles == 0
    fprintf( "No data files\n" );
    return;
end
nfiles = length( filesMseed );
%for ifile = 1:nfiles
 %   fprintf( '%4d %s\n', ifile, filesMseed(ifile).name );
%end

timeEvent = substr( filesMseed(1).name, 1, 15 );
secondsPrior = str2num( substr( filesMseed(1).name, 17, 3 ) );
secondsDuration = str2num( substr( filesMseed(1).name, 21, 4 ) );



% Plot 3 verticals
figure;
figure_size( 's' );

for ifile = 1:nfiles

    % Get filename
    fms = filesMseed( ifile );
    fileMseedName = fms(1).name;

    % Extract sta and cha from filename
    chunks = split( fileMseedName, '.' );
    chunkettes = split( string(chunks(2)), '_' );
    sta = chunkettes(1);
    cha = strcat( chunkettes(4), chunkettes(5) ); 
    cha = erase( cha, digitsPattern );

    % Read file as signal structure
    fileMseed = fullfile( dirDataMseed, fileMseedName );
    signalStruct = readReadMSEEDFast( fileMseed );
    signalStruct = sigFiltHp( signalStruct, 0.5 );

    % Extract data for plotting
    dataSeismogram = signalStruct.data;
    dataSeismogram = dataSeismogram - nanmean_rod( dataSeismogram );
    dataSeismogramMax = max( abs( dataSeismogram ) );
    tdataSeismogram = 1:signalStruct.numberOfSamples;
    tdataSeismogram = tdataSeismogram/signalStruct.sampleRate;
    tdataSeismogram = tdataSeismogram - secondsPrior;
    %tdataSeismogram = tdataSeismogram / 60.0;
    
    % Calculate signal envelope
    signalStructEnv = sigEnvelope( signalStruct );
    dataEnvelope = signalStructEnv.data;
    
    % Calculate signal envelopes for horizontals
    if sta ~= 'MSS1'
        
        fileH1 = strrep( fileMseed, '1Z', '01' );
        signalStruct = readReadMSEEDFast( fileH1 );
        signalStruct = sigFiltHp( signalStruct, 0.5 );
        signalStructEnv = sigEnvelope( signalStruct );
        envH1 = signalStructEnv.data;
        
        fileH2 = strrep( fileMseed, '1Z', '02' );
        signalStruct = readReadMSEEDFast( fileH2 );
        signalStruct = sigFiltHp( signalStruct, 0.5 );
        signalStructEnv = sigEnvelope( signalStruct );
        envH2 = signalStructEnv.data;
        
        envRat = dataEnvelope ./ sqrt( envH1.^2 + envH2.^2 );
        envRat = log10( nan_rmean( envRat, 21 ) );
        
    end
    
    % Plot limits
    xLimits = [-10 60];
    yLimits = [ -1*dataSeismogramMax dataSeismogramMax ];

    
    % Plot seismogram
    subplot(3,3,(3*ifile-2));
    %posn = posn_subplot(1,:);
    %subplot('position',posn);
    plot( tdataSeismogram, dataSeismogram, 'b-' );
    xlim( xLimits );
    ylim( yLimits );
    set( gca, 'XGrid', 'on' );
    set(gca,'Yticklabel',[]);
    xlabel( 'Time (seconds)' );
    title( strcat( sta, '.', cha ) );
 
    
    % Plot spectrogram
    subplot(3,3,(3*ifile-1));
    nfft=512;
    noverlap=round(nfft*0.75);
    window=hanning(nfft);
    spectrogram( dataSeismogram, window, noverlap, nfft, signalStruct.sampleRate, 'yaxis' );
    set( gca, 'YScale', 'log', 'box', 'on' );
    ylim( [1.0 100.0] );
    colormap parula;
    colorbar off;
    xlim( [20/60 80/60] );
    % Fix Y tick labels
    yt = get(gca,'ytick');
    for j=1:length(yt)
        YTL{1,j} = num2str(yt(j),'%d');
    end
    yticklabels(YTL);
    xlabel( 'Time (minutes)' );
    % Fix X tick labels
    %xt = get(gca,'xtick');
    %for j=1:length(xt)
    %    XTL{1,j} = num2str(xt(j)-1,'%d');
    %end
    %xticklabels(XTL);
    title( 'spectrogram' );
    
    
    % Plot envelope
    subplot(3,3,3*ifile);
    if sta ~= 'MSS1'
        yyaxis left;
    end
    area( tdataSeismogram, dataEnvelope, 'FaceColor', [.5 .5 .5], 'EdgeColor', [.5 .5 .5] );
    set(gca,'ycolor','k') 
    set(gca,'Yticklabel',[]);
    set( gca, 'XGrid', 'on' );
    xlim( xLimits );
    ylim( [0 max(dataEnvelope)] );
    xlabel( 'Time (seconds)' );
    if sta ~= 'MSS1'
        yyaxis right;
        plot( tdataSeismogram, envRat, 'r-', 'LineWidth', 1 );
        ylim( [-1 1] );
    end
    if sta == 'MSS1'
        title( 'envelope' );
    else
        title( 'envelope \color{red} log V/H' );
    end
end



plotOverTitle( timeEvent );

% Save figure
fileSave = sprintf( 'fig-%s-3sta.png', timeEvent );
saveas( gcf, fileSave );
%close;
