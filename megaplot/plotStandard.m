function plotStandard( setup, standard )
%
% Creates a standard plot
%
% R.C. Stewart, 3-Mar-2020

standards = [   "mega_sei_gps_gas", ...
                "seis_counts_raw", ...
                "seis_counts_summed", ...
                "seis_counts_vt", ...
                "seis_counts_vt_cum" ];
    

switch standard
    
    case 'list'
        fprintf( 1, '\n' );
        fprintf( 1, ' Standard plots available\n' );
        fprintf( 1, '  %s\n', standards );
        
    otherwise       
        if sum( standards == standard )
            setup.Standard = standard;
            
            
            switch standard
        
                case 'seis_counts_raw'
                    plotSeismicCounts( setup, 'all5a' );
            
                case 'seis_counts_summed'
                    plotSeismicCounts( setup, 'all5s' );
            
                case 'seis_counts_vt'    
                    plotSeismicCounts( setup, 'vtt' );
            
                case 'seis_counts_vt_cum'            
                    ev_types = [ "vt", "vtstr", "vtnst" ];
                    plotSeismicCountsCum( setup, ev_types', 1 );
                           
            end
            
        else
            fprintf( 1, ' Standard plot not implemented\n' );
            setup.Standard = '';
        end
            
        
end


            
            
    

