function plot_line_v( xval, style )
%
% Simple function to add a vertical line to a plot
%
% Rod Stewart, 2011-04-14

y_limits = get( gca, 'YLim' );
x_vals = [ xval xval ];

hold on;
plot( x_vals, y_limits, style );

return