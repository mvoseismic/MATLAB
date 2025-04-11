function shifts = ws_xcorr_shifts( win, ista_ref )
%
% Uses xcorr to calculate time shifts relative to a reference channel
%
% Rod Stewart, 2011-01-28
%

nsta = length( win );
shifts = nan(1,nsta);

nrmean = 15;

wf = ws_mean_norm( win );

data_ref = get(wf(ista_ref), 'data' );
ndata = length( data_ref );
    
for ista = 1:nsta

    data = get( wf(ista), 'data' );
    data_xc = xcorr( data, data_ref, 'coeff' );
    data_xc = nan_rmean( data_xc', nrmean );
    [data_xc_max,id_data_xc_max] = max( data_xc );
    nshift = ndata - id_data_xc_max;
    
    shifts(ista) = nshift;

end
    

return
