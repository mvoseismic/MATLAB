function plot_err_xy( x, y, errx, erry, style )
%
% Simple function to add X and Y error bars to a plot.
%
% Rod Stewart, 2010-06-28

for ii = 1:length(y)
    xpt = x(ii);
    ypt = y(ii);
    xpt1 = x(ii) - errx(ii);
    xpt2 = x(ii) + errx(ii);
    ypt1 = y(ii) - erry(ii);
    ypt2 = y(ii) + erry(ii);
    xx = [xpt xpt];
    yy = [ypt ypt];
    x12 = [xpt1 xpt2];
    y12 = [ypt1 ypt2];
    plot( xx, y12, style );
    plot( x12, yy, style );
end

return