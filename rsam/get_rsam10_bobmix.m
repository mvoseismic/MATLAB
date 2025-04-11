function rsam = get_rsam10_bobmix( datim_beg, datim_end )
%
% Gets BOB rsam data for examle stations from both RSAM1 and RSAM10
%
% Rod Stewart, 2011-12-07

global DP_DIR_BOB
global DP_SCNL
global DP_VERBOSE


% RSAM1 data
scnl_string = 'MGAT.x.x.x';
dp_scnls( scnl_string );
rsam1 = rsam_get( datim_beg, datim_end, 'bob', 1 );

% RSAM10 data
scnl_string = 'MGHZ.x.x.x,MLGT.x.x.x,MRYT.x.x.x';
dp_scnls( scnl_string );
rsam10 = rsam_get( datim_beg, datim_end, 'bob', 10 );

rsam10a = rsam_decimate( rsam1, 10 );

%size( rsam1 )
%size( rsam10 )
%size( rsam10a )

rsam = rsam_combine( rsam10, rsam10a );

return