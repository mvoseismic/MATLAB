function im_out = im_rgb2gray( im_in )
%
% Creates grayscale image in a double array
%
% Rod Stewart, 2009-07-04

dim_im_out = size( rgb2gray( im_in ) );

im_out = double( zeros( dim_im_out ) );

im_red = double( im_in(:,:,1) );
im_grn = double( im_in(:,:,2) );
im_blu = double( im_in(:,:,3) );

im_out = 0.2989 * im_red + 0.5870 * im_grn + 0.1140 * im_blu;

return

