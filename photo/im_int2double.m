function im_out = im_int2double( im_in )
%
% Converts an integer image file to a real one
%
% Rod Stewart, 2011-12-12

m_script = 'im_int2double';

im_out = double( im_in );

switch class( im_in )
    case 'uint16'
        im_out = im_out / 65535.0;
    case 'uint8';
        im_out = im_out / 255.0;
    otherwise     
        m_progress( m_script, 'E', 'Image not in uint8 or uint16 format' );
end

return

