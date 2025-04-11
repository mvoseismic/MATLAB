function figure1( what, fnumber )
%
% Creates a figure window on screen suitable for portrait plots
%
% R.C. Stewart, 25-Feb-2020

if nargin < 1
    what = 'p';
end

if nargin < 2
  fnumber = 1;
end

switch what

    case {'p','portrait'}
        figure( 'Position', [10 10 800 900] );

    case {'l','landscape'}
        figure( 'Position', [10 10 900 800] );

    case {'w','wide'}
        figure( 'Position', [10 10 1600 800] );

    case {'w2','wide2'}
        figure( 'Position', [10 10 3200 800] );

    case {'w4','wide4'}
        figure( 'Position', [10 10 6400 800] );

end

hold on;
