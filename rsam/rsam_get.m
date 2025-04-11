function rsam = rsam_get( datim_beg, datim_end, source, tsamp )
%
% Gets RSAM data for a number of stations for a time period
% and puts the data into a MATLAB time series object
%
% Updated to deal with MVO BOB and VME data, including 10-second data
%
% Rod Stewart, 2011-12-02

% Things needed
m_script = 'rsam_get';

% Globals set elsewhere
global DP_DIR_RSAM
global DP_DIR_BOB
global DP_SCNL
global DP_VERBOSE

% Deal with optional third and fourth arguments
if nargin < 4
    tsamp = 1;
end
if nargin < 3
    source = 'earthworm';
end

% Turns dates into numbers, rounding down to nearest tsamp
DatimBegVec = datevec( datim_beg );
DatimEndVec = datevec( datim_end );
if tsamp == 1
    DatimBegVec(6) = 0;
    DatimEndVec(6) = 0;
elseif tsamp == 10
    DatimBegVec(6) = 0;
    DatimEndVec(6) = 0;
    min_beg = tsamp * floor( DatimBegVec(5) / tsamp );
    DatimBegVec(5) = min_beg;
    min_end = tsamp * floor( DatimEndVec(5) / tsamp );
    DatimEndVec(5) = min_end;
else
    m_message = sprintf( 'Illegal value of tsamp: %d', tsamp );
    m_progress( m_script, 'F', m_message );
end

% Create vector of datims, adjusted to middle of sample
DatimBegNum = datenum( DatimBegVec );
DatimEndNum = datenum( DatimEndVec );
YearBeg = DatimBegVec(1);
YearEnd = DatimEndVec(1);
YearBegNum = datenum( [YearBeg 1 1 0 0 0] );
YearEndNum = datenum( [YearEnd 1 1 0 0 0] );
jump_days = tsamp / 60.0 / 24.0;
datim = DatimBegNum:jump_days:DatimEndNum;
datim = datim + jump_days/2.0;
n_datim = length( datim );
if DP_VERBOSE
    m_message = sprintf( 'Begin %d %s', YearBeg, datestr( DatimBegNum,0 ) );
    m_progress( m_script, 'I', m_message );
    m_message = sprintf( 'End   %d %s', YearEnd, datestr( DatimEndNum,0 ) );
    m_progress( m_script, 'I', m_message );
end

% Create time-series collection for rsam data 
%datatimecell = cellstr( datestr( datim, 0) );
rsam = tscollection( datim );
rsam.TimeInfo.Units = 'days';

% get indices of data we want relative to beginning of first year
p1 = int32( (DatimBegNum - YearBegNum) * ( 60.0 * 24.0 / tsamp ) ) + 1;
p2 = int32( (DatimEndNum - YearBegNum) * ( 60.0 * 24.0 / tsamp ) ) + 1;
if DP_VERBOSE
    m_message = sprintf( 'p1: %d', p1 );
    m_progress( m_script, 'D', m_message );
    m_message = sprintf( 'p2: %d', p2 );
    m_progress( m_script, 'D', m_message );
end

%loop round stations
for ista = 1:length( DP_SCNL )
    
    data = [];

    scnl = regexp( char( DP_SCNL(ista) ), '\.', 'split' );
    
    % loop round years, if need be, getting whole year at a time
    for iyr = YearBeg:YearEnd
        
        %fprintf( 'Year: %d\n', iyr );
        % Number of data points expected in this year
        if isleap( iyr )
            n_year = 527040/tsamp;
        else
            n_year = 525600/tsamp;
        end
        %fprintf( 'points: %d\n', n_year ); 
        

        % Create file name
        switch source
            case 'earthworm'
                sta = char( scnl(1) );
                cha = char( scnl(2) );
                file_rsam = sprintf( '%04d_rsam_%s_%s_60sec.dat', ...
                    iyr, sta, cha );
                file_rsam = fullfile( DP_DIR_RSAM,  file_rsam );
