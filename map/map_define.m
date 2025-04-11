function [lat_limits,lon_limits] = map_define( whither )
%
% Defines some basic things for MATLAB maps

switch whither
    case 'GreaterCaribbean'
        lat_limits = [-5 35];
        lon_limits = [-105 -50];
    case 'Caribbean'
        lat_limits = [5 25];
        lon_limits = [-100 -50];
    case 'ECaribbean'
        lat_limits = [9 19];
        lon_limits = [-63.5 -59];
    case 'ECaribbeanN'
        lat_limits = [13 19];
        lon_limits = [-63.5 -59];
    case 'ECaribbeanS'
        lat_limits = [9 15];
        lon_limits = [-63.5 -59];
    case 'ECaribbeanC'
        lat_limits = [11 17];
        lon_limits = [-63.5 -59];
    case 'ECaribbeanPlus'
        lat_limits = [9 21];
        lon_limits = [-75 -57];
    case 'Trinidad'
        lat_limits = [10 10.9];
        lon_limits = [-62 -60.8];
    case 'Tobago'
        lat_limits = [11.1 11.4];
        lon_limits = [-60.86 -60.46];
    case 'Barbados'	
        lat_limits = [13 13.4];
        lon_limits = [-59.7 -59.4];
    case 'Grenada'
        lat_limits = [11.95 12.55];
        lon_limits = [-61.83 -61.4];
    case 'StVincent'
        lat_limits = [13.05 13.45];
        lon_limits = [-61.35 -61.05];
    case 'StLucia'
        lat_limits = [13.65 14.14];
        lon_limits = [-61.2 -60.8];
    case 'Dominica'
        lat_limits = [15.17 15.68];
        lon_limits = [-61.52 -61.19];
    case 'DominicaPlus'
        lat_limits = [14.97 15.88];
        lon_limits = [-61.72 -60.99];
    case 'DominicaN'
        lat_limits = [15.5 15.75];
        lon_limits = [-61.55 -61.3];
    case 'DominicaNW'
        lat_limits = [15.55 15.65];
        lon_limits = [-61.48 -61.38];
    case 'Anguilla'
        lat_limits = [18.14 18.34];
        lon_limits = [-63.2 -62.9];
    case 'Barbuda'
        lat_limits = [17.5 17.75];
        lon_limits = [-61.95 -61.65];
    case 'Antigua'
        lat_limits = [16.95 17.2];
        lon_limits = [-61.95 -61.65];
    case 'StKittsNevis'
        lat_limits = [17.05 17.45];
        lon_limits = [-62.9 -62.5];
    case 'Montserrat'
        lat_limits = [16.65 16.85];
        lon_limits = [-62.27 -62.12];
    case 'MontserratPlus3'
        lat_limits = [16.62 16.87];
        lon_limits = [-62.32 -62.08];
    case 'MontserratPlus2'
        lat_limits = [16.55 16.95];
        lon_limits = [-62.37 -62.02];
    case 'MontserratPlus'
        lat_limits = [16.45 17.05];
        lon_limits = [-62.47 -61.92];
    case 'MontserratPlusPlus'
        lat_limits = [16.35 17.15];
        lon_limits = [-62.57 -61.82];
    case 'MontserratSouth'
        lat_limits = [16.65 16.80];
        lon_limits = [-62.27 -62.12];
    case 'MontserratSouthTight'
        lat_limits = [16.67 16.76];
        lon_limits = [-62.23 -62.14];
    case 'MontserratSHV'
        lat_limits = [16.69 16.74];
        lon_limits = [-62.21 -62.16];
end

return
