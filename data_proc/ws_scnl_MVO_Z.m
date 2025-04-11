function s = ws_scnl_MVO_Z
%
% Returns an scnl object with MVO codes and channels for Z only
%
% Rod Stewart, 2009-06-15

% BH stations
codes = {'MBBY','MBFR','MBGB','MBGH','MBHA','MBLG','MBLY','MBRY','MBWH'};
scnls.mvo.bh = scnlobject(codes,'BHZ');

% SH stations
codes = {'MBFL','MBRV'};
scnls.mvo.sh = scnlobject(codes,'SHZ');
%scnls.mvo.sh = scnlobject(codes,'*');

% HH
codes = {'MBWW'};
scnls.mvo.hh = scnlobject(codes,'HHZ');

s = [ scnls.mvo.bh scnls.mvo.sh scnls.mvo.hh ];

return