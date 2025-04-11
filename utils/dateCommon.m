function date_common = dateCommon( wanted )
%
% Returns a serial date number for common dates
%
% R.C. Stewart, 6-Jan -2019

%nowUTC = now+4/24;
nowUTC = now;

if strncmp( wanted, 'now-', 4 )

    daysBef = str2double( extractAfter( wanted, '-' ) );
    date_common = nowUTC - daysBef;


elseif strncmp( wanted, 'today-', 6 )

    daysBef = str2double( extractAfter( wanted, '-' ) );
    date_common = floor(nowUTC) - daysBef;

else

    switch wanted
    
        case 'list'

        case 'now'
            date_common = nowUTC;
        
        case 'today'
            date_common = floor(nowUTC);
        
        case 'yesterday'
            date_common = floor(nowUTC)-1;
        
        case 'endDay'
            date_common = floor( nowUTC ) + 1;
        
        case 'endMonth'
            [yr,mo,da,ho,mi,s] = datevec( nowUTC );
            date_common = datenum( yr, mo+1, 1, 0, 0, 0 );
        
        case 'endYear'
            [yr,mo,da,ho,mi,s] = datevec( nowUTC );
            date_common = datenum( yr+1, 1, 1, 0, 0, 0 );
        
        case 'begDay'
            date_common = floor( nowUTC );
        
        case 'begMonth'
            [yr,mo,da,ho,mi,s] = datevec( nowUTC );
            date_common = datenum( yr, mo, 1, 0, 0, 0 );
        
        case 'begYear'
            [yr,mo,da,ho,mi,s] = datevec( nowUTC );
            date_common = datenum( yr, 1, 1, 0, 0, 0 );
        
        case 'begEruption'
            date_common  = datenum( '18-Jul-1995' );
        
        case 'begPhase1Seismic'
            date_common  = datenum( '01-Jan-1992' );
        
        case 'begPhase1'
            date_common  = datenum( '18-Jul-1995' );
        
        case 'begPhase1Phreatic'
            date_common  = datenum( '18-Jul-1995' );
        
        case 'begPhase1Extrusion'
            date_common  = datenum( '15-Nov-1995' );
        
        case 'begPause1'
            date_common  = datenum( '10-Mar-1998' );
        
        case 'begPhase2'
            date_common  = datenum( '27-Nov-1999' );
        
        case 'begPhase2a'
            date_common  = datenum( '27-Nov-1999' ); 
            
        case 'begPause2a'
            date_common  = datenum( '03-Mar-2001' );

        case 'begPhase2b'
            date_common  = datenum( '11-May-2001' );
            
        case 'begPause2b'
            date_common  = datenum( '01-Jun-2002' );

        case 'begPhase2c'
            date_common  = datenum( '21-Jul-2002' );

        case 'begPause2c'
            date_common  = datenum( '01-Aug-2003' );
            
        case 'begPause2'
            date_common  = datenum( '01-Aug-2003' );
            
        case 'begPhase3Trans'
            date_common  = datenum( '15-Apr-2005' );
            
        case 'begPhase3'
            date_common  = datenum( '08-Aug-2005' );
        
        case 'begPause3'
            date_common  = datenum( '04-Apr-2007' );
        
        case 'begPhase4Trans'
            date_common  = datenum( '05-May-2008' );
        
        case 'begPhase4'
            date_common  = datenum( '29-Jul-2008' );
        
        case 'begPhase4a'
            date_common  = datenum( '29-Jul-2008' );
        
        case 'begPause4a'
            date_common  = datenum( '14-Oct-2008' );
        
        case 'begPhase4b'
            date_common  = datenum( '03-Dec-2008' );
        
        case 'begPause4b'
            date_common  = datenum( '04-Jan-2009' );
        
        case 'begPause4'
            date_common  = datenum( '04-Jan-2009' );
        
        case 'begPhase5Trans'
            date_common  = datenum( '05-Oct-2009' );
        
        case 'begPhase5'
            date_common  = datenum( '09-Oct-2009' );
        
        case 'begPause5'
            date_common  = datenum( '11-Feb-2010' );
        
        case 'begPause5+2'
            date_common  = datenum( '11-Feb-2010' ) + 2;
        
        otherwise
            if strcmp( substr(wanted,5,1 ), '-' )
                date_common  = datenum( wanted, 'yyyy-mm-dd HH:MM' );
            else
                date_common  = datenum( wanted, 'dd/mm/yyyy' );
            end
    end

end