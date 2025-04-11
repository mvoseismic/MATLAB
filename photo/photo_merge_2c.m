% photo_merge_?
%
% Scripts designed to merge series of images in Nikon NEF format
%
% photo_merge_2c
%
% Reads each image file in and crops them all to the first image
%
% Rod Stewart, 2011-12-12

files = dir( 'image_R_*' );

nfiles = length( files );

if nfiles <= 1
    m_progress( mfilename, 'F', 'No or not enough image files' );
end

file_image = files(1).name;
s = regexp(file_image, '_', 'split');
file_save = sprintf( '%s_R_%s', char(s(1)), char(s(3)) );

load( file_image );

fprintf( 'Double click to finish\n' );
[Rcrop rect] = imcrop( R );
close( gcf );
R = Rcrop;

save( file_save, 'R' );

for ifile = 2:nfiles
    
    file_image = files(ifile).name;
    s = regexp(file_image, '_', 'split');
    file_save = sprintf( '%s_R_%s', char(s(1)), char(s(3)) );
    
    fprintf( 'Image file: %s\n', file_image );
    
    load( file_image );
    
    Rcrop = imcrop( R, rect );
    R = Rcrop;

    save( file_save, 'R' );
    
end

clear variables;