function Z = addnan( X, Y )
%
% Adds two matrices X and Y allowing for NaNs to be zero when required
%
% Rod Stewart, 2008-09-22
%

[nx, ny] = size( X );

nc = nx * ny;

for ii = 1: nc
    if isnan(X(ii)) && isnan(Y(ii))
        Z(ii) = NaN;
    elseif isnan(X(ii))
        Z(ii) = Y(ii);
    elseif isnan(Y(ii))
        Z(ii) = X(ii);
    else
        Z(ii) = X(ii)+Y(ii);
    end
end