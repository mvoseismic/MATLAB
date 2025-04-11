function [I,R] = fetchDem2014Shaded0( setup )

fileDem = fullfile( setup.DirDem, 'dem_2014_SHV_3m_hs.tif' );
%georasterinfo( fileDem )
[I, R ] = readgeoraster( fileDem );

I(I==32767) = NaN;
I = double(I);