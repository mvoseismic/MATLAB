function plot_stack( X, Y )
%
% Plots a stack section of data
%
% Assumes data has been normalised already
%
% Rod Stewart, SRC. 2010-12-15

[npts,nstack] = size( Y );

for ii = 1:nstack
    Y(:,ii) = Y(:,ii) + nstack - ii + 1;
end

plot( X, Y, 'b-' );

return