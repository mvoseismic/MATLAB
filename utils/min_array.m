function minval = min_array( A )
%
% Returns minimum value in a multi-dimensional array
%
% Rod Stewart, SRC. 2010-11-22

minval = min( reshape(A,[],1) );

return