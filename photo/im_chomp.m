function im_out = im_chomp( im_in, top, bum )
%
% Saturates an image to a small range
%
% Rod Stewart, 2009-07-04

im_out = im_in;

iOut = im_in >= top;
im_out(iOut) = top;

iOut = im_in <= bum;
im_out(iOut) = bum;


im_out = imadjust(im_out,stretchlim(im_out),[]);

return
