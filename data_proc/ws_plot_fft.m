function ws_plot_fft( w, timebase, stalabels, norm )
%
% Plots a bunch of WS files together along with their ffts
%
% Rod Stewart, 2010-01-28

stime_start = min( get(w, 'Start' ) );
npts = max( get( w, 'DATA_LENGTH' ) );
sps = max( get( w, 'FREQ' ) );    
stime_stop = stime_start + (npts-1)/(24.0*60.0*60.0*sps);

if norm
    w = ws_mean_norm(w);
end

%offsets = [];
%wc = ws_add_offset( w, offsets );
wc = w;

%{
subplot(1,2,1);

if strcmp( timebase, 'minutes' )
    plot(wc,'Xunit','minutes');
    tlong = (stime_stop - stime_start) * (24.0*60.0);
elseif strcmp( timebase, 'hours' )
    plot(wc,'Xunit','hours');
    tlong = (stime_stop - stime_start) * 24.0;
elseif strcmp( timebase, 'seconds' )
    plot(wc,'Xunit','seconds');
    tlong = (stime_stop - stime_start) * (24.0*60.0*60.0);
else
    plot(wc,'Xunit','seconds');
    tlong = (stime_stop - stime_start) * (24.0*60.0*60.0);
end
    
start = get( wc(1), 'START_STR' );
    
tit = sprintf( 'Start time %s', start );
title( tit );
    
nsta = length( wc );
    
ylim([-2*nsta+1 1]);
ylabel( '' );
set( gca, 'YTick', [] );
   
    
npts = max( get( wc, 'DATA_LENGTH' ) );
sps = max( get( wc, 'FREQ' ) );
        
xlim([0 tlong]);
    
nsta = length(wc);
    
xstring = 0.02 * tlong;
    
    switch stalabels
        case 1
            for ii = 1:nsta
        
                sta = get( wc(ii), 'STATION' );
                cha = get( wc(ii), 'COMPONENT' );
                stacha = sprintf( '%s %s', sta, cha );
    
                ystring = -2.0*(ii-1) + 0.5;
                text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
            end
        case 2
            for ii = 1:nsta
        
                
                stacha = datestr( get( wc(ii), 'start' ), 'mm/dd HH:MM' );
    
                ystring = -2.0*(ii-1) + 0.5;
                text(xstring,ystring,stacha,'BackgroundColor',[.7 .9 .7]);
            end
    end

subplot(1,2,2);
%}

ncha = length( w );

for ich = 1:ncha
    
    data = get( w(ich), 'data' );
    fs = get( w(ich), 'freq' );
    ndata = length( data );
    
    nfft = 2^nextpow2(ndata); 
    Y = fft(data,nfft)/ndata;
    f = fs/2*linspace(0,1,nfft/2+1);

    ampl = 2*abs(Y(1:nfft/2+1));
    ampl = ampl / (100^ich);
    
    loglog(f,ampl);
    hold on;
    
end

title( 'Single-sided frequency spectrum' );
xlabel( 'Frequency (Hz)' );
ylim( [0.1 100.0] );


return