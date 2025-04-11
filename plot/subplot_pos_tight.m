function subpos = subplot_pos_tight( n_subplots )
%
% Returns positions of subplot windows for tight plot
% Rod Stewart, 2010-01-26

left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');


subpos(1:n_subplots,left) = pos(left);
subpos(1:n_subplots,width) = pos(width);

subplot_height = pos(height) / n_subplots;
subpos(1:n_subplots,height) = subplot_height;

for ii = 1:n_subplots
    subplot_bottom = pos(height) + pos(bottom) ...
        - ii * pos(height) / n_subplots;
    subpos(ii,bottom) = subplot_bottom;
end

return




