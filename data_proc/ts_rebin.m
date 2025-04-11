function ts_out = ts_rebin( ts_in, npts )
%
% Rebins a time series ie counts/day -> counts/week
%
% Rod Stewart, 2009-07-12

tstart = datenum( ts_in.TimeInfo.StartDate );
data = get( ts_in, 'Data' );
datatime = get( ts_in, 'Time' );
datatime = datatime + tstart;
ndata = length( data );

id = isnan( data );
%data( id ) = zeros( 1, sum(id) );
data( id ) = 0;
data = data';

data2 = [];
datatime2 = [];

ipt = 0;
for ii = 1:npts:ndata
    iend = ii+npts-1;
    if iend > ndata
        iend = ndata;
    end
    ipt = ipt + 1;
    datatmp = data(ii:iend);
    data2(ipt) = sum( datatmp );
    datatime2(ipt) = datatime( ii );
end
    
%tstart = tstart + datatime2(1);
datatime2 = datatime2 - tstart;

ts_out = timeseries( data2', datatime2, 'Name', ts_in.name );
ts_out.DataInfo.Unit = ts_in.DataInfo.Unit;
ts_out.TimeInfo.StartDate = ts_in.TimeInfo.StartDate;
ts_out.TimeInfo.Units = ts_in.TimeInfo.Units;

