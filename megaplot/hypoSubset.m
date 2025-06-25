function HypoOut = hypoSubset( HypoIn, groupID, datimBeg, datimEnd )
%
% Returns a subset of the Hypo structure
%
% R.C. Stewart 8-Jan-2020


if strcmp( groupID, '' ) || nargin == 1
    groupID = 'all';
end

id_all = ones( 1, length( HypoIn) );

% Only MVO and BGS locations
%idmvo = strcmp( {HypoIn.loc_agency}, 'MVO' );
%idbgs = strcmp( {HypoIn.loc_agency}, 'BGS' );
%id_all = idmvo | idbgs;

gids = split( groupID, '_' );

for igid = 1:length( gids )
    
    gid = char( gids(igid) );
    
    switch gid
        case 'T'
            id_gid = strcmp( {HypoIn.type}, 'T ' );
        case 'R'
            id_gid = strcmp( {HypoIn.type}, 'R ' );
        case 'L'
            id_gid = strcmp( {HypoIn.type}, 'L ' );
        case 'LV'
            id_gid = strcmp( {HypoIn.type}, 'V' );
            
        case {'vt','hy','lp','lr','ro','ex','sw','no','mo'}
            gidlv = sprintf( 'LV_%2s', gid );
            group = listGroupings( gidlv );
            vtype = group.vlabel;
            id_gid = strcmp( {HypoIn.volctype}, vtype );
            
        case 'alllf'
            id_hy = strcmp( {HypoIn.volctype}, 'h' );
            id_lp = strcmp( {HypoIn.volctype}, 'l' );
            id_lr = strcmp( {HypoIn.volctype}, 'e' );
            id_gid = id_lr | id_lp | id_hy ;           
            
        case 'allrf'
            id_lr = strcmp( {HypoIn.volctype}, 'e' );
            id_rf = strcmp( {HypoIn.volctype}, 'r' );
            id_gid = id_lr | id_rf ;           
            
        case {'str','nst'}
            id_vt = strcmp( {HypoIn.volctype}, 't' );  
            id_str = [HypoIn.isin_string];
            if strcmp( gid, 'nst' )
                id_str = ~id_str;
            end
            id_gid = id_vt & id_str;
            
        case 'loc'
            id_gid = [HypoIn.located];
           
        case 'bigvt'
            id_gid = [HypoIn.located];
           
    end
    
    if exist( 'id_gid', 'var' )
        id_all = id_all & id_gid;
    end
    
end
            
    
% Only events between dates
if nargin > 3 && datimBeg ~= datimEnd
    
%    id_dates = [HypoIn.otime] >= datimBeg & [HypoIn.otime] <= datimEnd;  
    id_dates = [HypoIn.datim] >= datimBeg & [HypoIn.datim] <= datimEnd;  
    id_all = id_all & id_dates;
    
end

  
HypoOut = HypoIn(id_all);

