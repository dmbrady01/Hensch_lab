% Reduces the number of blank trials
% Fixes mismatches on both trials
%
% Written by D.M. Brady Jan 2011


%% Fixing Mismatched Both Events

%To get rid of extra trials
%data(453184:end,2) = 0;
%data(453184:end,4) = 0;

% Find mismatched events
match = [find(data(:,2)==1) find(data(:,3)==1)];
difference = match(:,1)-match(:,2);

% Fix mismatch
for i = 1:length(difference)
    if difference(i) == 1
        data(match(i,1),2)=0;
        data(match(i,1)-1,2)=1;
    elseif difference(i) == -1
        data(match(i,2),3)=0;
        data(match(i,2)-1,3)=1;
    end
end

%Fixing Mismatch
%  data(514420,3) = 0;
%  data(514419,3) = 1;

%% Get rid of extra blanks
ntrials = 20; %Number of trials per stimuli

a = find(data(:,4) == 1); %Finds all the blank trials
a = Shuffle(a);  %Shuffles the timestamps in a random order
a = a(1:length(a)-ntrials); %Creates a vector of timestamps of extra blanks
data(a,4) = 0; %Gets rid of extra timestamps of 'a' in entire dataset

%% Get rid of extra both
% b = find(data(:,2)==1 & data(:,3)==1);
% b = Shuffle(b);
% b = b(1:length(b)-20);
% data(b,2)=0;
% data(b,3)=0;

%% Get rid of trials after twenty (four extra) 
%a = find(data(:,2) == 1); %Timestamps of visual stimuli
%a = a(21:end); %Keeps first 20 twenty timestamps (vis and vis+aud stimuli)

%b = find(data(:,3) == 1); %Same as a but for aud
%b = b(21:end);

%c = find(data(:,4) == 1); %Same as a but blank
%c = c(11:end);

%data(a,2) = 0;
%data(b,3) = 0;
%data(c,4) = 0;


%data(423091,3) = 0;
%data(423090,3) = 1;
