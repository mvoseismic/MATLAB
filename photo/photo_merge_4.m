% photo_merge_?
%
% Scripts designed to merge series of images in Nikon NEF format
%
% photo_merge_4
%
% Does merging, of various types
%
% Rod Stewart, 2012-01-13

files = dir( 'image_R_*' );
nfiles = length( files );

if nfiles <= 0
    m_progress( mfilename, 'F', 'No or not enough image files' );
end

file_image = files(1).name;
fprintf( 'Image file: %s\n', file_image );
load( file_image );

S = uint8( R );
file_save = '01_orig_rgb';
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );

[n1 n2 n3] = size( R );
Rsize = size( R );
npix = n1 * n2;
fprintf( 'Number of pixels: %d\n', npix );

Rmean = nan( [npix n3] );
Rmedian = nan( [npix n3] );
Rmode = nan( [npix n3] );
Rmax = nan( [npix n3] );
Rmin = nan( [npix n3] );
Rextreme = nan( [npix n3] );

files = dir( 'temp_*' );
nfiles = length( files );

if nfiles <= 0
    m_progress( mfilename, 'F', 'No or not enough temp files' );
end

ibeg = 1;
for ifile = 1:nfiles
    file_temp = files(ifile).name;
    fprintf( 'Temp file: %s\n', file_temp );
    load( file_temp );
    
    %RcAll = RcAll( ~isnan( RcAll ) );
    [nc1 nc2 nc3] = size( RcAll );

    iend = ibeg + nc1 - 1;
    if iend > npix
        iend = npix;
    end
    
    R1tmp = reshape( RcAll, [], nc3 );
    R1tmp = R1tmp';
    
    R1mean = mean( R1tmp );   
    R1calc = R1mean';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rmean(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    R1calc = median( R1tmp );   
    R1calc = R1calc';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rmedian(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    R1calc = mode( R1tmp );   
    R1calc = R1calc';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rmode(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    R1max = max( R1tmp );   
    R1calc = R1max';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rmax(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    R1min = min( R1tmp );   
    R1calc = R1min';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rmin(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    id = (R1max-R1mean) >= (R1mean-R1min);
    R1extreme = nan( size(R1mean) );
    R1extreme(id) = R1max(id);
    R1extreme(~id) = R1min(~id);
    R1calc = R1extreme';
    R3tmp = reshape( R1calc, [], 3 ); 
    Rextreme(ibeg:iend,:) = R3tmp(1:iend-ibeg+1,:);
    
    ibeg = iend + 1;
    
end

Rmean = reshape( Rmean, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rmean );
file_save = '02_mean_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Mean done\n' );

Rmedian = reshape( Rmedian, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rmedian );
file_save = '03_median_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Median done\n' );
    
Rmode = reshape( Rmode, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rmode );
file_save = '04_mode_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Mode done\n' );
    
Rmax = reshape( Rmax, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rmax );
file_save = '05_max_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Max done\n' );
    
Rmin = reshape( Rmin, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rmin );
file_save = '06_min_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Min done\n' );
    
Rextreme = reshape( Rextreme, Rsize );
R = R * 65535.0 / 255.0;
S = uint8( Rextreme );
file_save = '07_extreme_rgb';
save( file_save, 'R' );
imwrite( S, sprintf( '%s.jpg', file_save ), 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 90 );
imwrite( R, sprintf( '%s.tiff', file_save), 'tiff', ...
        'Compression', 'lzw' );
fprintf( 'Extreme done\n' );
    

clear variables;