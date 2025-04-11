function hypoStats( setup, Hypo )
%
% Gives statistics for Hypo structure
%
% R.C. Stewart, 7-Jan-2019

if  nargin == 0
    setup = setupGlobals();
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypo.mat' );
    load( data_file );
end

if nargin == 1
    data_file = fullfile( setup.DirMegaplotData, 'fetchedHypo.mat' );
    load( data_file );
end

out_file = 'hypoStats.out';
ouf = fopen( out_file, 'w' );
  
fprintf( 1, "==== hypoStats\n\n" );
fprintf( ouf, "hypoStats: %s\n\n", datestr(now) );

fprintf( 1, "total events:              %6d\n", length( Hypo ) );
fprintf( ouf, "total events:              %6d\n", length( Hypo ) );

for itype = 1:4
    
    switch itype
        case 1
            type = 'T ';
        case 2
            type = 'R ';
        case 3
            type = 'L ';
        case 4
            type = 'LV';
    end
    
    id = strcmp( {Hypo.type}, type );
    fprintf( 1, "total %2s events:           %6d\n", type, sum(id) );
    fprintf( ouf, "total %2s events:           %6d\n", type, sum(id) );
    
end
    
for ivtype = 1:9
    
    switch ivtype
        case 1
            idv = 't';
            vtype = 'VT';
        case 2
            idv = 'h';
            vtype = 'hybrid';
        case 3
            idv = 'l';
            vtype = 'LP';
        case 4
            idv = 'e';
            vtype = 'LP/rockfall';
        case 5
            idv = 'r';
            vtype = 'rockfall';
        case 6
            idv = 'x';
            vtype = 'explosion';
        case 7
            idv = 's';
            vtype = 'swarm';
        case 8
            idv = 'n';
            vtype = 'noise';
        case 9
            idv = 'm';
            vtype = 'monochromatic';
    end
    
    id = strcmp( {Hypo.volctype}, idv );
    
    fprintf( 1, "total LV %s events:         %6d   (%s)\n", idv, sum(id), vtype );      
    fprintf( ouf, "total LV %s events:         %6d   (%s)\n", idv, sum(id), vtype );      
    
end

fprintf( 1, "total located events:      %6d\n", sum( [Hypo.located] ) );
fprintf( ouf, "total located events:      %6d\n", sum( [Hypo.located] ) );
fprintf( 1, "total events in strings:   %6d\n\n", sum( [Hypo.isin_string] ) );
fprintf( ouf, "total events in strings:   %6d\n\n", sum( [Hypo.isin_string] ) );

fprintf( 1, "total events:              %6d\n", length( Hypo ) );
fprintf( ouf, "total events:              %6d\n", length( Hypo ) );
fprintf( 1, '%10s %17s %17s %17s %17s\n', 'par', 'mean', 'max', 'min', 'nNan' );
fprintf( ouf, '%10s %17s %17s %17s %17s\n', 'par', 'mean', 'max', 'min', 'nNan' );

for ipar = 1:16
    
    switch ipar
        case 1
            par = 'otime';
            vals = [Hypo.otime];
        case 2
            par = 'lat';
            vals = [Hypo.lat];
        case 3
            par = 'lon';
            vals = [Hypo.lon];
        case 4
            par = 'dep';
            vals = [Hypo.dep];
        case 5
            par = 'rms';
            vals = [Hypo.rms];
        case 6
            par = 'gap';
            vals = [Hypo.gap];
        case 7
            par = 'err_ot';
            vals = [Hypo.err_ot];
        case 8
            par = 'err_lat';
            vals = [Hypo.err_lat];
        case 9            
            par = 'err_lon';
            vals = [Hypo.err_lon];
        case 10
            par = 'err_dep';
            vals = [Hypo.err_dep];
        case 11
            par = 'cov_xy';
            vals = [Hypo.cov_xy];
        case 12
            par = 'cov_xz';
            vals = [Hypo.cov_xz];
        case 13
            par = 'cov_yz';
            vals = [Hypo.cov_yz];
        case 14
            par = 'datim';
            vals = [Hypo.datim];
        case 15
            par = 'nsta';
            vals = [Hypo.nsta];
        case 16
            par = 'mag';
            vals = [Hypo.mag];
    end
    
    fprintf( 1, '%10s %17.5f %17.5f %17.5f %17d\n', ...
        par, nanmean(vals),  nanmax(vals), nanmin(vals), sum( isnan( vals ) ) );
    
    fprintf( ouf, '%10s %17.5f %17.5f %17.5f %17d\n', ...
        par, nanmean(vals),  nanmax(vals), nanmin(vals), sum( isnan( vals ) ) );
    
end

fprintf( 1, "\n" );
fprintf( ouf, "\n" );

    
for ipar = 1:3
    
    switch ipar
        case 1
            par = 'loc_agency';
            vals = {Hypo.loc_agency};
        case 2
            par = 'mag_type';
            vals = {Hypo.mag_type};
        case 3
            par = 'mag_agency';
            vals = {Hypo.mag_agency};
    end
    
    [uc, ~, idc] = unique( vals ) ;
    counts = accumarray( idc, ones(size(idc)) ) ;
    
    fprintf( 1, 'par: %10s      unique values: %5d\n', par, length( uc ) );
    fprintf( ouf, 'par: %10s      unique values: %5\n', par, length( uc ) );
    
    for iun = 1: length(uc)
        fprintf( 1, '%3s  %10d\n', string( uc(iun) ), counts(iun) );
        fprintf( ouf, '%3s  %10d\n', string( uc(iun) ), counts(iun) );
    end
        
end

fclose( ouf );

figure;

for ihist = 1:6
    
    switch ihist
        
        case 1
            vals = [Hypo.err_ot];
            ptitle = string_tidy( 'err_ot' );
        case 2
            vals = [Hypo.err_lat];
            ptitle = string_tidy( 'err_lat' );
        case 3
            vals = [Hypo.err_lon];
            ptitle = string_tidy( 'err_lon' );
        case 4
            vals = [Hypo.err_dep];
            ptitle = string_tidy( 'err_dep' );
        case 5
            vals = [Hypo.rms];
            ptitle = 'rms';
        case 6
            vals = [Hypo.nsta];
            ptitle = 'nsta';
    end
    
    subplot(2,3,ihist);
    
    histogram( vals );
    title( ptitle );
    
end

figure;

vals = [Hypo.mag];
histogram( vals );
title( 'magnitude' );

    
    
    
            
            
        
