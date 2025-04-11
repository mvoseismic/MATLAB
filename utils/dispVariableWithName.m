function dispVariableWithName(varargin)
% displays variable name an d value
% stolen from MATLAB answers
% 
for i=1:nargin
  disp([inputname(i) '= ' num2str(varargin{i})]);
end