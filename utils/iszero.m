function out = iszero( in )
%
% Returns indexes of zero elements of an array
%
% Rod Stewart, 2009-06-12

in = 1./in;
out = isinf( in );

return