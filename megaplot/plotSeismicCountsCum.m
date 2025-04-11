function plotSeismicCountsCum( setup, ev_types )
%
% Plots daily counts and calculates rates
% Only works for one ev_types
%
% R.C. Stewart, 30-Jan-2020


%ntypes = length( ev_types );

%for it = 1:ntypes
    
    ev_type = ev_types;

    figure1('l');

    subplot( 3, 1, 1 );
    plot_type = 'bar';
    plot_symcol = 'r';
    cum = 0;
    plotVolcstat( setup, ev_type, plot_type, plot_symcol, cum );

    subplot( 3, 1, 2:3);
    cum = 1;
    plot_type = 'line';
    plot_symcol = 'r-';
    plotVolcstat( setup, ev_type, plot_type, plot_symcol, cum );

    
%end