%Does all the preliminary analysis for single unit recording
%
%Written by D.M. Brady 4/2010

%% Parsing the data into timestamps of when events/spikes occurred

[timestamps,numberoftrials] = convert2timestamps(data); 
%Seperate function in 'Programs for SU' Folder
%used to organize data into a nicely organized structure

%% Rasters

window.pre = 200; %Amount of time in msecs before the stimulus we plot
window.stim = 1000; %Length of stimulus (should be 1 second)
window.post = 200; %Amount of time in msecs after the stimulus we plot

rasters = {}; %Allocate variable so it is faster

% Raster for visual trials
for i = 1:length(timestamps.vis)
    rasters.vis{i} = timestamps.spikes(timestamps.spikes > (timestamps.vis(i)-window.pre)...
        & timestamps.spikes < (timestamps.vis(i)+window.stim+window.post)) - timestamps.vis(i); 
    %Creates a cell array (needs to be an array since there are different number of spikes
    %per trial) of all the spikes that occured between prestim window until
    %end of poststim window. Subtract timestamps.vis(i) at the end so that
    %all trials are centered around stimulus onset.
    rasters_figure = figure(1); 
    subplot(4,1,1), hold on 
    title('Visual Only')
    preparerasters(numberoftrials, window); %Seperate function in 'Programs for SU' folder. 
    %Provides a standard set of axes and stim on/off
    drawraster(rasters.vis,i); %Seperate function in 'Programs for SU' folder. 
    %Draws raster from cell array data. Must also be in a loop.
end

% Raster for auditory trials
for i = 1:length(timestamps.aud)
    rasters.aud{i} = timestamps.spikes(timestamps.spikes > (timestamps.aud(i)-window.pre)...
        & timestamps.spikes < (timestamps.aud(i)+window.stim+window.post)) - timestamps.aud(i);
    subplot(4,1,2), hold on
    title('Auditory Only')
    preparerasters(numberoftrials, window);
    drawraster(rasters.aud,i);
end

% Raster for both trials
for i = 1:length(timestamps.both)
    rasters.both{i} = timestamps.spikes(timestamps.spikes > (timestamps.both(i)-window.pre)...
        & timestamps.spikes < (timestamps.both(i)+window.stim+window.post)) - timestamps.both(i);
    subplot(4,1,3), hold on
    title('Visual + Auditory')
    preparerasters(numberoftrials, window);
    drawraster(rasters.both,i);
end

% Raster for blank trials
for i = 1:length(timestamps.blank)
    rasters.blank{i} = timestamps.spikes(timestamps.spikes > (timestamps.blank(i)-window.pre)...
        & timestamps.spikes < (timestamps.blank(i)+window.stim+window.post)) - timestamps.blank(i);
    subplot(4,1,4), hold on
    title('Blank')
    preparerasters(numberoftrials, window);
    drawraster(rasters.blank,i);
end

%% Post-stimulus time histograms

% Use the same pre, stim, and post window as rasters

window.window = 25; %length (in msecs) of bin (can play around)
window.step = 2; %time difference between centers of windows

% Creates a psth structure for spikes during window of interest. Very similar
% to rasters structure but have to include window.window to prevent cutting
% off edges. Not in seperate bins yet, just when spikes occured during
% window.

psth = {}; %Allocate variable so it is faster

for i = 1:length(timestamps.vis) %Visual trials
    psth.vis{i} = timestamps.spikes(timestamps.spikes > (timestamps.vis(i)-window.pre-(window.window/2))...
        & timestamps.spikes < (timestamps.vis(i)+window.stim+window.post-(window.window/2)))...
        - timestamps.vis(i);
end

for i = 1:length(timestamps.aud) %Auditory trials
    psth.aud{i} = timestamps.spikes(timestamps.spikes > (timestamps.aud(i)-window.pre-(window.window/2))...
        & timestamps.spikes < (timestamps.aud(i)+window.stim+window.post-(window.window/2)))...
        - timestamps.aud(i);
end

for i = 1:length(timestamps.both) %Both trials
    psth.both{i} = timestamps.spikes(timestamps.spikes > (timestamps.both(i)-window.pre-(window.window/2))...
        & timestamps.spikes < (timestamps.both(i)+window.stim+window.post-(window.window/2)))...
        - timestamps.both(i);
end

for i = 1:length(timestamps.blank) %Blank trials
    psth.blank{i} = timestamps.spikes(timestamps.spikes > (timestamps.blank(i)-window.pre-(window.window/2))...
        & timestamps.spikes < (timestamps.blank(i)+window.stim+window.post-(window.window/2)))...
        - timestamps.blank(i);
end

% Make structure spike_count with number of spikes within each bin
centers = -window.pre:window.step:(window.stim+window.post); %centers of bins

for i = 1:length(centers)
    spike_count.vis(i) = 0; %Create new struct of spikes within each bin
    spike_count.aud(i) = 0;
    spike_count.both(i) = 0;
    spike_count.blank(i) = 0;
    for j = 1:length(psth.vis) %Visual trials
        spike_count.vis(i) = spike_count.vis(i) + length(find(psth.vis{j} > (centers(i)-(window.window/2))...
            & psth.vis{j} < (centers(i)+(window.window/2))));
    end

    for j = 1:length(psth.aud) %Auditory trials
        spike_count.aud(i) = spike_count.aud(i) + length(find(psth.aud{j} > (centers(i)-(window.window/2))...
            & psth.aud{j} < (centers(i)+(window.window/2))));
    end

    for j = 1:length(psth.both) %Both trials
        spike_count.both(i) = spike_count.both(i) + length(find(psth.both{j} > (centers(i)-(window.window/2))...
            & psth.both{j} < (centers(i)+(window.window/2))));
    end

    for j = 1:length(psth.blank) %Blank trials
        spike_count.blank(i) = spike_count.blank(i) + length(find(psth.blank{j} > (centers(i)-(window.window/2))...
            & psth.blank{j} < (centers(i)+(window.window/2))));
    end
end

% Plot PSTHs
PSTH_figure = figure(2); 
a = subplot(3,1,1);
hold on  %Visual
plot(centers,spike_count.vis,'b');
plot(centers,spike_count.blank,'g--');
legend('Stimulus','Blank');
preparepsths(spike_count,window);
title('Visual Only')

b = subplot(3,1,2);
hold on %Auditory
preparepsths(spike_count,window);
plot(centers,spike_count.aud,'b-')  
plot(centers,spike_count.blank,'g--')
title('Auditory Only')

c = subplot(3,1,3);
hold on %Both
preparepsths(spike_count,window);
plot(centers,spike_count.both,'b-')
plot(centers,spike_count.blank,'g--')
title('Visual + Auditory')
xlabel('Time (msecs)')

%% Save Data

saveas(rasters_figure, '122109 P118DRMale pen5 ch12 - suanalysis - Rasters','pdf')
saveas(PSTH_figure, '122109 P118DRMale pen5 ch12 - suanalysis - PSTH','pdf')


   