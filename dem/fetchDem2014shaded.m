function [I,R] = fetchDem2014shaded( setup )

fileDem = fullfile( setup.DirDem, 'SHV_3m_dem_LL-shaded_relief/shv_3m_dem_hs_ll.asc' );
%georasterinfo( fileDem )
[I, R ] = readgeoraster( fileDem );

I(I==-9999) = NaN;
I = double(I);
%I = flipud(I);

xlimits = R.LongitudeLimits;
ylimits = R.LatitudeLimits;
rastersize = R.RasterSize;
R = maprefcells(xlimits,ylimits,rastersize, 'ColumnsStartFrom','north' );

