function [depth_unit] = calcprobedepth(channel,depth)
%Calculates the depth of the channel specified
%
%Written by D.M. Brady 4/2010

spacing = 50; %Distance (um) between channels

depth_unit = depth-((16-channel)*spacing);
