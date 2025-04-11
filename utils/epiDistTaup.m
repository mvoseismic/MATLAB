function epiDistTaup( latQuake, lonQuake, depQuake, latSta, lonSta )
%
% Calculates epicentral distance of an earthquake from a seismic station
% Station assumed to be MBFL if not given as argument
% arclen = epiDist( latQuake, lonQuake, <latSta>, <lonSta> )
%
% R.C. Stewart, 2022-11-11

if ~exist('lonSta','var')
    latSta = 16.7485; % MBFL
    lonSta = -62.2125;
end

if ~exist('depQuake','var')
    depQuake = 33.0;
end

[arclen,az] = distance(latSta,lonSta,latQuake,lonQuake);

command = sprintf('/snap/bin/taup time -deg %f -h %f --rel P', arclen, depQuake );

disp( command );
unix( command );
