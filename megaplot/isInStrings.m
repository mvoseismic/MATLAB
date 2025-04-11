function isin = isInStrings( setup, datims )
% 
% Given an array of event datims, returns whether in a string or not
%
% R.C. Stewart 7-Jan-2020

isin = zeros( size (datims) );

data_file = fullfile( setup.DirMegaplotData, 'fetchedVTstrings.mat' );
load( data_file );

for istring = 1:length(vtstring_datim_begs)
    
    dur = vtstring_durs( istring );
    if isfinite( dur )
        
        datim_beg = vtstring_datim_begs( istring );
        datim_end = datim_beg + dur/(60.0*24.0) ;
        
        idstring = (datims >= datim_beg) & (datims <= datim_end);
        isin( idstring ) = 1;
        
    end
    
end