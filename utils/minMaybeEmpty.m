function mindata = minMaybeEmpty( data )
%
% Returns min of 1-D or 2-D data array.
% Returns NaN if array is empty
%
% R.C. Stewart 2024-11-14

    if isempty( data )
        mindata = NaN;
    else
        mindata = min( min( data ) );
    end

end