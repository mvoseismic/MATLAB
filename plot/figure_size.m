function figure_size( type, pixels )
%
% Sets size of figure on screen so that it is paper shaped
% 
% type can be "letter_landscape", "letter_portrait", "a4_landscape", 
% "a4_portrait" or "square".
%
% pixels overwrites the size of the longest axis
%
%
% Rod Stewart, MVO 2017-07-13

if nargin == 1
    pixels = 0;
end

switch type
    case 'p'
        type = 'a4_portrait';
    case 'l'
        type = 'a4_landscape';
    case 's'
        type = 'square';
    case 'w'
        type = 'wide';
    case 'e'
        type = 'extrawide';
end

if desktop('-inuse')
    monitor_pos = get(0, 'MonitorPositions' );
    screen = monitor_pos(1,3:4);
    screen_start = monitor_pos(1,1:2);
else
    screen = [6400 2160];
    screen_start = [1 1];
end

trim = 0.95;

if contains( type, 'letter', 'IgnoreCase', true )
    fig_aspect_ratio = 11.0/8.5;
elseif contains( type, 'a4', 'IgnoreCase', true )
    fig_aspect_ratio = 297/210;
elseif strcmp( type, 'wide' )
    fig_aspect_ratio = 16/9;
elseif strcmp( type, 'extrawide' )
    fig_aspect_ratio = 32/9;
elseif strcmp( type, 'special' )
    fig_aspect_ratio = 3/2;
elseif strcmp( type, 'supertall' )
    fig_aspect_ratio = 4.0;
else
    fig_aspect_ratio = 1.0;
end


fig_left = screen_start(1) + int32( screen(1) * (1.0-trim)/2.0 );
fig_bottom = screen_start(2) + int32( screen(2) * (1.0-trim)/2.0 );
screen = trim * screen;

if contains( type, 'landscape', 'IgnoreCase', true )
    fig_width = screen(1);
    fig_height = screen(1) / fig_aspect_ratio;
    if (fig_height > screen(2) )
        fig_height = screen(2);
        fig_width = fig_height * fig_aspect_ratio;
    end
elseif contains( type, 'portrait', 'IgnoreCase', true )
    fig_height = screen(2) ;
    fig_width = screen(2) / fig_aspect_ratio;
elseif strcmp( type, 'special' )
    fig_width = screen(1) ;
    fig_height = screen(1) / fig_aspect_ratio;
elseif strcmp( type, 'wide' )
    fig_width = screen(1);
    fig_height = screen(1) / fig_aspect_ratio;
elseif strcmp( type, 'extrawide' )
    fig_width = screen(1) ;
    fig_height = screen(1) / fig_aspect_ratio;
elseif strcmp( type, 'supertall' )
    fig_height = screen(2) ;
    fig_width = screen(2) / fig_aspect_ratio;
else
    fig_height = screen(2) ;
    fig_width = screen(2) / fig_aspect_ratio;
end

if pixels > 0             
    maxSide = max( fig_width, fig_height );
    multSide = double(pixels) / maxSide;
    fig_height = fig_height * multSide;
    fig_width = fig_width * multSide;
end

set( gcf, 'OuterPosition', [fig_left fig_bottom fig_width fig_height] );