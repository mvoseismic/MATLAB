function wout = ws_subset_scnl( w, s )
%
% Gives back a subset using scnl
%
% Rod Stewart, 2010-06-25

[IsInList, whereInList] = ismember(w,s);

wout = w(IsInList);
   
return