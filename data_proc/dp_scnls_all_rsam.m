function dp_scnls_all_rsam( year )
%
% Sets the DP_SCNL cell string array for all the RSAM stations
% in a directory
%
% Rod Stewart, 2011-12-25

global DP_SCNL                      % SCNLs of data used (cell string)
global DP_DIR_RSAM

DP_SCNL = [];

% Create directory string for searching
if year == 0
    filestr = sprintf( '%s/*_60sec.dat', DP_DIR_RSAM );
else
    filestr = sprintf( '%s/%4d_*_60sec.dat', DP_DIR_RSAM, year );
end

% Files in RSAM directory
files = dir( filestr );
nfiles = length( files );

for ifile = 1:nfiles
    
    fname = files(ifile).name;
    
    s = regexp( fname, '_', 'split' );

    sta = char(s(3));
    cha = char(s(4));
    
    if strcmp(cha(2),'H')
        scnl = sprintf('%s.%s.*.*', sta, cha);
    
%       fprintf( '%s\n', scnl );
    
        if sum(strfind( scnl, ' ' )) == 0
            if ~isempty( DP_SCNL )
                if ~ismember( cellstr(scnl), DP_SCNL )
                    DP_SCNL = [DP_SCNL;cellstr(scnl)];
                end
            else
                DP_SCNL = [DP_SCNL;cellstr(scnl)];
            end
        end
    end
end


return