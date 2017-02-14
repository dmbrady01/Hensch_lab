%Does all the analysis necessary for one animal after intrinsic imaging
%
%Written by D.M. Brady 2/2010

%NOTE!!! Before you run me, set your current directory to where you want
%the variables to be saved.

%% Parsing the data into the different trials/regions

%Converts imported data into textdata and data
imagingimportconversion

%Converts metamorph text file into a nicely structured file for matlab
%processing
[imagedata,numberofimages,step,time,numofdiffsessions] = convert2usable(textdata,data);
%Depending on matlab version, you might have to change convert2usable. Look
%at image.region to make sure there are 1, 2, and 3. If 0, must change
%string of 1 to number 1 or vice versa

%Seperating into different regions
V1 = imagedata.intensity(imagedata.region==1); %Will be the intensities with all V1 data 
%grouped together
V2 = imagedata.intensity(imagedata.region==2); %All V2 data
Ref = imagedata.intensity(imagedata.region==3); %All Ref data

%V1
Vis.V1 = V1(1:numberofimages); %Since visual trials are always first, we take out first run
%through of images (1-80)
Both.V1 = V1(numberofimages+1:2.*numberofimages); %Second set = both
Aud.V1 = V1(2.*numberofimages+1:end); %Third set = auditory only

%V2
Vis.V2 = V2(1:numberofimages);
Both.V2 = V2(numberofimages+1:2.*numberofimages);
Aud.V2 = V2(2.*numberofimages+1:end);

%Ref
Vis.Ref = Ref(1:numberofimages);
Both.Ref = Ref(numberofimages+1:2.*numberofimages);
Aud.Ref = Ref(2.*numberofimages+1:end);

%% Converting into percent change in fluorescence

%V1
Vis.V1 = convert2fluoro(Vis.V1,time);
Both.V1 = convert2fluoro(Both.V1,time);
Aud.V1 = convert2fluoro(Aud.V1,time);

%V2
Vis.V2 = convert2fluoro(Vis.V2,time);
Both.V2 = convert2fluoro(Both.V2,time);
Aud.V2 = convert2fluoro(Aud.V2,time);

%Ref
Vis.Ref = convert2fluoro(Vis.Ref,time);
Both.Ref = convert2fluoro(Both.Ref,time);
Aud.Ref = convert2fluoro(Aud.Ref,time);

%% Making Timelines with subtractions
x = 'time (sec)'; %label of x axis
y = '% change in fluorescence'; %label of y axis
baseline = zeros(numberofimages,1); %line y = 0 to compare to baseline

Vis.V1Sub = Vis.V1 - Vis.Ref; %V1 visual minus Ref visual
Vis.V2Sub = Vis.V2 - Vis.Ref;

Both.V1Sub = Both.V1 - Both.Ref;
Both.V2Sub = Both.V2 - Both.Ref;

Aud.V1Sub = Aud.V1 - Aud.Ref;
Aud.V2Sub = Aud.V2 - Aud.Ref;

%Visual only timeline
figure(1)
hold on
title('Visual Only','FontSize',24,'FontWeight','Bold')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',1.5)
xlabel(x,'FontSize',20)
ylabel(y,'FontSize',20)
%axis([0 9 -0.4 1.2])
plot(time,Vis.V1Sub,'r','LineWidth',1.5)
plot(time,Vis.V2Sub,'b','LineWidth',1.5)
legend('V1','V2')
plot(time,baseline,'k--','LineWidth',1.5)

%Both time
figure(2)
hold on
title('Both','FontSize',24,'FontWeight','Bold')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',1.5)
xlabel(x,'FontSize',20)
ylabel(y,'FontSize',20)
%axis([0 9 -0.4 1.2])
plot(time,Both.V1Sub,'r','LineWidth',1.5)
plot(time,Both.V2Sub,'b','LineWidth',1.5)
legend('V1','V2')
plot(time,baseline,'k--','LineWidth',1.5)

%Auditory only time
figure(3)
hold on
title('Auditory Only','FontSize',24,'FontWeight','Bold')
set(gca,'FontSize',15,'FontWeight','Bold','LineWidth',1.5)
xlabel(x,'FontSize',20)
ylabel(y,'FontSize',20)
%axis([0 9 -0.4 1.2])
plot(time,Aud.V1Sub,'r','LineWidth',1.5)
plot(time,Aud.V2Sub,'b','LineWidth',1.5)
legend('V1','V2')
plot(time,baseline,'k--','LineWidth',1.5)

%% Calculate peaks

framearound = round(.5/step); %Number of frames around peak to average

p.VisV1 = find(Vis.V1Sub == max(Vis.V1Sub(time>3 & time<(time(end)-framearound*step)))); 
%Gives frame number that is the peak between stimulation and .5 sec before end 
peak.VisV1 = mean(Vis.V1Sub(p.VisV1-framearound:p.VisV1+framearound)); %Peak value
peak.VisV1Time = time(p.VisV1)-3; %Time to peak after stimulation

