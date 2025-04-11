function A = imread_dcraw( file_image )
%
% Uses dcraw to read a raw camera image file
%
% Rod Stewart, 2011-12-12

global global_OS

m_script = 'imread_dcraw';

% dcraw executable
switch global_OS
    case 'Darwin'
        dcraw_exe = '/opt/local/bin/dcraw';
    case 'Linux'
        dcraw_exe = '/usr/bin/dcraw';
    otherwise
        m_message = sprintf( 'Bad OS: %s', global_OS );
        m_progress( m_script, 'Fatal', m_message );
end

% dcraw options
%   -w  Use camera white balance
%   -4  Write 16-bit linear PPM
%   -v  verbose
%   -T  tiff
dcraw_opt = '-w -v';                 

% create ppm file
command = sprintf( '%s %s %s', dcraw_exe, dcraw_opt, file_image );
result = system( command );
fprintf( '%s\n', char(result) );

% get name of ppm file
s = regexp(file_image, '\.', 'split');
file_ppm = sprintf('%s.ppm', char(s(1)) );

% read ppm file using imread
A = imread( file_ppm, 'ppm' );

% delete ppm file
delete( file_ppm );

return
