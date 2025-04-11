function plotDefaults( plot_look )
%
% Sets some plot default values
%
% R.C. Stewart, 21-Mar-2020

switch plot_look
    
    case 'thick'
        set(groot,'DefaultAxesFontSize', 20);
        set(groot,'DefaultAxesFontWeight', 'bold');
        set(groot, 'DefaultLineLineWidth', 1);
        set(groot, 'DefaultAxesLineWidth', 2);
        set(groot,'DefaultLineMarkerSize', 8);
        
    case 'lessthick'
        set(groot,'DefaultAxesFontSize', 16);
        set(groot,'DefaultAxesFontWeight', 'normal');
        set(groot, 'DefaultLineLineWidth', 1);
        set(groot, 'DefaultAxesLineWidth', 1);
        set(groot,'DefaultLineMarkerSize', 8);
        
   otherwise
        set(groot,'DefaultAxesFontSize', 10);
        set(groot,'DefaultAxesFontWeight', 'normal');
        set(groot, 'DefaultLineLineWidth', 0.5);
        set(groot, 'DefaultAxesLineWidth', 0.5);
        set(groot,'DefaultLineMarkerSize', 6);
        
        
end
