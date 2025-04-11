function im_out = im_normalised_rgb( im_in )
%
% Creates a normalised RGB image
% Based on a some stuff in MATLAB forums
%
% Rod Stewart 2009-07-02

im_red = im_in(:,1);
im_grn = im_in(:,2);
im_blu = im_in(:,3);

im_norm = im_in;

[xs,ys] = size( im_red );

for ii = 1:xs
    for jj = 1:ys
        red = double( im_red(ii,jj) );
        grn = double( im_grn(ii,jj) );
        blu = double( im_blu(ii,jj) );
        
        red_norm = red/sqrt(red^2 + grn^2 + blu^2);
        grn_norm = grn/sqrt(red^2 + grn^2 + blu^2);
        blu_norm = blu/sqrt(red^2 + grn^2 + blu^2);
        
        im_norm(ii,jj,1) = uint8(red_norm);
        im_norm(ii,jj,2) = uint8(grn_norm);
        im_norm(ii,jj,3) = uint8(blu_norm);
    end
end

im_out = im_norm;

return
        

     
