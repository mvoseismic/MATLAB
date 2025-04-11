function magicXtickLabels()
%
% Puts X tick labels between ticks
% R.C. Stewart. 2023-10-25

% Magic tick labels
yLimits = ylim;
yLabel = yLimits(1) - (yLimits(2)-yLimits(1))*0.1;
h1=get(gca,'XTick');
h2=get(gca,'XTickLabel');
h3=length(h1);
xdiff=h1(2)-h1(1); % assuming uniform step interval in x-axis
h1=h1+0.4*xdiff; % this factor of 0.4 can be adjusted
for i=1:h3-1
    text(h1(i),yLabel,(h2(i,:))); 
%    text(h1(i),yLabel,num2str(h2(i,:))); 
end
set(gca,'XTickLabel',{});