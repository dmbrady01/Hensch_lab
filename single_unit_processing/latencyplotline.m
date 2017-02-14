% Latency Plot - Line Graph
% Plot latency in a manner similar to PSTH - sliding scale
%
% by D.M. Brady 11/2010

%% Getting DR Latency Data
visv1 = xlsread('LatencyDR','VisV1');
visv2 = xlsread('LatencyDR','VisV2');
audv1 = xlsread('LatencyDR','AudV1');
audv2 = xlsread('LatencyDR','AudV2');
audAC = xlsread('LatencyDR','AudAC');

%% Getting NgR KO Latency Data
visv1 = xlsread('LatencyNgR','VisV1');
visv2 = xlsread('LatencyNgR','VisV2');
audv1 = xlsread('LatencyNgR','AudV1');
audv2 = xlsread('LatencyNgR','AudV2');
audAC = xlsread('LatencyNgR','AudAC');

%%

window = 10; %10 msec bins
step = 2; %2 msec steps
numberofbins = 0:window:1000;


for i = 1:length(numberofbins)
    for j = 1:max(numberofbins)./step
        latency.vis{j} = (find(audv2 > numberofbins(i)-(window/2) & audv2 < numberofbins(i)+(window/2)))
    end
end
