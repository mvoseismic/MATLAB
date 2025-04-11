function [ rsam ] = BHZ_to_SHZ( rsam )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 % get list of channels in rsam object
     for ss=1:length(rsam)
         rsam(ss).chan = replace(rsam(ss).chan,'BH','SH');
     end    
     
end

