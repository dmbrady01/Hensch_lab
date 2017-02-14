%Single Unit Analysis Program
%
%Combines all the necessary processing for a single unit:
%   -location: x,y,z coordinates
%   -firingrate: on and off response in increments of 100 msec for all
%                conditions + theoritical both
%   -multisensory calculations: facilitation and interaction in 100 msec
%                               increments
%   -peaktime: time to peak in all conditions
%
%   -graphs: PSTH, Raster, On Firing Rate, On Multisensory Int/Fac
%
%Written by D.M. Brady 6/2010

%% Parsing the data into timestamps of when events/spikes occurred

[timestamps,numberoftrials] = convert2timestamps(data); 
%Seperate function in 'Programs for SU' Folder
%used to organize data into a nicely organized structure
%will give you timestamps (every msec when an event or spike occured) as
%well as the number of trials

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

%% Generate PSTH

% Use the same pre, stim, and post window as rasters

window.window = 25; %length (in msecs) of bin (can play around)
window.step = 2; %time difference between centers of windows

% Creates a psth structure for spikes during window of interest. Very similar
% to rasters structure but have to include window.window to prevent cutting
% off edges. Not in seperate bins yet, just when spikes occured during
% window.

psth = {}; %Allocate variable so program is faster

for i = 1:length(timestamps.vis) %Visual trials
    psth.vis{i} = timestamps.spikes(timestamps.spikes > (timestamps.vis(i)-window.pre-(window.window/2))...
        & timestamps.spikes < (timestamps.vis(i)+window.stim+window.post-(window.window/2)))...
        - timestamps.vis(i);
    %Very similar to raster code but have to include and extra period of
    %time (equal to bin size) so that the edges are not cut off
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
centers = -window.pre:window.step:(window.stim+window.post); %centers of bins, length is the number of bins during trial

for i = 1:length(centers)
    spike_count.vis(i) = 0; %Create new struct of spikes within each bin
    spike_count.aud(i) = 0;
    spike_count.both(i) = 0;
    spike_count.blank(i) = 0;
    for j = 1:length(psth.vis) %Visual trials
        spike_count.vis(i) = spike_count.vis(i) + ((length(find(psth.vis{j} > (centers(i)-(window.window/2))...
            & psth.vis{j} < (centers(i)+(window.window/2)))))/((window.window/1000)*numberoftrials));
        %First we find the timestamps for the spikes that occured in each
        %bin and then take the length to get the number of spikes per bin.
        %To normalize to spikes/sec, we divide the spike counts by (number
        %of trials times the bin size)
    end

    for j = 1:length(psth.aud) %Auditory trials
        spike_count.aud(i) = spike_count.aud(i) + ((length(find(psth.aud{j} > (centers(i)-(window.window/2))...
            & psth.aud{j} < (centers(i)+(window.window/2)))))/((window.window/1000)*numberoftrials));
    end

    for j = 1:length(psth.both) %Both trials
        spike_count.both(i) = spike_count.both(i) + ((length(find(psth.both{j} > (centers(i)-(window.window/2))...
            & psth.both{j} < (centers(i)+(window.window/2)))))/((window.window/1000)*numberoftrials)); 
    end

    for j = 1:length(psth.blank) %Blank trials
        spike_count.blank(i) = spike_count.blank(i) + ((length(find(psth.blank{j} > (centers(i)-(window.window/2))...
            & psth.blank{j} < (centers(i)+(window.window/2)))))/((window.window/1000)*numberoftrials));
    end
end

%Plot PSTH
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
ylabel('Spikes/sec')

%If you want to set specific y values
%set(gca,'YTick',[10, 20, (29+10), (29+20), (29+29+10), (29+29+20)])
%set(gca,'YTickLabel',[10, 20])

%% Time to peak

peaktime = calctimetopeaksu(window.stim,centers,spike_count); 
%Seperate function in 'Programs for SU' Folder to calculate relevant peaks.
%Will be displayed

%% Mean Firing Rates

window.firingrates = 100:100:1000; %Windows to calculate firing rates (in msecs)
onresponse = [];
offresponse = [];

%On firing rate
for i = 1:length(window.firingrates) 
    for j = 1:length(timestamps.vis) %For Visual Stimuli
        onresponse.vis(j) = length(timestamps.spikes(timestamps.spikes > timestamps.vis(j) & ...
            timestamps.spikes < timestamps.vis(j)+window.firingrates(i)));
    end
    firingrate.on.vis(i) = mean(onresponse.vis)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.aud) %For Auditory Stimuli
        onresponse.aud(j) = length(timestamps.spikes(timestamps.spikes > timestamps.aud(j) & ...
            timestamps.spikes < timestamps.aud(j)+window.firingrates(i)));
    end
    firingrate.on.aud(i) = mean(onresponse.aud)*(window.stim/window.firingrates(i));
   
    for j = 1:length(timestamps.both) %For Visual + Auditory Stimuli
        onresponse.both(j) = length(timestamps.spikes(timestamps.spikes > timestamps.both(j) & ...
            timestamps.spikes < timestamps.both(j)+window.firingrates(i)));
    end
    firingrate.on.both(i) = mean(onresponse.both)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.blank) %For Blank Stimuli
        onresponse.blank(j) = length(timestamps.spikes(timestamps.spikes > timestamps.blank(j) & ...
            timestamps.spikes < timestamps.blank(j)+window.firingrates(i)));
    end
    firingrate.on.blank(i) = mean(onresponse.blank)*(window.stim/window.firingrates(i));