p.VisV2 = find(Vis.V2Sub == max(Vis.V2Sub(time>3 & time<(time(end)-framearound*step))));
peak.VisV2 = mean(Vis.V2Sub(p.VisV2-framearound:p.VisV2+framearound));
peak.VisV2Time = time(p.VisV2)-3;

p.BothV1 = find(Both.V1Sub == max(Both.V1Sub(time>3 & time<(time(end)-framearound*step)))); 
peak.BothV1 = mean(Both.V1Sub(p.BothV1-framearound:p.BothV1+framearound));
peak.BothV1Time = time(p.BothV1)-3;

p.BothV2 = find(Both.V2Sub == max(Both.V2Sub(time>3 & time<(time(end)-framearound*step))));
peak.BothV2 = mean(Both.V2Sub(p.BothV2-framearound:p.BothV2+framearound));
peak.BothV2Time = time(p.BothV2)-3;

p.AudV1 = find(Aud.V1Sub == max(Aud.V1Sub(time>3 & time<(time(end)-framearound*step))));
peak.AudV1 = mean(Aud.V1Sub(p.AudV1-framearound:p.AudV1+framearound));
peak.AudV1Time = time(p.AudV1)-3;

p.AudV2 = find(Aud.V2Sub == max(Aud.V2Sub(time>3 & time<(time(end)-framearound*step))));
peak.AudV2 = mean(Aud.V2Sub(p.AudV2-framearound:p.AudV2+framearound));
peak.AudV2Time = time(p.AudV2)-3

%% Calculate trough

t.VisV1 = find(Vis.V1Sub == min(Vis.V1Sub(time>3 & time<(time(end)-framearound*step)))); 
%Gives frame number that is the trough between stimulation and .5 sec before end 
trough.VisV1 = mean(Vis.V1Sub(t.VisV1-framearound:t.VisV1+framearound)); %Trough value
trough.VisV1Time = time(t.VisV1)-3; %Time to trough after stimulation

t.VisV2 = find(Vis.V2Sub == min(Vis.V2Sub(time>3 & time<(time(end)-framearound*step))));
trough.VisV2 = mean(Vis.V2Sub(t.VisV2-framearound:t.VisV2+framearound));
trough.VisV2Time = time(t.VisV2)-3;

t.BothV1 = find(Both.V1Sub == min(Both.V1Sub(time>3 & time<(time(end)-framearound*step)))); 
trough.BothV1 = mean(Both.V1Sub(t.BothV1-framearound:t.BothV1+framearound));
trough.BothV1Time = time(t.BothV1)-3;

t.BothV2 = find(Both.V2Sub == min(Both.V2Sub(time>3 & time<(time(end)-framearound*step))));
trough.BothV2 = mean(Both.V2Sub(t.BothV2-framearound:t.BothV2+framearound));
trough.BothV2Time = time(t.BothV2)-3;

t.AudV1 = find(Aud.V1Sub == min(Aud.V1Sub(time>3 & time<(time(end)-framearound*step))));
trough.AudV1 = mean(Aud.V1Sub(t.AudV1-framearound:t.AudV1+framearound));
trough.AudV1Time = time(t.AudV1)-3;

t.AudV2 = find(Aud.V2Sub == min(Aud.V2Sub(time>3 & time<(time(end)-framearound*step))));
trough.AudV2 = mean(Aud.V2Sub(t.AudV2-framearound:t.AudV2+framearound));
trough.AudV2Time = time(t.AudV2)-3

%% Calculating multisensory facilitation and interaction

[multifac.V1,multiint.V1] = calcmultisensory(peak.VisV1,peak.AudV1,peak.BothV1);
%Will give a structure with multisensory facilitation and interaction for
%V1 and V2
[multifac.V2,multiint.V2] = calcmultisensory(peak.VisV2,peak.AudV2,peak.BothV2)

%% Calculating ratios

[ratio.BothV1,ratio.BothV2,ratio.AudV1,ratio.AudV2] = calcimratio(peak.BothV1,...
    peak.BothV2,peak.AudV1,peak.AudV2,peak.VisV1);
ratio %Displays ratio structure
%Will give a structure comparing the peak response in V1 and V2 for both
%and aud only trials compared to the standard peak (V1 Visual)

%% Saving important variables

save('test','Aud','Both','Vis','baseline','imagedata','multifac',...
'multiint','numberofimages','peak','ratio','step','time','trough')
saveas(figure(1), 'Test-Visual','pdf')
saveas(figure(2), 'Test-Both','pdf')
saveas(figure(3), 'Test-Auditory','pdf')
%Saves variable into a .mat file in the current directory. Change the first
%part for the filename. Remember to set up the proper current directory!

%two = load('7210 - P69NR2AFemale'); %puts all important variables into one nicely arranged
%structured variable, each mouse is given a specific number denoted by
%their order in their file

%save two %saves variable to current directory







