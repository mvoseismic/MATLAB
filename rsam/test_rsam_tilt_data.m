m_script = 'test_rsam_data';

global DP_DIR_BOB
global DP_VERBOSE

DP_VERBOSE = true;

DP_DIR_BOB = '/Users/stewart/data/_copy/MVO/data_BOB-1995-1997';


m_message = 'Checking BOB tilt data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [1996 1 1 0 0 0] );
DatimEnd = datenum( [1997 12 31 23 59 0] );
    
tilt10 = rsam_get_bob_tilt( DatimBeg, DatimEnd );
    
figure;
rsam_plot( tilt10, 'X' );
xlim( [DatimBeg DatimEnd] );

