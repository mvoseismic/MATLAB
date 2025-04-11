function [gap, err_ot, err_lat, err_lon, err_dep, ...
                cov_xy, cov_xz, cov_yz] = parseSelectLineE( tline )
%
% Parses the E line from select.out
%
% R.C. Stewart, 7-Jan-2020

gap = str2double(tline(6:8));
err_ot = str2double(tline(15:20));
err_lat = str2double(tline(25:30));
err_lon = str2double(tline(33:38));
err_dep = str2double(tline(39:43));
cov_xy = str2double(tline(44:55));
cov_xz = str2double(tline(56:67));
cov_yz = str2double(tline(68:79));