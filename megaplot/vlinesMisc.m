function Vlines = vlinesMisc( lineset )
%
% Sets Vlines for different periods
%
% R.C. Stewart, 30-Jan-2020

switch lineset
    
    case {'Pause5','pause5'}
        
        nlines = 6;
        
        for il = 1:nlines
            
            switch il
                case 1
                    Vlines(il).datim = dateCommon( 'begPause5' );
                case 2
                    Vlines(il).datim = datenum( 2011, 2, 1, 0, 0, 0 );
                case 3
                    Vlines(il).datim = datenum( 2012, 4, 1, 0, 0, 0 );
                case 4
                    Vlines(il).datim = datenum( 2016, 1, 1, 0, 0, 0 );
                case 5
                    Vlines(il).datim = datenum( 2018, 7, 26, 0, 0, 0 );
                case 6
                    Vlines(il).datim = datenum( 2019, 11, 17, 0, 0, 0 );
%                case 7
%                    Vlines(il).datim = datenum( 2020, 2, 6, 0, 0, 0 );
            end
            
        end
        
        
    otherwise 
        nlines = 0;
        
        
end

for il = 1:nlines
    
    Vlines(il).style = 'b-';
    Vlines(il).width = 0.5;
    Vlines(il).labelloc = 80;
    
end
        
        
        
        
        
        
        
        