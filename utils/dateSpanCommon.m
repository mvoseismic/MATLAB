function [date_beg, date_end] = dateSpanCommon( wanted )
%
% Returns serial date numbers for common date spans
%
% R.C. Stewart, 23-Jan-2020

keySet =      { 'Eruption',    'Pause5'   };
valueSetBeg = { 'begEruption', 'begPause5'};
valueSetEnd = { 'endYear',     'endMonth' };

spanBeg = containers.Map( keySet, valueSetBeg );
spanEnd = containers.Map( keySet, valueSetEnd );


switch wanted
    
    case 'list'
        fprintf( 1, '\n' );
        fprintf( 1, ' Time periods available\n' );
        fstring = '  %-16s %-16s %-16s\n';
        fprintf( 1, fstring, '', 'from', 'to' );
        k = keys( spanBeg );
        for idk = 1:numel(k)
            a = k{idk};
            fprintf( 1, fstring, a, spanBeg(a), spanEnd(a) );
        end
        date_beg = 0;
        date_end = 0;
        
    otherwise
        
        if isKey(spanBeg,wanted)
            
            date_beg = dateCommon( spanBeg( wanted ) );
            date_end = dateCommon( spanEnd( wanted ) );
            
        else
            
            fprintf( 1, ' %s\n', 'Invalid key' );
            date_beg = 0;
            date_end = 0;
            
        end
            
end
        

