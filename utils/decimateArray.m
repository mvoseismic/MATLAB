function Xdec = decimateArray( X, r )
%
% Decimates every row in a matrix X
%
% R.C. Stewart, 2024-01-19

[nch, ns] = size(X);

X( X == -Inf ) = 0.0;

ns_down = ceil(ns/r);
Xdec = zeros(nch, ns_down);

for i=1:nch
    Xdec(i, :) = decimate(X(i,:), r);
end

end