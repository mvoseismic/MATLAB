function maxdata = maxMaybeEmpty( data )
%
% Returns max of 1-D or 2-D data array.
% Returns NaN if array is empty
%
% R.C. Stewart 2024-11-14

    if isempty( data )
        maxdata = NaN;
    else
        maxdata = max( max( data ) );
    end

end