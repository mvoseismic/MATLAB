function s = ws_scnl_MVO
%
% Returns an scnl object with MVO codes and channels
%
% Rod Stewart, 2009-06-15

% BH stations
codes = {'MBBY','MBFR','MBGB','MBGH','MBHA','MBLG','MBLY','MBRY','MBWH'};
tmp = scnlobject(codes,'BHZ');
scnls.mvo.bh = [tmp, set(tmp,'channel','BHN'), set(tmp,'channel','BHE')];

% SH stations
codes = {'MBFL','MBRV'};
scnls.mvo.sh = scnlobject(codes,'SHZ');
%scnls.mvo.sh = scnlobject(codes,'*');

% HH
codes = {'MBWW'};
tmp = scnlobject(codes,'HHZ');
scnls.mvo.hh = [tmp, set(tmp,'channel','HHN'), set(tmp,'channel','HHE')];

s = [ scnls.mvo.bh scnls.mvo.sh scnls.mvo.hh ];

return