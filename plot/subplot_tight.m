function subplot_tight( gh, n_subplots, n_this_subplot )
%
% Sets up subplot positions for tight plots
% Rod Stewart, 2010-03-02

left=1; bottom=2; width=3; height=4;
pos = get(gh,'position');


subpos(1:n_subplots,left) = pos(left);
subpos(1:n_subplots,width) = pos(width);

subplot_height = pos(height) / n_subplots;
subpos(1:n_subplots,height) = subplot_height;

for ii = 1:n_subplots
    subplot_bottom = pos(height) + pos(bottom) ...
        - ii * pos(height) / n_subplots;
    subpos(ii,bottom) = subplot_bottom;
end

posn = subpos(n_this_subplot,:);

subplot('position',posn);

return




