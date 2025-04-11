clear;
clc;

m_script = 'test_rsam_fns';

global DP_DIR_RSAM
global DP_SCNL
global DP_VERBOSE

DP_VERBOSE = true;


m_progress( m_script, 'D', 'Testing rsam_get for earthworm data' );
DP_DIR_RSAM = '/Users/stewart/data/_copy/MVO/seismic/rsam';
file_save = 'MBGH_BHZ_2008_09';
scnl_string = 'MBGH.BHZ.*.*,MBFL.SHZ.*.*';
DatimBeg = '01-Jan-2008';
DatimEnd = '23-Feb-2009';
dp_scnls( scnl_string );
rsam = rsam_get_save( DatimBeg, DatimEnd, file_save );


%{
m_progress( m_script, 'D', 'Testing rsam_get for BOB data' );
file_save = 'testBOB';
DP_DIR_BOB = '/Users/stewart/data/_copy/MVO/data_BOB-1995-1997';
scnl_string = 'MGHZ.x.x.x';
dp_scnls( scnl_string );
rsam = rsam_get_save( DatimBeg, DatimEnd, file_save, 'bob' );

DatimBeg = '01-Oct-1995';
DatimEnd = '31-Dec-1997';

load testBOB;

m_progress( m_script, 'D', 'Testing rsam_decimate' );
rsamd = rsam_decimate( rsam, 10 );

t_limits = [ datenum( DatimBeg ) datenum( DatimEnd ) ];

m_progress( m_script, 'D', 'Testing rsam_norm' );
rsamn = rsam_norm( rsamd, 'median' );




subplot(2,1,1)
plot(rsamd.MGHZ);
xlim( t_limits );
datetick( 'x', 'keeplimits' );
subplot(2,1,2)
plot(rsamn.MGHZ);
xlim( t_limits );
datetick( 'x', 'keeplimits' );

mean( rsamd.MGHZ.data );
mean( rsamn.MGHZ.data );
%}