% Latency Histograms of SU data
%
% Written by D.M. Brady 10/25/2010

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

%% Old Way of Making Histograms
x = 0:10:1000; %Makes bins of ten seconds

figure(1)

subplot(2,2,1)
hist(visv1,x)
title('V1 Visual Response Latencies')
xlabel('Latency to Peak (ms)')
ylabel('Number of Cells')

subplot(2,2,2)
hist(visv2,x)
title('V2 Visual Response Latencies')
xlabel('Latency to Peak (ms)')
ylabel('Number of Cells')

subplot(2,2,3)
hist(audv1,x)
title('V1 Auditory Response Latencies')
xlabel('Latency to Peak (ms)')
ylabel('Number of Cells')

subplot(2,2,4)
hist(audv2,x)
title('V2 Auditory Response Latencies')
xlabel('Latency to Peak (ms)')
ylabel('Number of Cells')

figure(2)
subplot(2,2,1)
hist(audAC,x)
title('AC Auditory Response Latencies')
xlabel('Latency to Peak (ms)')
ylabel('Number of Cells')

%% New Way of Making Histograms (Normalized)

figure(3)
numberofbins = 0:10:1000;

%V1 Visual Response Latency
counts = hist(visv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,1)
hold on
title('V1 Visual Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1,'FaceColor','r');
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')

%V2 Visual Response Latency
counts = hist(visv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,2)
hold on
title('V2 Visual Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')

%V1 Auditory Response Latency
counts = hist(audv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,3)
hold on
title('V1 Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')

%V2 Auditory Response Latency
counts = hist(audv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,4)
hold on
title('V2 Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')

%AC Auditory Response Latency
figure(4)
counts = hist(audAC, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,1)
hold on
title('AC Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')












