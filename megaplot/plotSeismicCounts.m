function plotSeismicCounts( setup, what )
% 
% Plots eismic counts
%
% R.C. Stewart, 27-Feb-2020

figure;
figure_size( 's' );

switch what
    case 'vtt'
        ev_types = [ "vt", "vtstr", "vtnst" ];
    case 'all9'
        ev_types = [ "vt", "hy", "lp", "lr", "ro", "ex", "sw", "mo", "no" ];
    case 'all4'
        ev_types = [ "vt", "hy", "lp", "allrf" ];
    case 'all5'
        ev_types = [ "vt", "hy", "lp", "lr", "ro" ];
    case 'all5a'
        ev_types = [ "all", "vt", "hy", "lp", "lr", "ro" ];
    case 'all5s'
        ev_types = [ "all", "vt", "alllp", "allrf" ];
    case 'all4s'
        ev_types = [ "vt", "alllp", "allrf" ];
    case 'lpall'
        ev_types = [ "hy", "lp", "lr", "mo" ];
    case 'vtrf'
        ev_types = [ "vt", "allrf" ];
        
end

setup.SubplotSpace = 'tight';
setup.PlotXaxis = 'normal';
plot_type = 'bar';
plot_symcol = 'r';
plotVolcstatMulti( setup, ev_types, plot_type, plot_symcol );
