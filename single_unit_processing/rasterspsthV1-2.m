%Trying a different way to make figure 3

%% Organize Data

[timestamps,numberoftrials] = convert2timestamps(data); 
%Seperate function in 'Programs for SU' Folder
%used to organize data into a nicely organized structure

%% Generate Raster Information for A1

window.pre = 200; %Amount of time in msecs before the stimulus we plot
window.stim = 1000; %Length of stimulus (should be 1 second)
window.post = 200; %Amount of time in msecs after the stimulus we plot

rasters = {}; %Allocate variable so it is faster

rasters_figure = figure(1);
subplot(2,1,1)
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'inches');
set(gcf, 'PaperPosition', [.25 2.5 8 6])
hold on
rectangle('Position',[-200,0,1400,numberoftrials],'FaceColor',[1 1 1]); %White rectangle to delineate blank
%text(1050,numberoftrials-4,'Blank')
rectangle('Position',[-200,numberoftrials,1400,numberoftrials],'FaceColor',[1 1 200/255]); %Light Yellow
%text(1050,3*numberoftrials-4,'Visual')
preparerasters((2*numberoftrials), window);
set(gca,'YTick',[])
set(gca,'XTick',[])

% Raster for V1
for i = 1:length(timestamps.vis)
    rasters.vis{i} = timestamps.spikes(timestamps.spikes > (timestamps.aud(i)-window.pre)...
        & timestamps.spikes < (timestamps.vis(i)+window.stim+window.post)) - timestamps.vis(i);
    for j = 1:length(rasters.vis{i})
        line([rasters.vis{i}(j) rasters.vis{i}(j)], [(numberoftrials)+i-1 (numberoftrials)+i]);
    end
end
for i = 1:length(timestamps.blank)
    rasters.blank{i} = timestamps.spikes(timestamps.spikes > (timestamps.blank(i)-window.pre)...
        & timestamps.spikes < (timestamps.blank(i)+window.stim+window.post)) - timestamps.blank(i);
    for j = 1:length(rasters.blank{i})
        line([rasters.blank{i}(j) rasters.blank{i}(j)], [i-1 i]);
    end
end

%% Generate PSTH

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

%Plot PSTH
%psth_figure = figure(2);
subplot(2,1,2)
hold on

gvis = max(spike_count.vis);
xlim([-window.pre (window.stim+window.post)])
ylim([0 gvis])

%rectangle('Position',[-200,2*greatest,1400,greatest],'FaceColor',[1 1 200/255]); %Light Yellow
%text(1050,3*greatest-4,'Visual')

rectangle('Position',[-200,0,1400,gvis],'FaceColor',[1 1 200/255]); %Light Yellow
%text(1050,2*greatest-4,'Auditory')

%rectangle('Position',[-200,0,1400,greatest],'FaceColor',[1 200/255 200/255]); %Light Pink
%text(1050,greatest-4,'Vis + Aud')

%plot(centers,2*greatest+spike_count.vis,'Color',[0 0 0],'LineWidth',1);
%plot(centers,2*greatest+spike_count.blank,'b--','LineWidth',1);

plot(centers,spike_count.vis,'Color',[0 0 0],'LineWidth',1);
plot(centers,spike_count.blank,'b--','LineWidth',1);

%plot(centers,spike_count.both,'Color',[0 0 0],'LineWidth',1)
%plot(centers,spike_count.blank,'b--','LineWidth',1);

stimulus_start = line([0 0],[0 gvis]); %Creates a line indicating when stimulus started
set(stimulus_start,'Color','k','LineStyle','-','LineWidth',1)
stimulus_end = line([window.stim window.stim],[0 gvis]); %Creates a line indicating when stimulus ended
set(stimulus_end,'Color','k','LineStyle','--','LineWidth',1)

%set(gca,'YTick',[10, 20, 33, 43, 56, 66])
%set(gca,'YTickLabel',[10, 20])
%xlabel('Time (msecs)','FontSize',12,'FontName','Arial')

%% Save Figure

saveas(rasters_figure, '122009 - pen2ch1a - V1 Vis New','pdf')