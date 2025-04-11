function subpos = subplot_pos_tight_vert( n_subplots )
%
% Returns positions of subplot windows for tight plot
% vertical version
% Rod Stewart, 2011-12-01

left=1; bottom=2; width=3; height=4;
pos = get(gca,'position');

subpos(1:n_subplots,bottom) = pos(bottom);
subpos(1:n_subplots,height) = pos(height);

subplot_width = pos(width) / n_subplots;
subpos(1:n_subplots,width) = subplot_width;

for ii = 1:n_subplots
    subplot_left = pos(left) ...
        + (ii-1) * pos(width) / n_subplots;
    subpos(ii,left) = subplot_left;
end

return




