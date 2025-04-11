% photo_merge_?
%
% Scripts designed to merge series of images in Nikon NEF format
%
% photo_merge_1
%
% Reads each file in and saves as a double RGB array
%
% Rod Stewart, 2011-12-12

redux = inputd( 'Shrink image by', 'r', 1.0 );

file_ext = 'NEF';
dir_search_string = sprintf( '*.%s', file_ext );

files = dir( dir_search_string );

nfiles = length( files );

for ifile = 1:nfiles
    
    file_photo = files(ifile).name;
    
    fprintf( 'Photo file: %s\n', file_photo );
    
    A = imread_dcraw( file_photo );
    
    if redux ~= 1.0
        A = imresize( A, redux );
    end
    
    R = A;
    
    file_save = sprintf( 'image_R_%06d', ifile );
    
    save( file_save, 'R' );
    
end

clear variables;