function [xProf,yProf] = fetchDem2014Profile( setup, type, pos )


[I, R] = fetchDem2014( setup );
[X,Y,Z] = dem2xyz( I, R );

%Z = flip(Z);


if strcmp( type, 'NS' )
    xProf = Y;
    iCol = round( size(Z,2)*(pos-X(1))/(X(end)-X(1)) );
    yProf = Z(:,iCol);
elseif strcmp( type, 'EW' )
    xProf = X;
    iRow = round( size(Z,1)*(pos-Y(1))/(Y(end)-Y(1)) );
    yProf = Z(iRow,:);
end