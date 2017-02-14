%Does all the preliminary analysis for single unit recording - part 2
%
%Written by D.M. Brady 4/2010

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

%% Time to peak

within_time = input('Peak measured should be before what time (msecs)?'); 
%Peak must occur before specified time after stim onset
peaktime = calctimetopeaksu(within_time,centers,spike_count); 
%Seperate function in 'Programs for SU' Folder to calculate relevant peaks. Will be displayed

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

%% Response from Baseline - NOT USED RIGHT NOW

%WARNING: may be INF if blank is zero (bc you divide by zero)
%for i  = 1:length(window.firingrates)
 %   percent_from_baseline.on.vis(i) = (firingrate.on.vis(i)-firingrate.on.blank(i))./firingrate.on.blank(i)*100;
  %  percent_from_baseline.on.aud(i) = (firingrate.on.aud(i)-firingrate.on.blank(i))./firingrate.on.blank(i)*100;
   % percent_from_baseline.on.both(i) = (firingrate.on.both(i)-firingrate.on.blank(i))./firingrate.on.blank(i)*100;
    
%    percent_from_baseline.off.vis(i) = (firingrate.on.vis(i)-firingrate.off.blank(i))./firingrate.off.blank(i)*100;
 %   percent_from_baseline.off.aud(i) = (firingrate.on.aud(i)-firingrate.off.blank(i))./firingrate.off.blank(i)*100;
  %  percent_from_baseline.off.both(i) = (firingrate.on.both(i)-firingrate.off.blank(i))./firingrate.off.blank(i)*100;
%end

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
disp('Window Bin Sizes')
window.firingrates
disp('On Firing Rate')
firingrate.on
disp('Off Firing Rate')
firingrate.off
multifac
multiint

%% Plot Firing Rate Info

%Look at firing rate with different size bins
figure(3)
subplot(2,1,1), hold on %On firing rate
plot(window.firingrates,firingrate.on.vis,'-kx')
plot(window.firingrates,firingrate.on.aud,'-bx')
plot(window.firingrates,firingrate.on.both,'-rx')
plot(window.firingrates,firingrate.on.blank,'--cx')
legend('Visual','Auditory','Visual + Auditory','Blank')
title('On Firing Rate')
ylabel('Firing Rate (spikes/sec)')

subplot(2,1,2), hold on %Off firing rate
plot(window.firingrates,firingrate.off.vis,'-kx')
plot(window.firingrates,firingrate.off.aud,'-bx')
plot(window.firingrates,firingrate.off.both,'-rx')
plot(window.firingrates,firingrate.off.blank,'--cx')
legend('Visual','Auditory','Visual + Auditory','Blank')
title('Off Firing Rate')
ylabel('Firing Rate (spikes/sec)')
xlabel('Window Bin Size (msec)')

%Look at Multisensory Faciliation and Integration
zeroline = zeros(1,length(window.firingrates)); %Baseline (0% change)

figure(4)
subplot(2,1,1), hold on %On modulation
plot(window.firingrates,multifac.on,'-rx')
plot(window.firingrates,multiint.on,'-bx')
plot(window.firingrates,zeroline,'--k')
legend('Multisensory Facilitation','Multisensory Interaction')
title('On Response')
ylabel('Degree of Facilitation or Integration (%)')

subplot(2,1,2), hold on %Off modulation
plot(window.firingrates,multifac.off,'-rx')
plot(window.firingrates,multiint.off,'-bx')
plot(window.firingrates,zeroline,'--k')
legend('Multisensory Facilitation','Multisensory Interaction')
title('Off Response')
ylabel('Degree of Facilitation or Integration (%)')
xlabel('Window Bin Size (msec)')

%% Save Data
save('122109 P118DRMale pen5 ch12 - suanalysis2',...
    'peaktime','firingrate','multifac','multiint', 'location')
saveas(figure(3), '122109 P118DRMale pen5 ch12 - suanalysis2 - Firing Rates','pdf')
saveas(figure(4), '122109 P118DRMale pen5 ch12 - suanalysis2 - Multisensory Int and Fac','pdf')
    












    
    