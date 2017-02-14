function [deltafoverf] = convert2fluoro(x,time)
%Converts average intensity from arbitrary units to percent change in
%fluorescence
%
%Written by D.M. Brady 2/2010

avgprestim = mean(x(time<3)); %Finds all time values that are
%below 3 sec (prestimulation), then produces an average of the intensity 
%over that time period.
subtraction = x - avgprestim; %Subtract prestim from all intensities
deltafoverf = subtraction/avgprestim*100;