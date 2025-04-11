function mdnum = date_xl2mat( dnum )
%
% Converts Excel serial date number to MATLAB serial date number
%
% Rod Stewart, 2017-05-02

mdnum = dnum + 693960;