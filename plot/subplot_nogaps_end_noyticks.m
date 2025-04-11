function subplot_nogaps_end_noyticks( n_subplots, n_this_subplot )
%
% Sets up axis stuff for tight plots
% Rod Stewart, 2010-03-02

if n_this_subplot == 1
    set(gca,'XAxisLocation', 'top' );
elseif n_this_subplot == n_subplots
    set(gca,'XAxisLocation', 'bottom' );
else
    set(gca,'XTickLabel', [] );
end


return




