function [dataRsam, datimRsam] = readRsamFile( fileRsam )
%
% Reads RSAM data from a single file
%
% R.C Stewart, 31-Dec-2020

fid = fopen(fileRsam,'r');

if fid == -1
    disp( 'cannot open file for reading, setting arrays to empty' );
    dataRsam = [];
    datimRsam = [];
else
    
    [dataRsam,ncount] = fread( fid, 'int32');
    
    dataRsam( dataRsam==-1 ) = NaN;
    
    [filepath,name,ext] = fileparts(fileRsam);
    yr = str2double( extractBetween( name, 1, 4 ) );
    
    datimRsamBeg = datenum( yr, 1, 1, 0, 0, 0 );
    datimRsamEnd = datenum( yr+1, 1, 1, 0, 0, 0 );
    datimRsamStep = 1.0 / ( 24.0*60 );
    
    datimRsam = (datimRsamBeg : datimRsamStep : datimRsamEnd-datimRsamStep )';
    
    fclose(fid);
    
end
    