%                file_rsam_2 = sprintf( '%04d_rsam_%s_%s %s_60sec.dat', ...
%                   iyr, sta, cha(1:2), cha(3:3) );
%                file_rsam_2 = fullfile( DP_DIR_RSAM,  file_rsam_2 );
                station = sprintf( '%s_%s', sta, cha );
            case 'bob'
                sta = char( scnl(1) );
                if tsamp == 10
                    sub_dir = 'WIN_RSAM/RSAM10';
                else
                    sub_dir = 'WIN_RSAM/RSAM1';
                end
                file_rsam = sprintf( '%s%2d.DAT', ...
                    sta, rem(iyr,100) );
                file_rsam = fullfile( DP_DIR_BOB, sub_dir, file_rsam );
                station = sta;

            case 'bob_event'
                sta = char( scnl(1) );
                sub_dir = 'WIN_RSAM/EVENT10';
                file_rsam = sprintf( '%s%2d.DAT', ...
                    sta, rem(iyr,100) );
                file_rsam = fullfile( DP_DIR_BOB, sub_dir, file_rsam );
                station = sprintf( '%s_event10', sta );
            case 'vme'
                sta = char( scnl(1) );
                sub_dir = 'VME_RSAM';
                file_rsam = sprintf( '%s%2d.DAT', ...
                    sta, rem(iyr,100) );
                file_rsam = fullfile( DP_DIR_BOB, sub_dir, file_rsam );
                station = sta;
            otherwise
                m_message = sprintf( 'Illegal value of source: %s', source );
                m_progress( m_script, 'F', m_message );
        end
       
        if DP_VERBOSE
            m_message = sprintf( 'RSAM file: %s', file_rsam );
            m_progress( m_script, 'I', m_message );
            %{
            if ~isempty( file_rsam_2 )
                m_message = sprintf( 'second RSAM file: %s', file_rsam_2 );
                m_progress( m_script, 'I', m_message );
            end
            %}
        end
        
        % Open file and read it
        fid = fopen(file_rsam,'r');
        if fid == -1
            m_progress( m_script, 'W', 'cannot open file for reading, setting all values to NaN' );
            data_yr = NaN( n_year, 1 );
            ncount = n_year;
        else
            
            % Reading data in various formats
            switch source
                
                case 'earthworm'
                    
                    [data_yr,ncount] = fread( fid, 'int32');
                    
                    % Replace -ve and 0 with NaN
                    data_yr( data_yr <= 0 ) = NaN;
                    
                case {'bob','bob_event'}
                    
                     [data_yr,ncount] = fread( fid, 'real*4');

                    % Skip first "record"
                    n_skip = int32(24.0*60.0/tsamp);
                    data_yr = data_yr(n_skip+1:end);
                    ncount = ncount - n_skip;
                    
                    % Replace -ve and 0 with NaN
                    data_yr( data_yr <= 0 ) = NaN;
                    
                case 'vme'
            end
            fclose(fid);
        end
        
        % Deal with second file if we have it
%{        
        if ~isempty( file_rsam_2 )
            fid = fopen(file_rsam_2,'r');
            if fid == -1
                m_progress( m_script, 'W', 'cannot open file for reading, setting all values to NaN' );
                data_yr = NaN( n_year, 1 );
            else
            
                % Reading data in various formats
                switch source
                
                    case 'earthworm'
                    
                        [data_yr_2,ncount] = fread( fid, 'int32');
                    
                        % Replace -ve and 0 with NaN
                        data_yr_2( data_yr_2 <= 0 ) = NaN;
                    
                    case 'bob'
                    case 'vme'
                end
                fclose(fid);
            end
            
            % add the two vectors together
            data_yr = nansum( [data_yr; data_yr_2] );
        
        end 
        %}
        
        % Check if got right number of data
        if ncount > n_year
            m_message = sprintf( '%d %s ndata > %d: %d', ...
                iyr, station, n_year, ncount );
            m_progress( m_script, 'E', m_message );
            data_yr = data_yr(1:n_year);
        elseif ncount ~= n_year
            m_message = sprintf( '%d %s ndata < %d: %d', ...
                iyr, station, n_year, ncount );
            m_progress( m_script, 'F', m_message );
        end
        
        data = [data; data_yr];
                
    end
    
    if DP_VERBOSE
        m_message = sprintf( 'Size of full yearses data vector: %d', length(data) );
        m_progress( m_script, 'D', m_message );
    end
    % Have vector of data values for complete year, now extract bit we want
    data2 = data(p1:p2);

    % Create time series object
    ts = timeseries( data2, datim, 'name', station );
    ts.TimeInfo.Units = 'days';
    
    rsam = addts( rsam, ts );
    
end



