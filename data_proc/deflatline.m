function data_out = deflatline( data_in )
%
% Removes "flatlines" in seismic data
% These are lots of zeroes. So test for four conditions
% and if any of these are met we replace the 0 with a NaN
%
% data max = 0
% data min = 0
% %more than trig*npts zeroes
% three or more consecutive zeroes
%
% Rod Stewart, 2009-06-11
global VERBOSE

trig = 0.01;

npts = length( data_in );

data_max = nanmax( data_in );
data_min = nanmin( data_in );
data_zeroes = iszero( data_in );

if VERBOSE
    script_status( 'deflatline', 'npts', num2str(npts) );
    script_status( 'deflatline', 'data_max', num2str(data_max) );
    script_status( 'deflatline', 'data_min', num2str(data_min) );
end

deflat = 0;

if logical(data_max == 0) || logical(data_min == 0)
    deflat = 1;
    if VERBOSE
        script_status( 'deflatline', 'deflat 1', 'data_m?? ==0' );
    end


%else

%    nzero = sum( data_zeroes );

%    if VERBOSE
%        script_status( 'deflatline', 'nzero', num2str( nzero ) );
%    end
%    fzero = double(nzero) / double(npts);
%    if VERBOSE
%        script_status( 'deflatline', 'fzero', num2str( fzero ) );
%    end

%    if (fzero > trig)
%        deflat = 1;
%        if VERBOSE
%            script_status( 'deflatline', 'deflat 1', 'fzero > trig' );
%        end
%    end
end

if deflat == 1
    data_in( data_zeroes ) = NaN;
end

data_out = data_in;

for ii = 2:npts-1
    if (data_in(ii-1)==0) && (data_in(ii)==0) && (data_in(ii+1)==0)
        data_out(ii-1) = NaN;
        data_out(ii) = NaN;
        data_out(ii+1) = NaN;
    end
end

return