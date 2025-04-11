function s = ws_scnl_MVO_BHZ
%
% Returns an scnl object with MVO codes and channels for Z only
%
% Rod Stewart, 2009-06-15

% BH stations
codes = {'MBBY','MBFR','MBGB','MBGH','MBHA','MBLG','MBLY','MBRY','MBWH'};
s = scnlobject(codes,'BHZ');


return