end

firingrate.on.theoreticalboth = firingrate.on.vis + firingrate.on.aud; %If you add vis and aud together

%Off firing rate
for i = 1:length(window.firingrates) 
    for j = 1:length(timestamps.vis) %For Visual Stimuli
        offresponse.vis(j) = length(timestamps.spikes(timestamps.spikes > timestamps.vis(j)+window.stim & ...
            timestamps.spikes < timestamps.vis(j)+window.stim+window.firingrates(i)));
    end
    firingrate.off.vis(i) = mean(offresponse.vis)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.aud) %For Auditory Stimuli
        offresponse.aud(j) = length(timestamps.spikes(timestamps.spikes > timestamps.aud(j)+window.stim & ...
            timestamps.spikes < timestamps.aud(j)+window.stim+window.firingrates(i)));
    end
    firingrate.off.aud(i) = mean(offresponse.aud)*(window.stim/window.firingrates(i));
   
    for j = 1:length(timestamps.both) %For Visual + Auditory Stimuli
        offresponse.both(j) = length(timestamps.spikes(timestamps.spikes > timestamps.both(j)+window.stim & ...
            timestamps.spikes < timestamps.both(j)+window.stim+window.firingrates(i)));
    end
    firingrate.off.both(i) = mean(offresponse.both)*(window.stim/window.firingrates(i));
    
    for j = 1:length(timestamps.blank) %For Blank Stimuli
        offresponse.blank(j) = length(timestamps.spikes(timestamps.spikes > timestamps.blank(j)+window.stim & ...
            timestamps.spikes < timestamps.blank(j)+window.stim+window.firingrates(i)));
    end
    firingrate.off.blank(i) = mean(offresponse.blank)*(window.stim/window.firingrates(i));
end

firingrate.off.theoreticalboth = firingrate.off.vis + firingrate.off.aud;

%% Multisensory Facilitation and Interaction

%Multisensory Facilitation: (Both-(Vis+Aud))/(Vis+Aud)*100

for i = 1:length(window.firingrates)
    multifac.on(i) = (firingrate.on.both(i)-firingrate.on.theoreticalboth(i))/firingrate.on.theoreticalboth(i)*100;
    multifac.off(i) = (firingrate.off.both(i)-firingrate.off.theoreticalboth(i))/firingrate.off.theoreticalboth(i)*100;
end

%Multisensory Interaction (Combined-Single)/Single*100
for i = 1:length(window.firingrates)
    if firingrate.on.vis(i) > firingrate.on.aud(i)
        multiint.on(i) = (firingrate.on.both(i)-firingrate.on.vis(i))/firingrate.on.vis(i)*100;
    else
        multiint.on(i) = (firingrate.on.both(i)-firingrate.on.aud(i))/firingrate.on.aud(i)*100;
    end
        
    if firingrate.off.vis(i) > firingrate.off.aud(i)
        multiint.off(i) = (firingrate.off.both(i)-firingrate.off.vis(i))/firingrate.off.vis(i)*100;
    else
        multiint.off(i) = (firingrate.off.both(i)-firingrate.off.aud(i))/firingrate.off.aud(i)*100;
    end
end

%% Display Data

peaktime
display('multifac')
multifac.on(end)
display('multiint')
multiint.on(end)

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

%% Getting location and depth information

y_or_n = questdlg('Do you want to put in coordinates?','s');

switch y_or_n
    case 'Yes'
        location.medial_lateral = input('Lateral distance from midline (mm)?');
        location.anterior_posterior = input('Anterior distance from midline/lambda intersection (mm)?');
        location.channel = input('What channel?');
        location.total_depth = input('Total depth of probe?');
        location.depth_unit = calcprobedepth(location.channel,location.total_depth);
        location
    case 'No'
        disp('no coordinates specified')
    otherwise
        disp('did not answer question with yes or no')
end

%% Save Data
%save('9710 P121NgRKOFemale pen1 ch7a - singleunitanalysis',...
%    'peaktime','firingrate','multifac','multiint', 'location',...
%    'spike_count','centers','psth','rasters','numberoftrials','timestamps')

 saveas(figure(1), '9811 P100DR+LightFemale pen3 ch14 - singleunitanalysis','pdf')
 saveas(figure(1), '9811 P100DR+LightFemale pen3 ch14 - singleunitanalysis','epsc')


