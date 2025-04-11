% diffDatims
%
% Calculates difference between two date/times
%
% R.C.Stewart 2023-05-16

input1 = inputd( 'Start date/time for plot', 's', '11-Feb-2010 17:20:29.0' );
datetime1 = datetime( input1 );
datim1 = datenum( datetime1 );


input2 = inputd( 'Start date/time for plot', 's', 'now' );
datetime2 = datetime( input2 );
datim2 = datenum( datetime2 );

diffDays = datim2 - datim1;

fprintf( 'Difference\n' );
fprintf( 'in Days:    %14.3f\n', diffDays );
fprintf( 'in Hours:   %14.3f\n', 24*diffDays );
fprintf( 'in Minutes: %14.3f\n', 24*60*diffDays );
fprintf( 'in Seconds: %14.3f\n', 24*60*60*diffDays );
