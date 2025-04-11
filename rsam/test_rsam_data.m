clear;
clc;

m_script = 'test_rsam_data';

global DP_DIR_RSAM
global DP_DIR_BOB
global DP_SCNL
global DP_VERBOSE

DP_VERBOSE = true;

DP_DIR_RSAM = '/Users/stewart/data/_copy/MVO/seismic/rsam';
DP_DIR_BOB = '/Users/stewart/data/_copy/MVO/data_BOB-1995-1997';

%{
scnl_string = 'MCPZ.x.x.x,MGHZ.x.x.x,MLGL.x.x.x,MLGT.x.x.x,MRYT.x.x.x,MWHZ.x.x.x,MSPT.x.x.x';
dp_scnls( scnl_string );

m_message = 'Checking BOB RSAM10 data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [1995 1 1 0 0 0] );
DatimEnd = datenum( [1997 12 31 23 59 0] );
    
rsam10 = rsam_get( DatimBeg, DatimEnd, 'bob', 10 );
    
figure;
rsam_plot( rsam10, 'X' );
xlim( [DatimBeg DatimEnd] );

scnl_string = 'MGAT.x.x.x,MGHZ.x.x.x,MLYT.x.x.x,MRYT.x.x.x,MSPT.x.x.x';
dp_scnls( scnl_string );

m_message = 'Checking BOB RSAM1 data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [1995 1 1 0 0 0] );
DatimEnd = datenum( [1997 12 31 23 59 0] );
    
rsam1 = rsam_get( DatimBeg, DatimEnd, 'bob', 1 );
    
figure;
rsam_plot( rsam1, 'X' );
xlim( [DatimBeg DatimEnd] );

scnl_string = 'MLGT.x.x.x,MRYT.x.x.x,MSPT.x.x.x';
dp_scnls( scnl_string );

m_message = 'Checking BOB EVENT10 data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [1995 1 1 0 0 0] );
DatimEnd = datenum( [1997 12 31 23 59 0] );
    
event10 = rsam_get( DatimBeg, DatimEnd, 'bob_event', 10 );
    
figure;
rsam_plot( event10, 'X' );
xlim( [DatimBeg DatimEnd] );
%}

%{
scnl_string = 'MBBY.BHZ.x.x,MBFL.SHZ.x.x,MBFR.BHZ.x.x,MBGH.BHZ.x.x,MBHA.BHZ.x.x,MBLG.BHZ.x.x,MBLY.BHZ.x.x,MBRY.BHZ.x.x,MBWH.BHZ.x.x';
dp_scnls( scnl_string );

m_message = 'Checking Earthworm RSAM1 data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [2004 1 1 0 0 0] );
DatimEnd = datenum( [2011 12 31 23 59 0] );
    
rsam1 = rsam_get( DatimBeg, DatimEnd );
    
figure;
rsam_plot( rsam1, 'X' );
xlim( [DatimBeg DatimEnd] );
%}

scnl_string = 'MBGB.BHZ.x.x,MBGH.BHZ.x.x,MBLG.SHZ.x.x,MBLY.BHZ.x.x,MBRY.BHZ.x.x,MBSS.SHZ.x.x,MBWH.SHZ.x.x';
dp_scnls( scnl_string );

m_message = 'Checking Earthworm RSAM1 data';
m_progress( m_script, 'D', m_message );
DatimBeg = datenum( [2003 1 1 0 0 0] );
DatimEnd = datenum( [2003 12 31 23 59 0] );
    
rsam1 = rsam_get( DatimBeg, DatimEnd );
    
figure;
rsam_plot( rsam1, 'X' );
xlim( [DatimBeg DatimEnd] );

