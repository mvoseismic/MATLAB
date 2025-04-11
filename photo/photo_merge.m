function photo_merge( dir_save, group_name, dir_photos, list_file, rawornot, how )
%
% Given a list of image files, reads them and creates a single image
%
% Rod Stewart, 2013-12-06

global VERBOSE

% Change directory for RAW files
if rawornot
    dir_photos = regexprep( dir_photos, 'JPG', 'NEF' );
end

if VERBOSE
    fprintf( 'directory: %s\n', dir_photos );
end

nfiles = 0;
fid = fopen( list_file );
tline = fgetl(fid);
while ischar(tline)
    nfiles = nfiles + 1;
    Cfiles{nfiles} = tline;
    tline = fgetl(fid);
end

if VERBOSE
    fprintf( '# files: %d\n', nfiles );
end


% Read first file to get info about photo size

pfile = char( Cfiles{1});
pfile = fullfile( dir_photos, pfile );
if VERBOSE
    fprintf( 'file: %s\n', pfile );
end

if rawornot
    A = imread_dcraw( pfile );
else
    A = imread( pfile );
end
[n1 n2 n3] = size( A );
Rsize = size( A );
npix = n1 * n2;
if VERBOSE
    fprintf( '# pixels: %d\n', npix );
end


R1 = reshape( A, 1, [] );
R = R1;

for ifile = 2:nfiles
    
    pfile = char( Cfiles{ifile});
    pfile = fullfile( dir_photos, pfile );
    
    if VERBOSE
        fprintf( 'file: %s\n', pfile );
    end
    
    if rawornot
        A = imread_dcraw( pfile );
    else
        A = imread( pfile );
    end
    R1 = reshape( A, 1, [] );
    R = [ R; R1 ];

end

switch how
    case 'mean'
        R1 = mean(R);
        file_save = sprintf( '%s_mean.jpg', group_name );
    case 'median'
        R1 = median(R);
        file_save = sprintf( '%s_median.jpg', group_name );
    case 'max'
        R1 = max(R);
        file_save = sprintf( '%s_max.jpg', group_name );
    case 'mode'
        R1 = max(R);
        file_save = sprintf( '%s_mode.jpg', group_name );
end

Rm = reshape( R1, Rsize );
A = uint8( Rm );
file_save = fullfile( dir_save, file_save );
imwrite( A, file_save, 'jpg', ...
        'Bitdepth', 8, ...
        'Mode', 'lossy', ...
        'Quality', 99 );

if VERBOSE
    fprintf( 'saved: %s\n', file_save );
end
    
