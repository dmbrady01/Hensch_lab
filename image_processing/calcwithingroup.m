%Calculates all averages and timelines within a specific group of animals
%Timelines: Vis, Aud, Both
%Bar Graphs: Peak, Time to Peak, Trough, Time to Trough, Multisensory
%Facilitation, Multisensory Interaction, and Ratio
%
%Written by D.M. Brady 2/2010

%NOTE!! Make sure you are in proper directory

%% Asks number of animals

user_entry = input('How many animals do you have so far?'); %Asks for the number of animals
%that you have imaged within that group so far. Make sure it is a number,
%not a word

%% Load variables into workspace

folder = uigetdir; %finds folder to upload, should be 'animals of interest'_chrono and all
%the contents should be numbered (one, two, etc.)

dirListing = dir(folder); %Produces a struct with the names/date/bytes/isdir info from that
%folder

for d = 1:length(dirListing) %Loops through the files and opens them.
    if ~dirListing(d).isdir %Makes sure files to be loaded are not already directories
        fileName = fullfile(folder,dirListing(d).name); %using full path since it might
        %not be the active path
        load(fileName) %open your files
    end
end

%% Stitch matching variables from each animal into different matricies

for i = 1:user_entry
    x = i;
    switch x %to make local variable x equal to a particular animal
        case 1
            x = one;
        case 2
            x = two;
        case 3
            x = three;
        case 4
            x = four;
        case 5
            x = five;
        case 6
            x = six;
        case 7
            x = seven;
        case 8
            x = eight;
        case 9
            x = nine;
        case 10
            x = ten;
        case 11
            x = eleven;
        case 12
            x = twelve;
        case 13
            x = thirteen;
        case 14
            x = fourteen;
        case 15
            x = fifteen;
        case 16
            x = sixteen;
        case 17
            x = seventeen;
        case 18
            x = eighteen;
        case 19
            x = nineteen;
        case 20
            x = twenty;
        otherwise
            disp('too many, modify calcwithingroup')
    end

    group.Vis.V1Sub(:,i) = x.Vis.V1Sub; %Groups similar variables together across animals
    group.Vis.V2Sub(:,i) = x.Vis.V2Sub;
    group.Both.V1Sub(:,i) = x.Both.V1Sub;
    group.Both.V2Sub(:,i) = x.Both.V2Sub;
    group.Aud.V1Sub(:,i) = x.Aud.V1Sub;
    group.Aud.V2Sub(:,i) = x.Aud.V2Sub;
    
    group.peak.VisV1(:,i) = x.peak.VisV1;
    group.peak.VisV1Time(:,i) = x.peak.VisV1Time;
    group.peak.VisV2(:,i) = x.peak.VisV2;
    group.peak.VisV2Time(:,i) = x.peak.VisV2Time;
    group.peak.BothV1(:,i) = x.peak.BothV1;
    group.peak.BothV1Time(:,i) = x.peak.BothV1Time;
    group.peak.BothV2(:,i) = x.peak.BothV2;
    group.peak.BothV2Time(:,i) = x.peak.BothV2Time;
    group.peak.AudV1(:,i) = x.peak.AudV1;
    group.peak.AudV1Time(:,i) = x.peak.AudV1Time;
    group.peak.AudV2(:,i) = x.peak.AudV2;
    group.peak.AudV2Time(:,i) = x.peak.AudV2Time;
    
    group.trough.VisV1(:,i) = x.trough.VisV1;
    group.trough.VisV1Time(:,i) = x.trough.VisV1Time;
    group.trough.VisV2(:,i) = x.trough.VisV2;
    group.trough.VisV2Time(:,i) = x.trough.VisV2Time;
    group.trough.BothV1(:,i) = x.trough.BothV1;
    group.trough.BothV1Time(:,i) = x.trough.BothV1Time;
    group.trough.BothV2(:,i) = x.trough.BothV2;
    group.trough.BothV2Time(:,i) = x.trough.BothV2Time;
    group.trough.AudV1(:,i) = x.trough.AudV1;
    group.trough.AudV1Time(:,i) = x.trough.AudV1Time;
    group.trough.AudV2(:,i) = x.trough.AudV2;
    group.trough.AudV2Time(:,i) = x.trough.AudV2Time;
    
    group.multifac.V1(:,i) = x.multifac.V1;
    group.multifac.V2(:,i) = x.multifac.V2;
    
    group.multiint.V1(:,i) = x.multiint.V1;
    group.multiint.V2(:,i) = x.multiint.V2;
    
    group.ratio.BothV1(:,i) = x.ratio.BothV1;
    group.ratio.BothV2(:,i) = x.ratio.BothV2;
    group.ratio.AudV1(:,i) = x.ratio.AudV1;
    group.ratio.AudV2(:,i) = x.ratio.AudV2;
    
    group.numberofimages = x.numberofimages;
    group.step = x.step;
    group.time = x.time;
    group.baseline = x.baseline;
