function newtxt = wtext( oldtxt )
%
% inserts line feeds in all spaces in a string
%
% Rod Stewart, 2008-09-25

ot = char( oldtxt );

spaces = findstr( ot, ' ' );
ns = length( spaces );

aft = ot;
newtxt = '';

for ii = 1:ns
    
    sp = findstr( aft, ' ' );
    lt = length( aft );

    bef = aft(1:sp(1)-1);
    aft = aft(sp(1)+1:lt);
    
    newtxt = sprintf( '%s%s\n', newtxt, bef );
end

newtxt = sprintf( '%s%s', newtxt, aft );
