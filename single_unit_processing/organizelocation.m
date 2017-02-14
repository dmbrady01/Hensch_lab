function [audlocation] = organizelocation(location)
%Organizes location info into a matrix to be used to plot position and
%depth
%
%Written by D.M. Brady 4/2010

audlocation(1,1) = location.medial_lateral;
audlocation(1,2) = location.anterior_posterior;
audlocation(1,3) = location.depth_unit;