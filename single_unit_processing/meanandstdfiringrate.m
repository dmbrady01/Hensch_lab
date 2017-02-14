%% Mean Firing Rates

window.firingrates = 100:100:1000; %Windows to calculate firing rates (in msecs)
window.stim = 1000;
onresponse = [];

%On firing rate
for i = 1:length(window.firingrates) 
    for j = 1:length(timestamps.vis) %For Visual Stimuli
        onresponse.vis(j) = length(timestamps.spikes(timestamps.spikes > timestamps.vis(j) & ...
            timestamps.spikes < timestamps.vis(j)+window.firingrates(i)));
    end
    firingrate.mean.vis(i) = mean(onresponse.vis)*(window.stim/window.firingrates(i));
    firingrate.std.vis(i) = std(onresponse.vis)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.aud) %For Auditory Stimuli
        onresponse.aud(j) = length(timestamps.spikes(timestamps.spikes > timestamps.aud(j) & ...
            timestamps.spikes < timestamps.aud(j)+window.firingrates(i)));
    end
    firingrate.mean.aud(i) = mean(onresponse.aud)*(window.stim/window.firingrates(i));
    firingrate.std.aud(i) = std(onresponse.aud)*(window.stim/window.firingrates(i));
   
    for j = 1:length(timestamps.both) %For Visual + Auditory Stimuli
        onresponse.both(j) = length(timestamps.spikes(timestamps.spikes > timestamps.both(j) & ...
            timestamps.spikes < timestamps.both(j)+window.firingrates(i)));
    end
    firingrate.mean.both(i) = mean(onresponse.both)*(window.stim/window.firingrates(i));
    firingrate.std.both(i) = std(onresponse.both)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.blank) %For Blank Stimuli
        onresponse.blank(j) = length(timestamps.spikes(timestamps.spikes > timestamps.blank(j) & ...
            timestamps.spikes < timestamps.blank(j)+window.firingrates(i)));
    end
    firingrate.mean.blank(i) = mean(onresponse.blank)*(window.stim/window.firingrates(i));
    firingrate.std.blank(i) = std(onresponse.blank)*(window.stim/window.firingrates(i));
end

fieldnm = fieldnames(firingrate.mean);
display(onresponse)
for i = 1:length(fieldnm)
    display(['firingrate.mean ' fieldnm{i}])
    display(firingrate.mean.(fieldnm{i})(end)) %Display mean firing rate
    display(['firingrate.std ' fieldnm{i}])
    display(firingrate.std.(fieldnm{i})(end)) %Display STD
end

%% Test for significance/Cell type

%Two independent t-test (alpha .05, two-tailed) to see if evoked response
%is above the noise

[h.vis,p_ttest.vis] = ttest2(onresponse.vis,onresponse.blank,.05,'both'); % Visual vs. Blank
[h.aud,p_ttest.aud] = ttest2(onresponse.aud,onresponse.blank,.05,'both'); % Auditory vs. Blank
[h.both,p_ttest.both] = ttest2(onresponse.both,onresponse.blank,.05,'both'); % Both vs. Blank

display(h)
display(p_ttest)

%% Alternative test for significance

%Analysis of variance followed by Tukey HSD

a = [onresponse.vis; onresponse.aud; onresponse.both; onresponse.blank]'; %Makes a vector with each column showing the
%number of spikes per trial

[p_anova,anova_table,anova_stats] = anova1(a);
display(p_anova)
figure(4)
multicomparisons = multcompare(anova_stats);












