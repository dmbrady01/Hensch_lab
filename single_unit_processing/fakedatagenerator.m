%Makes fake data to test suanalysis
%
%Written by D.M. Brady 4/2010

%Making single trial
fake.vis = zeros(15*1000,4);
fake.aud = zeros(15*1000,4);
fake.both = zeros(15*1000,4);

fake.vis(3000,2) = 1; %Vis event trigger 3sec into trial
fake.aud(3000,3) = 1; %Aud event trigger 3sec into trial
fake.both(3000,2) = 1; fake.both(3000,3) = 1; %Both event triggers

fake.vis(8000,4) = 1; %Add blank events at 8sec
fake.aud(8000,4) = 1;
fake.both(8000,4) = 1;

%20 Trials
data = [fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both;
    fake.vis; fake.aud; fake.both];

data(1:end,1) = rand(length(data),1)>.97; %rand distro of spikes throughout trials