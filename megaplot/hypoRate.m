function Count = hypoRate( setup, Hypo, bins )
%
% Returns event count for Hypo structure
%
% R.C. Stewart, 20-Feb-2020

if nargin < 3
    bins = calcCountBins( setup );
end

switch bins
    
    case 'daily'
        title_text = 'Earthquakes / day';
        datim_min = floor( min( [Hypo.otime] ) );
        datim_max = floor( max( [Hypo.otime] ) ) + 1;
        bin_edges = datim_min:1:datim_max;
        bin_edge_to_centre = 0.5;
        bin_width = 1.0;
        
    case 'weekly'
        title_text = 'Earthquakes / week';
        datim_min = floor( min( [Hypo.otime] ) );
        datim_max = floor( max( [Hypo.otime] ) ) + 7;
        bin_edges = datim_min:7:datim_max;
        bin_edge_to_centre = 3.5;
        bin_width = 7.0;
        
    case 'monthly'
        title_text = 'Earthquakes / month';
        datim_min = floor( min( [Hypo.otime] ) );
        datim_max = floor( max( [Hypo.otime] ) ) + 3;
        bin_edges = datim_min:31:datim_max;
        bin_edge_to_centre = 15;
        bin_width = 30.0;
    
end

datims = [Hypo.otime];
h = histogram( datims, bin_edges );

hypo_count = h.Values;
hypo_datim = bin_edges(1:length(bin_edges)-1) + bin_edge_to_centre;

Count = defineCount();

Count.datimBeg = datim_min;
Count.datimEnd = datim_max;

Count.binFreq = bins;         
Count.binWidth = bin_width;          

Count.data = hypo_count;                 
Count.datim = hypo_datim;               

Count.title = title_text'';               
Count.label = 'N';        
