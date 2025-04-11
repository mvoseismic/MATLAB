datimBeg = datenum( 2020, 3, 20, 0, 0, 0 );
datimJmp = 1.0/24.0/60.0;

datim = datimBeg:datimJmp:datimBeg+20*datimJmp;
count = [ 1 0 0 1 0 0 0 0 1 0 1 1 1 1 1 1 1 1 1 1 1 ];

for i = 1:length( datim );
    
    fprintf( "%30s %5d\n", datestr( datim(i), 0 ), count(i) );
       
end

fprintf( "\n" );

[datim2, count2] = reBin( datim, count, 2 );

for i = 1:length( datim2 );
    
    fprintf( "%30s %5d\n", datestr( datim2(i), 0 ), count2(i) );
       
end

