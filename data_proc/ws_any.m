function s = ws_any( type )
%
% creates an scnl object for types of stations, so it can be used for
% extracting
%
% Rod Stewart, 2009-06-15

switch type
    case 'bbz'
        s = scnlobject('*',{'BHZ','HHZ', 'BH Z', 'HH Z'},'*','*');
    case 'anyz'
        s = scnlobject('*',{'SHZ','BHZ','HHZ', 'SH Z', 'BH Z', 'HH Z'},'*','*');
    case 'anyn'
        s = scnlobject('*',{'SHN','BHN','HHN'},'*','*');
    case 'anye'
        s = scnlobject('*',{'SHE','BHE','HHE'},'*','*');
    case 'expl'
        s = scnlobject({'MBBY','MBGH','MBWH'},'BHZ','*','*');
end

return