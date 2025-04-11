function Count = defineCount()
%
% Defines and initialises a count structure
%
% R.C. Stewart, 27-Feb-2020

Count.datimBeg = NaN;            % Date of start of count
Count.datimEnd = NaN;            % Date of end of count

Count.binFreq = 'daily';         % Frequency of counting: daily, weekly.  monthly, hourly
Count.binWidth = 1.0;            % Bin width, in days

Count.data = [];                 % Data points
Count.datim = [];                % Date/time of centre of bin

Count.title = '';                % Title for plots
Count.label = '';                % Label for plots

