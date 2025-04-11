% photo_merge_?
%
% Scripts designed to merge series of images in Nikon NEF format
%
% photo_merge_3
%
% Creates a set of tmp files that will then be used for merging
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

[n1 n2 n3] = size( R );
npix = n1 * n2;
fprintf( 'Number of pixels: %d\n', npix );

npix_chunk = 200000;
n_chunk = ceil( npix/npix_chunk );
fprintf( 'Dividing into %d chunks\n', n_chunk );

for ichunk = 1:n_chunk
    
    file_save = sprintf( 'temp_%06d', ichunk );
    fprintf( 'Creating %s             ', file_save );
    
    ibeg = (ichunk-1) * npix_chunk;
    iend = ibeg + npix_chunk;
    ibeg = ibeg + 1;
    
    if iend > npix
        iend = npix;
    end
    
    fprintf( 'ibeg: %10d  iend: %10d\n', ibeg, iend );
    
    RcAll = NaN( [ npix_chunk 3 nfiles] );

    for ifile = 1:nfiles
       
        file_image = files(ifile).name;
        %fprintf( 'Image file: %s\n', file_image );
        load( file_image );
        R2 = reshape( R, [], 3 );
        
        RcAll(1:iend-ibeg+1,:,ifile) = R2(ibeg:iend,:);

    end
    
    save( file_save, 'RcAll' );
end

clear variables;