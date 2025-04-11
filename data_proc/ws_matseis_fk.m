function out = ws_matseis_fk( w, XYZ, STACODE );
%
% Calls matseis_fk for ws data
%
% Rod Stewart, 2010-12-08

% Tidy up the data
w = ws_mean_norm( w );


% sampling rate
samprate = get( w(1), 'freq' );

% Station locations
x = km2deg( XYZ(:,1) );
y = km2deg( XYZ(:,2) );

% defaults
slow = (-40:1:40);
band = [0,samprate/2.0];

% Data array
[nr,nc] = size( XYZ );
npts = get(w(1),'DATA_LENGTH');

data = nan(npts,nr);

% put data into data
nsta = length( w );

for ii = 1:nsta
    code = get( w(ii), 'station' );
    idd = strcmp( STACODE{1}, code );
    wtmp = w(idd);
    datatmp = get( wtmp, 'data' );
    ndata = length(datatmp);
    
    if ndata ~= npts
        fprintf( 'Error - npts: %d   ndata: %d\n', npts, ndata );
    else
        data(idd,:) = datatmp;
    end
    
end

return
        
    
    
    

return;
