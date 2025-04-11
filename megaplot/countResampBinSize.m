function bins = countResampBinSize( setup )
%
% Decides on bin to use for rate calculations
%
% R.C. Stewart, 25-Feb-2020

switch setup.CountBinResamp
    
    case 'yes'
        datim_lim = setup.PlotDatimLim;
        span = datim_lim(2) - datim_lim(1);
        if span > 1500
            bins = 'monthly';
        elseif span > 400
            bins = 'weekly';
        else
            bins = 'daily';
        end
        
    case {'weekly','monthly','fortnightly'}
        bins = setup.CountBinResamp;
        
    otherwise
        bins = 'daily';
        
end
    
