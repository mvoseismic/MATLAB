function gain = sta_getgain( sta, cha, datim )
%
% Returns gain for a seismic stations
%
% Rod Stewart, 2011-01-26
%

gain = 1.0;

switch sta
    case 'MBBY'
        gain = 800.0;
    case 'MBFL'
        gain = 279.1;
    case 'MBFR'
        gain = 800.0;
    case 'MBGB'
        gain = 3200.0;
    case 'MBGH'
        gain = 3200.0;
    case 'MBHA'
        gain = 800.0;
    case 'MBLG'
        gain = 3200.0;
    case 'MBLY'
        gain = 800.0;
    case 'MBRV'
        gain = 279.1;
    case 'MBRY'
        gain = 3200.0;
    case 'MBWH'
        gain = 800.0;
    case 'MBWW'
        gain = 1500.0;
end

return
