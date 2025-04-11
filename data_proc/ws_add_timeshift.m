function wout = ws_add_timeshift( win, shifts )
%
% Adds time shifts to the data
% Shifts are in samples, +ve only
%
% Rod Stewart, 2010-06-25
%

wout = win;

nsta = length( win );
nsca = length( shifts );

if nsca == 1
    shifts = shifts * ones( nsta, 1 );
elseif nsta ~= nsca
    script_status( 'ws_scale', 'Arrays', 'unmatched' );
    script_status( 'ws_scale', 'nsta', num2str(nsta) );
    script_status( 'ws_scale', 'nsca', num2str(nsca) );
    return
end


for ii = 1:nsta
    data = get(win(ii),'data');
    data2 = circshift( data, shifts(ii) );
%    ndata = length(data);
%    ndata2 = ndata + shifts(ii);
%    data2 = nan(1,ndata2);
%    data2(shifts(ii)+1:shifts(ii)+ndata) = data(1:ndata);

    wout(ii) = set( wout(ii), 'data', data2 );
end

return
