function wout = ws_rotate_3c( win, rotate_degrees )
%
% Takes a waveform structure and rotates the horizontals clockwise by degrees
% Assumes data is in 3C sets
%
% Rod Stewart, 2010-06-12
%

% Form rotation matrix
rot_rad = deg2rad( rotate_degrees );
R = [cos(rot_rad)  -sin(rot_rad) ; sin(rot_rad)  cos(rot_rad)];

nsta = length( win );

wout = win;

for ii = 1:3:nsta-2
    
    datae = get(win(ii),'data');
    datan = get(win(ii+1),'data');
    
    A = [datae';datan'];
    B = R*A;
    dataer = B(1,:)';
    datanr = B(2,:)';
    
    wout(ii) = set( wout(ii), 'data', dataer, 'channel', 'BHT' );
    wout(ii+1) = set( wout(ii+1), 'data', datanr, 'channel', 'BHR' );
    
end

return
