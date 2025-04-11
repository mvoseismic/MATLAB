% startup
%
% script to set things needed
%
% Rod Stewart, 2012-01-11

%global global_OS                                % Operating system
%[status, result] = system( 'uname' );
%global_OS = strtrim( result );


%clear status result;

datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss')
%addpath(genpath('/home/seisan/src/MATLAB'));

%{
global DP_DIR_RSAM
global DP_DIR_BOB

global VERBOSE

dp_globals( 'Darwin.offline.mvo' );
VERBOSE = true;
%}
