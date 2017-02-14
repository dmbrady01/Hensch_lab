% Onset Latency Calculations

%% Method to Calculate the time to first spike
% For visual onset latency
onsetlatency.vis.all = []; %Will put in all the time values at which the first spike occured
for i=1:length(rasters.vis)
    if isempty(rasters.vis{i}) == 1; %Assigns a zero to a trial with no spikes
        onsetlatency.vis.all(i) = 0;
    elseif max(rasters.vis{i}) <= 0 %Assigns a zero to a trial with spikes only before the stimulus happens
        onsetlatency.vis.all(i) = 0;
    elseif min(rasters.vis{i}) >= 1000 %Assigns a zero to a trial with spikes only after the stimulus is off
        onsetlatency.vis.all(i) = 0;
    else
        onsetlatency.vis.all(i) = find(rasters.vis{i}>0,1); 
        %Finds the indices at which the first spike occurs while the
        %stimulus is on
        onsetlatency.vis.all(i) = rasters.vis{i}(onsetlatency.vis.all(i)); %Converts that indice back to the time
    end
end

%To get rid of the zeros when calculating the mean, std, and sem
onsetlatency.vis.all = onsetlatency.vis.all(onsetlatency.vis.all>0);

onsetlatency.vis.median = median(onsetlatency.vis.all); %Median
onsetlatency.vis.iqr = iqr(onsetlatency.vis.all); %Interquartile Range (75th-25th)
onsetlatency.vis.mad = mad(onsetlatency.vis.all,1); %Median absolute deviation
onsetlatency.vis.mean = mean(onsetlatency.vis.all); %Mean
onsetlatency.vis.sd = std(onsetlatency.vis.all); %Standard Deviation
onsetlatency.vis.sem = onsetlatency.vis.sd/(length(onsetlatency.vis.all)^.5); %Standard error of the mean

%% For auditory onset latency
onsetlatency.aud.all = []; %Will put in all the time values at which the first spike occured
for i=1:length(rasters.aud)
    if isempty(rasters.aud{i}) == 1; %Assigns a zero to a trial with no spikes
        onsetlatency.aud.all(i) = 0;
    elseif max(rasters.aud{i}) <= 0 %Assigns a zero to a trial with spikes only before the stimulus happens
        onsetlatency.aud.all(i) = 0;
    elseif min(rasters.aud{i}) >= 1000 %Assigns a zero to a trial with spikes only after the stimulus is off
        onsetlatency.aud.all(i) = 0;
    else
        onsetlatency.aud.all(i) = find(rasters.aud{i}>0,1); 
        %Finds the indices at which the first spike occurs while the
        %stimulus is on
        onsetlatency.aud.all(i) = rasters.aud{i}(onsetlatency.aud.all(i)); %Converts that indice back to the time
    end
end

%To get rid of the zeros when calculating the mean, std, and sem
onsetlatency.aud.all = onsetlatency.aud.all(onsetlatency.aud.all>0);

onsetlatency.aud.median = median(onsetlatency.aud.all);
onsetlatency.aud.iqr = iqr(onsetlatency.aud.all);
onsetlatency.aud.mad = mad(onsetlatency.aud.all,1);
onsetlatency.aud.mean = mean(onsetlatency.aud.all);
onsetlatency.aud.sd = std(onsetlatency.aud.all);
onsetlatency.aud.sem = onsetlatency.aud.sd/(length(onsetlatency.aud.all)^.5);

%% For both onset latency
onsetlatency.both.all = []; %Will put in all the time values at which the first spike occured
for i=1:length(rasters.both)
    if isempty(rasters.both{i}) == 1; %Assigns a zero to a trial with no spikes
        onsetlatency.both.all(i) = 0;
    elseif max(rasters.both{i}) <= 0 %Assigns a zero to a trial with spikes only before the stimulus happens
        onsetlatency.both.all(i) = 0;
    elseif min(rasters.both{i}) >= 1000 %Assigns a zero to a trial with spikes only after the stimulus is off
        onsetlatency.both.all(i) = 0;
    else
        onsetlatency.both.all(i) = find(rasters.both{i}>0,1); 
        %Finds the indices at which the first spike occurs while the
        %stimulus is on
        onsetlatency.both.all(i) = rasters.both{i}(onsetlatency.both.all(i)); %Converts that indice back to the time
    end
end

%To get rid of the zeros when calculating the mean, std, and sem
onsetlatency.both.all = onsetlatency.both.all(onsetlatency.both.all>0);

onsetlatency.both.median = median(onsetlatency.both.all);
onsetlatency.both.iqr = iqr(onsetlatency.both.all);
onsetlatency.both.mad = mad(onsetlatency.both.all,1);
onsetlatency.both.mean = mean(onsetlatency.both.all);
onsetlatency.both.sd = std(onsetlatency.both.all);
onsetlatency.both.sem = onsetlatency.both.sd/(length(onsetlatency.both.all)^.5);

%% Display time to first spike data
display('onsetlatency.vis')
onsetlatency.vis
display('onsetlatency.aud')
onsetlatency.aud
display('onsetlatency.both')
onsetlatency.both


%% Saving Data

%save('11111 P135LRMale pen1 ch1a - singleunitanalysis',...
%   'peaktime','firingrate','multifac','multiint', 'location',...
%   'spike_count','centers','psth','rasters','numberoftrials','timestamps','onsetlatency',...
%   'onresponse','p_ttest','h')


%Saves analysis of variance data/figures

save('9811 P100DR+LightFemale pen3 ch14 - singleunitanalysis',...
    'peaktime','firingrate','multifac','multiint', 'location',...
    'spike_count','centers','psth','rasters','numberoftrials','timestamps','onsetlatency',...
    'onresponse','p_ttest','h','p_anova','anova_table','anova_stats','multicomparisons')
saveas(figure(2),'9811 P100DR+LightFemale pen3 ch14 - Anova Table','fig')
saveas(figure(3),'9811 P100DR+LightFemale pen3 ch14 - Anova','fig')
saveas(figure(4),'9811 P100DR+LightFemale pen3 ch14 - MultiComparisons','fig')





