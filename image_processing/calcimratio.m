function [bv1,bv2,av1,av2] = calcimratio(BothV1,BothV2,AudV1,AudV2,VisV1)
%To compare the V1 both, V2 both, and V2 aud responses to V1 Vis
%
%Written by D.M. Brady 2/2010

%Ratio V1 Both/V1 Vis
bv1 = BothV1/VisV1*100;

%Ratio V2 Both/V1 Vis
bv2 = BothV2/VisV1*100;

%Ratio V1 Aud/V1 Vis
av1 = AudV1/VisV1*100;

%Ratio V2 Aud/V1 Vis
av2 = AudV2/VisV1*100;

