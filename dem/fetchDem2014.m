function [I,R] = fetchDem2014( setup )

fileDem = fullfile( setup.DirDem, 'SHV_3m_dem_LL/shv_3m_dem_ll.asc' );
%georasterinfo( fileDem )
[I, R ] = readgeoraster( fileDem );

I(I==-9999) = NaN;
I = double(I);