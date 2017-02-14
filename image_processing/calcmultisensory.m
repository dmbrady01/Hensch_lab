function [multifac,multiint] = calcmultisensory(vis,aud,both)
%To calulate multisensory facilitation/depression and multisensory
%interaction for each region
%
%Written by D.M. Brady 2/2010

%Multisensory facilitation/depression = (Both-(Vis+Aud))/(Vis+Aud))*100
%Multisensory interaction = (Combined-StrongerSingle)/StrongerSingle*100

%Multisensory facilitation
multifac = (both-(vis+aud))/(vis+aud)*100;

%Multisensory interaction
if vis>aud
    multiint = (both-vis)/vis*100;
else
    multiint = (both-aud)/aud*100;
end
