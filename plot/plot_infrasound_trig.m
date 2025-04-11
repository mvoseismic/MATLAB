function plot_infrasound_trig( datim_beg, datim_end )

t_beg = datenum( datim_beg );
t_end = datenum( datim_end ) + 1;

t_limits = [ t_beg t_end ];

[Datim,Press,BackAz,Coh] = read_infrasound_trig( datim_beg, datim_end );


subplot(3,1,1);
plot(Datim, Press, 'bo' );
datetick( 'x' );

xlim( t_limits );
ylim( [0 max( Press ) ] );
title( 'Pressure (bar)' );


subplot(3,1,2);
plot(Datim, BackAz, 'bo' );
datetick( 'x' );

xlim( t_limits );
ylim( [0 360 ] );
title( 'Back Azimuth (degrees)' );


subplot(3,1,3);
plot(Datim, Coh, 'bo' );
datetick( 'x' );

xlim( t_limits );
ylim( [0 100 ] );
title( 'Coherence' );

