function Label = listGroupings( gid )
%
% Lists, or returns, groupings of events in SEISAN database
%

group(1).id = 'all';
group(1).label = 'All events';
group(1).slabel = 'All';
group(1).vlabel ='';

group(2).id = 'T';
group(2).label = 'Teleseismic events';
group(2).slabel = 'T';
group(2).vlabel ='';

group(3).id = 'R';
group(3).label = 'Regional events';
group(3).slabel = 'R';
group(3).vlabel ='';

group(4).id = 'L';
group(4).label = 'Local events';
group(4).slabel = 'L';
group(4).vlabel ='';

group(5).id = 'LV';
group(5).label = 'Local volcanic  events';
group(5).slabel = 'LV';
group(5).vlabel ='';

group(6).id = 'LV_vt';
group(6).label = 'Local volcanic VT events';
group(6).slabel = 'VT';
group(6).vlabel ='t';

group(7).id = 'LV_hy';
group(7).label = 'All local volcanic hybrid events';
group(7).slabel = 'hybrid';
group(7).vlabel ='h';

group(8).id = 'LV_lp';
group(8).label = 'All local volcanic LP events';
group(8).slabel = 'LP';
group(8).vlabel ='l';

group(9).id = 'LV_lr';
group(9).label = 'All local volcanic LP/rockfall events';
group(9).slabel = 'LP/rockfall';
group(9).vlabel ='e';

group(10).id = 'LV_ro';
group(10).label = 'All local volcanic rockfall events';
group(10).slabel = 'rockfall';
group(10).vlabel ='r';

group(11).id = 'LV_ex';
group(11).label = 'All local volcanic explosions';
group(11).slabel = 'explosion';
group(11).vlabel ='x';

group(12).id = 'LV_sw';
group(12).label = 'All local volcanic swarms';
group(12).slabel = 'swarm';
group(12).vlabel ='s';

group(13).id = 'LV_no';
group(13).label = 'All noise';
group(13).slabel = 'noise';
group(13).vlabel ='n';

group(14).id = 'LV_mo';
group(14).label = 'All local volcanic monochromatic signals';
group(14).slabel = 'monochromatic';
group(14).vlabel ='m';

group(15).id = 'LV_vt_loc';
group(15).label = 'Located VT events';
group(15).slabel = 'VT';
group(15).vlabel ='';

group(16).id = 'LV_vt_str';
group(16).label = 'String VT events';
group(16).slabel = 'string VT';
group(16).vlabel ='';

group(17).id = 'LV_vt_nst';
group(17).label = 'Non-string VT events';
group(17).slabel = 'non-string VT';
group(17).vlabel ='';

group(18).id = 'LV_vt_str_loc';
group(18).label = 'Located string VT events';
group(18).slabel = 'string VT';
group(18).vlabel ='';

group(19).id = 'LV_vt_nst_loc';
group(19).label = 'Located non-string VT events';
group(19).slabel = 'non-string VT';
group(19).vlabel ='';

group(20).id = 'LV_alllf';
group(20).label = 'All low-frequency events';
group(20).slabel = 'LF';
group(20).vlabel ='';

group(21).id = 'LV_allrf';
group(21).label = 'All rockfalls';
group(21).slabel = 'rockfall';
group(21).vlabel ='';


% Just list all available groupings
if nargin == 0
    
    for ig = 1:length( group )
        
        fprintf( 1, '%-20s %1s %-15s %s\n', ...
            group(ig).id, group(ig).vlabel, ...
            group(ig).slabel, group(ig).label );
        
    end
    
% return one group structure
else
    
    id_gid = strcmp( {group.id}, gid );
    Label = group( id_gid );
    
end