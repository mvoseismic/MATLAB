function rsam = rsam_get_bob_tilt( datim_beg, datim_end )
%
% Gets BOB tilt data for a two stations for a time period
% and puts the data into a MATLAB time series object
%
% Rod Stewart, 2011-12-02

% Things needed
m_script = 'rsam_get';

% Globals set elsewhere
global DP_DIR_BOB
global DP_VERBOSE

tsamp = 10;

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
for ista = 1:2
    
    switch ista
        case 1
            sta = 'CHPK';
        case 2
            sta = 'CHP3';
    end
    
    subdir_data = sprintf( '%s/%s', 'TILT', sta );
    
    data = [];

    
    for iaxis = 1:2
            
        switch iaxis
            case 1
                taxis = 'X';
            case 2
                taxis = 'Y';
        end
            
        % loop round years, if need be, getting whole year at a time
        for iyr = YearBeg:YearEnd
        
            fprintf( 'Year: %d\n', iyr );
            % Number of data points expected in this year
            if isleap( iyr )
                n_year = 527040/tsamp;
            else
                n_year = 525600/tsamp;
            end
            fprintf( 'points: %d\n', n_year ); 
        

            
            % Create file name
            file_tilt = sprintf( '%s%s%2d.DAT', ...
                    taxis, 'AXS', rem(iyr,100) );
            file_tilt = fullfile( DP_DIR_BOB, subdir_data, file_tilt );

            if DP_VERBOSE
                m_message = sprintf( 'RSAM file: %s', file_tilt );
                m_progress( m_script, 'I', m_message );
            end
        
            % Open file and read it
            fid = fopen(file_tilt,'r');
            if fid == -1
                m_progress( m_script, 'W', 'cannot open file for reading, setting all values to NaN' );
                data_yr = NaN( n_year, 1 );
                ncount = n_year;
            else
            
                [data_yr,ncount] = fread( fid, 'real*4');

                % Skip first "record"
                n_skip = int32(24.0*60.0/tsamp);
                data_yr = data_yr(n_skip+1:end);
                ncount = ncount - n_skip;
                    
                % Replace -ve and 0 with NaN
                data_yr( data_yr <= 0 ) = NaN;
                    
                fclose(fid);
            end
        
            % Check if got right number of data
            if ncount ~= n_year
                m_message = sprintf( 'Bad number of data: %d', ncount );
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
        
        % CHPK: Remove any data with jumps greater than max_jump
        if strcmp( sta, 'CHPK' )
            max_jump = 20;
            ddata2 = diff( data2 );
            idd = ( abs( ddata2 ) >= max_jump );
            data2plus = ddata2 .* idd;
            data2plus = cumsum( [0; data2plus] );
            data2 = data2 - data2plus;
        end

        % Create time series object
        station = sprintf( '%s_%s', sta, taxis );
        ts = timeseries( data2, datim, 'name', station );
        ts.TimeInfo.Units = 'days';
    
        rsam = addts( rsam, ts );
    
    
    end
end



