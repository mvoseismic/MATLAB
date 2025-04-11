function maxval = max_array( A )
%
% Returns maximum value in a multi-dimensional array
%
% Rod Stewart, SRC. 2010-11-22

maxval = max( reshape(A,[],1) );


return