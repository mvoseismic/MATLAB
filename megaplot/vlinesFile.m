function VLines = vlinesFile( filename )
%
% Sets Vline structure for information from text file
%
% R.C. Stewart, 17-Nov-2020


T = readtable( filename );

for iline = 1:height( T );

    VLines(iline).datim = datenum(T.datetime(iline));
    VLines(iline).style = char(T.style(iline));
    VLines(iline).width = T.width(iline);
    VLines(iline).labelloc = T.labelloc(iline);

    VLines(iline).label = char( T.label(iline) );
    VLines(iline).labeloff = T.labeloff(iline);
    VLines(iline).labelsize = T.labelsize(iline);
    VLines(iline).box = T.box(iline);
    
end
    