end

%% Calculate averages, standard deviations, and standard errors

for j = 1:numberofimages
    group.Vis.V1SubAvg(j) = mean(group.Vis.V1Sub(j,:));
    group.Vis.V1SubSD(j) = std(group.Vis.V1Sub(j,:));
    group.Vis.V1SubSE(j) = SEM(group.Vis.V1Sub(j,:));
    
    group.Vis.V2SubAvg(j) = mean(group.Vis.V2Sub(j,:));
    group.Vis.V2SubSD(j) = std(group.Vis.V2Sub(j,:));
    group.Vis.V2SubSE(j) = SEM(group.Vis.V2Sub(j,:));
    
    group.Both.V1SubAvg(j) = mean(group.Both.V1Sub(j,:));
    group.Both.V1SubSD(j) = std(group.Both.V1Sub(j,:));
    group.Both.V1SubSE(j) = SEM(group.Both.V1Sub(j,:));
    
    group.Both.V2SubAvg(j) = mean(group.Both.V2Sub(j,:));
    group.Both.V2SubSD(j) = std(group.Both.V2Sub(j,:));
    group.Both.V2SubSE(j) = SEM(group.Both.V2Sub(j,:));
    
    group.Aud.V1SubAvg(j) = mean(group.Aud.V1Sub(j,:));
    group.Aud.V1SubSD(j) = std(group.Aud.V1Sub(j,:));
    group.Aud.V1SubSE(j) = SEM(group.Aud.V1Sub(j,:));
    
    group.Aud.V2SubAvg(j) = mean(group.Aud.V2Sub(j,:));
    group.Aud.V2SubSD(j) = std(group.Aud.V2Sub(j,:));
    group.Aud.V2SubSE(j) = SEM(group.Aud.V2Sub(j,:));
    
    group.peak.VisV1Avg = mean(group.peak.VisV1);
end

group.Vis.V1SubAvg = group.Vis.V1SubAvg';
group.Vis.V1SubSD = group.Vis.V1SubSD';
group.Vis.V1SubSE = group.Vis.V1SubSE';
    
group.Vis.V2SubAvg = group.Vis.V2SubAvg';
group.Vis.V2SubSD = group.Vis.V2SubSD';
group.Vis.V2SubSE = group.Vis.V2SubSE';
    
group.Both.V1SubAvg = group.Both.V1SubAvg';
group.Both.V1SubSD = group.Both.V1SubSD';
group.Both.V1SubSE = group.Both.V1SubSE';
    
group.Both.V2SubAvg = group.Both.V2SubAvg';
group.Both.V2SubSD = group.Both.V2SubSD';
group.Both.V2SubSE = group.Both.V2SubSE';
    
group.Aud.V1SubAvg = group.Aud.V1SubAvg';
group.Aud.V1SubSD = group.Aud.V1SubSD';
group.Aud.V1SubSE = group.Aud.V1SubSE';
    
group.Aud.V2SubAvg = group.Aud.V2SubAvg';
group.Aud.V2SubSD = group.Aud.V2SubSD';
group.Aud.V2SubSE = group.Aud.V2SubSE';
