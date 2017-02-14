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

%% New Way of Making Histograms (Normalized)

figure(1)
numberofbins = 0:10:1000;

%V1 Visual Response Latency
counts = hist(visv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,1)
hold on
title('V1 Visual Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')

%V2 Visual Response Latency
counts = hist(visv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,2)
hold on
title('V2 Visual Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')

%V1 Auditory Response Latency
counts = hist(audv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,3)
hold on
title('V1 Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')

%V2 Auditory Response Latency
counts = hist(audv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,4)
hold on
title('V2 Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')

%AC Auditory Response Latency
figure(2)
counts = hist(audAC, numberofbins);
normalizedcounts = 100*counts/sum(counts);

subplot(2,2,1)
hold on
title('AC Auditory Response Latencies')
bar(numberofbins,normalizedcounts,'barwidth',1);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')

%% Compare V1 Latencies (Vis vs. Aud)

%V1 Visual Response Latency - 10 ms bins
numberofbins = 0:10:1000;
counts = hist(visv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

figure(3)
hold on
title('Response Latencies')
bar(numberofbins,normalizedcounts,'FaceColor',[0 0 0]);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
% Add V1 Auditory Response Latency
counts = hist(audv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);
bar(numberofbins,normalizedcounts,'FaceColor',[.5 .5 .5]);
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')
legend('V1 Visual Response Latencies','V1 Auditory Response Latencies')

%% Compare V2 Latencies (Vis vs. Aud)

%V2 Visual Response Latency - 10 ms bins
numberofbins = 0:10:1000;
counts = hist(visv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);

figure(4)
hold on
title('Response Latencies')
bar(numberofbins,normalizedcounts,'FaceColor',[0 0 0]);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
% Add V2 Auditory Response Latency
counts = hist(audv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);
bar(numberofbins,normalizedcounts,'FaceColor',[.5 .5 .5]);
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')
legend('V2 Visual Response Latencies','V2 Auditory Response Latencies')

%% Compare Visual Latencies (V1 vs. V2)

%V1 Visual Response Latency - 10 ms bins
numberofbins = 0:10:1000;
counts = hist(visv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

figure(5)
hold on
title('Response Latencies')
bar(numberofbins,normalizedcounts,'FaceColor',[0 0 0]);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
% Add V2 Visual Response Latency
counts = hist(visv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);
bar(numberofbins,normalizedcounts,'FaceColor',[.5 .5 .5]);
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')
legend('V1 Visual Response Latencies','V2 Visual Response Latencies')

%% Compare Auditory Latencies (V1 vs. V2)

%V1 Auditory Response Latency - 10 ms bins
numberofbins = 0:10:1000;
counts = hist(audv1, numberofbins);
normalizedcounts = 100*counts/sum(counts);

figure(6)
hold on
title('Response Latencies')
bar(numberofbins,normalizedcounts,'FaceColor',[0 0 0]);
xlabel('Latency to Peak (ms)')
ylabel('Normalized Count [%]')
% Add V2 Auditory Response Latency
counts = hist(audv2, numberofbins);
normalizedcounts = 100*counts/sum(counts);
bar(numberofbins,normalizedcounts,'FaceColor',[.5 .5 .5]);
line([0 0],[0 max(normalizedcounts)],'Color','k','LineStyle','--')
legend('V1 Auditory Response Latencies','V2 Auditory Response Latencies')




