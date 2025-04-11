function dataout = data_offset( datain, offset )
%
% Takes an array with several data sets and offsets them so that they plot
% nicely
%
% Rod Stewart, 2009-05-12

[ndata nset] = size( datain );

dataout = datain;

for ii = 2:nset
    
    dataout(:,ii) = dataout(:,ii) + (ii-1) * offset;
    
end