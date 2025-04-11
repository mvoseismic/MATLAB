function s = ws_scnl_MVO_infra
%
% Returns an scnl object with MVO codes and channels
%
% Rod Stewart, 2009-06-15

% MBGH stations
scnls.mbgh = scnlobject('MBGH',{'BHZ','HDF'});

% MBFL stations
scnls.mbfl = scnlobject('MBFL',{'SHZ','HDF'});

% MBWW
scnls.mbww = scnlobject( 'MBWW', 'HHZ' );
scnls.mbw1 = scnlobject( 'MBW1', 'HDF' );
scnls.mbw2 = scnlobject( 'MBW2', 'HDF' );
scnls.mbw3 = scnlobject( 'MBW3', 'HDF' );


s = [ scnls.mbgh scnls.mbfl scnls.mbww scnls.mbw1 scnls.mbw2 scnls.mbw3 ];

return