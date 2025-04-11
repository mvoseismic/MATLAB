function tlim( wanted )
%
% Uses dateSpanCommon to set xlim for plot
%
% R.C. Stewart, 8-Aug-2022

dateSpan = dateSpanCommon( wanted );
xlim( dateSpan );

