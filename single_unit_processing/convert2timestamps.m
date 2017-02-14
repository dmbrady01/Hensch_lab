function [timestamps,numberoftrials] = convert2timestamps(data)
%Converts Data (from plexon) organized in an nx4 matrix (spikes, event4 (vis), event5 (aud),
%and event6 (blank)) into a neatly organized structure
%
%Written by D.M. Brady 4/2010

timestamps.spikes = find(data(:,1)>0); %finds every timestamp (TS) (in msecs) 
%when a spike is recorded
timestamps.vis = find(data(:,2)==1 & data(:,3)==0); %finds TS for visual event
timestamps.aud = find(data(:,2)==0 & data(:,3)==1); %finds TS for auditory event
timestamps.both = find(data(:,2)==1 & data(:,3)==1); %finds TS for vis+aud event
timestamps.blank = find(data(:,4)==1); %finds TS for blank event

%Since we might have a different number of trials for each condition, we
%must normalize by shuffling the trials
numberoftrials = min([length(timestamps.vis) length(timestamps.aud) length(timestamps.both)]);

timestamps.vis = Shuffle(timestamps.vis); %Shuffles trials
timestamps.vis = timestamps.vis(1:numberoftrials); %Reduces length to numberoftrials

timestamps.aud = Shuffle(timestamps.aud);
timestamps.aud = timestamps.aud(1:numberoftrials);

timestamps.both = Shuffle(timestamps.both);
timestamps.both = timestamps.both(1:numberoftrials);

timestamps.blank = Shuffle(timestamps.blank);
timestamps.blank = timestamps.blank(1:numberoftrials);