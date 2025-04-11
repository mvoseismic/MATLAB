% photo_merge_?
%
% Scripts designed to merge series of images in Nikon NEF format
%
% photo_merge_2s
%
% Reads each image file in and aligns them all to the first image
%
% Rod Stewart, 2011-12-12

n_pixel_add = 50;

files = dir( 'image_R_*' );

nfiles = length( files );

if nfiles <= 1
    m_progress( mfilename, 'F', 'No or not enough image files' );
end

file_image = files(1).name;
s = regexp(file_image, '_', 'split');
file_save = sprintf( '%s_S_%s', char(s(1)), char(s(3)) );

load( file_image );

%save( file_save, 'R' );

% Convert to grayscale
Rref = rgb2gray( R );

% Stretch to increase contrast
stretch_limits = stretchlim( Rref );
Rref = imadjust( Rref, stretch_limits );

% Pick template limits
fprintf( 'Double click to finish\n' );
[Rtemplate rect] = imcrop( Rref );
close( gcf );
rect2 = rect;

% Add a margin to rect
rect2(1) = rect2(1) - n_pixel_add;
if rect2(1) < 0
    rect2(1) = 0;
end
rect2(2) = rect2(2) - n_pixel_add;
if rect2(2) < 0
    rect2(2) = 0;
end
rect2(3) = rect2(3) + 2 * n_pixel_add;
rect2(4) = rect2(4) + 2 * n_pixel_add;

x_offset = [0];
y_offset = [0];

for ifile = 2:nfiles
    
    file_image = files(ifile).name;
    s = regexp(file_image, '_', 'split');
%    file_save = sprintf( '%s_S_%s', char(s(1)), char(s(3)) );
    file_save = sprintf( '%s_R_%s', char(s(1)), char(s(3)) );
    
    fprintf( 'Image file: %s\n', file_image );
    
    load( file_image );
    
    % Convert to grayscale
    Rimg = rgb2gray( R );
    Rimg = imadjust( Rimg, stretch_limits );
    Rimg2 = imcrop( Rimg, rect2 );
    
    C = normxcorr2( Rtemplate, Rimg2 );
    [max_c, imax] = max(abs(C(:)));
    [ypeak, xpeak] = ind2sub(size(C),imax(1));
    corr_offset = [ (ypeak-size(Rtemplate,1)) (xpeak-size(Rtemplate,2)) ];
    rect_offset = [(rect2(1)-rect(1)) (rect2(2)-rect(2))];
    offset = corr_offset + rect_offset;
    offset = -1.0 * circshift( offset, 1 );
    fprintf( 'Max corr: %5.2f\n', max_c );
    fprintf( 'Offset: [ %d %d ]\n', offset );
    
    x_offset = [x_offset offset(1)];
    y_offset = [y_offset offset(2)];
    
    S = circshift( R, offset );
    R = S;
    save( file_save, 'R' );
    
end

save( 'offsets', 'x_offset', 'y_offset' );

clear variables;