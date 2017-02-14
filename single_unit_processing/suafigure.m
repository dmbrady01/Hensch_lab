%Make sua figure
%
%To recreate figure made by singleunitanalysis without redoing all the
%calculations
%
%Written by D.M. Brady 6/2010

%% Generate Rasters

window.pre = 200; %Amount of time in msecs before the stimulus we plot
window.stim = 1000; %Length of stimulus (should be 1 second)
window.post = 200; %Amount of time in msecs after the stimulus we plot

rasters = {}; %Allocate variable so program is faster

%Prepare figure
figure(1); %This is the figure that will have four subplots: rasters, PSTH, 
           %firing rate, multisensory calculations
subplot(2,2,1) %First subplot for raster

%Make a rectangular box divided into four different sections for the four
%parts of the raster: blank, vis+aud, aud, and visual (from bottom to top)
hold on
rectangle('Position',[-200,0,1400,numberoftrials],'FaceColor',[1 1 1]); %White rectangle to delineate blank
rectangle('Position',[-200,numberoftrials,1400,numberoftrials],'FaceColor',[1 200/255 200/255]); %Light Pink (both)
rectangle('Position',[-200,2*numberoftrials,1400,numberoftrials],'FaceColor',[200/255 200/255 1]); %Light Blue (aud)
rectangle('Position',[-200,3*numberoftrials,1400,numberoftrials],'FaceColor',[1 1 200/255]); %Light Yellow (visual)
preparerasters((4*numberoftrials), window); %Seperate function that sets the x any y limits and draws the lines
                                            %indicating simtulus start/end
xlabel('Time (msec)')
ylabel('Trials')
set(gca,'YTick',[]) %Removes numbers from y-axis

% Draw Rasters
for i = 1:length(timestamps.vis) %Visual Trials
    rasters.vis{i} = timestamps.spikes(timestamps.spikes > (timestamps.vis(i)-window.pre)...
        & timestamps.spikes < (timestamps.vis(i)+window.stim+window.post)) - timestamps.vis(i);
        %creates an array that provides every timestamp when a spike
        %occured between the prestimulus period to after the postimulus
        %period (we subtract timestamps.vis(i) at the end to center it
        %around zero)
    for j = 1:length(rasters.vis{i})
        line([rasters.vis{i}(j) rasters.vis{i}(j)], [(3*numberoftrials)+i-1 (3*numberoftrials)+i]);
        %draws a line with x-coordinates equal to the corresponding
        %timestamp and y-cor to the trial (since the visual box is the top,
        %the y-cor are adjusted accordingly)
    end
end
for i = 1:length(timestamps.aud) %Auditory Trials
    rasters.aud{i} = timestamps.spikes(timestamps.spikes > (timestamps.aud(i)-window.pre)...
        & timestamps.spikes < (timestamps.aud(i)+window.stim+window.post)) - timestamps.aud(i);
    for j = 1:length(rasters.aud{i})
        line([rasters.aud{i}(j) rasters.aud{i}(j)], [(2*numberoftrials)+i-1 (2*numberoftrials)+i]);
    end
end
for i = 1:length(timestamps.both)  %Both Trials
    rasters.both{i} = timestamps.spikes(timestamps.spikes > (timestamps.both(i)-window.pre)...
        & timestamps.spikes < (timestamps.both(i)+window.stim+window.post)) - timestamps.both(i);
    for j = 1:length(rasters.both{i})
        line([rasters.both{i}(j) rasters.both{i}(j)], [(numberoftrials)+i-1 (numberoftrials)+i]);
    end
end
for i = 1:length(timestamps.blank) %Blank Trials
    rasters.blank{i} = timestamps.spikes(timestamps.spikes > (timestamps.blank(i)-window.pre)...
        & timestamps.spikes < (timestamps.blank(i)+window.stim+window.post)) - timestamps.blank(i);
    for j = 1:length(rasters.blank{i})
        line([rasters.blank{i}(j) rasters.blank{i}(j)], [i-1 i]);
    end
end

%% Plot PSTH
subplot(2,2,2)
hold on
[greatest] = preparepsths2(spike_count,window); %A seperate function that scales the x and y-axis to the length of
%the stimulus + pre and post periods and the largest bin throughout the
%three trial types

%Make a rectangle similar in design to rasters
rectangle('Position',[-200,2*greatest,1400,greatest],'FaceColor',[1 1 200/255]); %Light Yellow (vis)
rectangle('Position',[-200,greatest,1400,greatest],'FaceColor',[200/255 200/255 1]); %Light Blue (aud)
rectangle('Position',[-200,0,1400,greatest],'FaceColor',[1 200/255 200/255]); %Light Pink (vis+aud)

%Plot spike_count vs. centers for a psth line graph, blank will be dashed
plot(centers,2*greatest+spike_count.vis,'Color',[0 0 0],'LineWidth',1);
plot(centers,2*greatest+spike_count.blank,'b--','LineWidth',1);

plot(centers,greatest+spike_count.aud,'Color',[0 0 0],'LineWidth',1);
plot(centers,greatest+spike_count.blank,'b--','LineWidth',1);

plot(centers,spike_count.both,'Color',[0 0 0],'LineWidth',1)
plot(centers,spike_count.blank,'b--','LineWidth',1);

stimulus_start = line([0 0],[0 3*greatest]); %Creates a line indicating when stimulus started
set(stimulus_start,'Color','k','LineStyle','-','LineWidth',1)
stimulus_end = line([window.stim window.stim],[0 3*greatest]); %Creates a line indicating when stimulus ended
set(stimulus_end,'Color','k','LineStyle','--','LineWidth',1)
xlabel('Time (msec)')
ylabel('# of Spikes')

%If you want to set specific y values
%set(gca,'YTick',[10, 20, (29+10), (29+20), (29+29+10), (29+29+20)])
%set(gca,'YTickLabel',[10, 20])

%% Plot Firing Rate Info

%Look at firing rate with different size bins
subplot(2,2,3), hold on %On firing rate
plot(window.firingrates,firingrate.on.vis,'-yx')
plot(window.firingrates,firingrate.on.aud,'-bx')
plot(window.firingrates,firingrate.on.both,'-rx')
plot(window.firingrates,firingrate.on.blank,'--kx')
%legend('Visual','Auditory','Visual + Auditory','Blank')
title('On Firing Rate')
ylabel('Firing Rate (spikes/sec)')
xlabel('Time (msec)')

%Look at Multisensory Faciliation and Integration
zeroline = zeros(1,length(window.firingrates)); %Baseline (0% change)

subplot(2,2,4), hold on %On modulation
plot(window.firingrates,multifac.on,'-rx')
plot(window.firingrates,multiint.on,'-bx')
plot(window.firingrates,zeroline,'--k')
legend('Multi Fac','Multi Int')
title('On Response')
ylabel('Degree of Facilitation or Integration (%)')
xlabel('Time (msec)')

%% Save Data
saveas(figure(1), '122009 P117DRMale pen1 ch1a - singleunitanalysis','pdf')
saveas(figure(1), '122009 P117DRMale pen1 ch1a - singleunitanalysis','epsc')
