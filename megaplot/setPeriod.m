function setup = setPeriod( setup, time_period )
%
% Setups for various standard plots
%
% R.C. Stewart

[datim_beg, datim_end] = dateSpanCommon( time_period );

setup.Period = time_period;

setup.DataBeg = datim_beg;
setup.DataEnd = datim_end;
setup.PlotBeg = datim_beg;
setup.PlotEnd = datim_end;
