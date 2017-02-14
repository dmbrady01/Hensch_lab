%Simulation of Multisensory Integration Data - Change firing rate (lambda)
%
%Simulation using my metric for MI (MI = (CM-SM)/SM, CM = combined, SM =
%single modality) to make sure there is not an artifact for differences in
%firing rates
%
%Written by D.M. Brady May 2011


%% Make sure to load the parallel toolbox!

%matlabpool open n (n is number of servers, max is 4)
%matlabpool close

paroptions = statset('UseParallel','always'); %allows us to use parallel processing in certain functions


%% Setting up variables and random generator

tic %starts timer

minmod = 0; %minimal modulation possible (100% decrease in FR)
maxmod = 4; %maximal modulation V2(realistic = 6, other = 10); V1(realistic = 4, other = 10)
nneurons = 100; %number of neurons in simulation (realistic = 100, other = 1000)
ntrials = 20; %number of trials in our simulation

lambda = [2.35 3.9474 7.2000 7.475]; %different firing rates 
%V2(NgR, DR, LR: 3.0593 3.3462 6.2371); V1(NgR, DR, LR, OGAD: 3.0241 5.6185 9.9528 10.1962)
%medians V2(NgR, DR, LR: 1.8421 2.2105 4.9); V1(NgR, DR, LR, OGAD: 2.35 3.9474 7.2 7.475)

s = RandStream('swb2712','Seed',0); %Starts a random number generator at a particular seed
RandStream.setDefaultStream(s)

%% Preparing modulation

mod = cell(1,length(lambda));   
mod{1} = minmod + (maxmod-minmod)*rand(nneurons,1); %generates a column specifying the degree of modulation for each neuron
for i = 2:length(lambda)
    mod{i} = mod{1};
end

%figure(1),scatter(mod{1},mod{1}); %if you would like to look at the distribution of modulation

%% Generating Average Firing Rate of Neurons
%Assuming neurons have poisson-like behavior

SM = cell(1,length(lambda)); %Single stimulus condition
theoCM = cell(1,length(lambda)); %Theoritical combined condition
CM = cell(1,length(lambda)); %'Measured' combined condition

%The idea is to compare a theoritcal result for multisensory integration to
%a 'measured' one assuming that neurons behave in a poisson-like manner.
%First we create our baseline spike count (SM) for nneurons and ntrials based
%on a firing rate lambda. Our theoritical modulation (theoCM) is to take SM and
%multiply it by our modulation index (mod) made above. We compare this to a
%measured response by multiplying lambda by mod BEFORE drawing from a
%poisson distribution.
parfor i = 1:length(lambda)
    SM{i} = mean(poissrnd(lambda(i),nneurons,ntrials),2); %mean of ntrials in response to the single stimulus at a firing rate of lambda
    %2 denotes averaging the rows, not columns
    theoCM{i} = SM{i} .* mod{i}; %theorical response to modulation
    
    CM{i} = zeros(nneurons,1); %create a matrix for 'measured' combined stimuli
    for j = 1:length(mod{i})
        CM{i}(j) = mean(poissrnd(lambda(i).*mod{i}(j),1,ntrials),2); 
    end
end

%% Generating Multisensory Interaction Index
% MI = (CM-SM)/SM

MI = cell(1,length(lambda)); %'Measured' MI
theoMI = cell(1,length(lambda)); %'Theoritcal' MI

for i = 1:length(lambda)
    MI{i} = (CM{i}-SM{i})./ SM{i};
    theoMI{i} = (theoCM{i}-SM{i})./ SM{i};
    
    MInoinf{i} = MI{i}(find(isfinite(MI{i})==1 & isnan(theoCM{i})~=1)); %Gets rid of Inf and NaN
    theoMInoinf{i} = theoMI{i}(find(isfinite(MI{i})==1 & isnan(theoCM{i})~=1));
    modnoinf{i} = mod{i}(find(isfinite(MI{i})==1 & isnan(theoCM{i})~=1));
end

%% Plotting Theoritical vs. Measured

figure(9)

%Figuring out the axes
x_width = [minmod-1 maxmod-1]; %Limits of x-axis

y_min = ones(length(lambda),1);
y_max = ones(length(lambda),1);
for i = 1:length(lambda) %Figures out the max and min y values for MI under each lambda condition
    y_min(i) = min(MInoinf{i}); 
    y_max(i) = max(MInoinf{i});
end
y_width = [min(y_min) max(y_max)]; %Limits of y-axis is fixed to the largest and smallest y value for all groups (so all are on same scale)

for i = 1:length(lambda)
    subplot(length(lambda),3,3*i-2)
    hold on
    scatter(theoMInoinf{i},MInoinf{i})
    line((minmod-1):(maxmod-1),(minmod-1):(maxmod-1)) %Line to orient if theoritical is equal to measured
    axis([x_width y_width]); %sets axis
    text(0,.75*y_width(2),['FR: ' num2str(lambda(i)) ' spikes/sec']) %label of firing rate
    switch i
        case round(median(find(lambda>0)))
            ylabel('Measured MI') %labels y-axis of graphs
            set(gca,'xticklabel',[]) %gets rid of xtick labels except on bottom graph
        case length(lambda)
            xlabel('Theoritical MI') %labels x-axis of graphs
        otherwise
            set(gca,'xticklabel',[]) %gets rid of xtick labels except on bottom graph
    end  
end

%% Plotting Residuals

%Figuring out the axes
x_width = [minmod maxmod]; %Limits of x-axis

y_min = ones(length(lambda),1);
y_max = ones(length(lambda),1);
for i = 1:length(lambda)
    y_max(i) = max(MInoinf{i}-theoMI{i});
    %Figures out the max and min y values for residuals under each lambda condition
end
y_width = [-max(y_max) max(y_max)]; %To be used to fix all graphs to the same scale

for i = 1:length(lambda)
    subplot(length(lambda),3,3*i-1)
    hold on
    scatter(modnoinf{i},MInoinf{i}-theoMInoinf{i})
    line(minmod:maxmod,zeros(length(minmod:maxmod),1)) %Line to orient if theoritical is equal to measured
    axis([x_width y_width]); %sets axis
    switch i
        case round(median(find(lambda>0)))
            ylabel('Residuals (Measured-Theoritical)') %labels y-axis of graphs
            set(gca,'xticklabel',[]) %gets rid of xtick labels except on bottom graph
        case length(lambda)
            xlabel('Modulation') %labels x-axis of graphs
        otherwise
            set(gca,'xticklabel',[]) %gets rid of xtick labels except on bottom graph
    end 
    hold off
    subplot(length(lambda),3,3*i)
    hold on
    hist(MInoinf{i}-theoMInoinf{i},30)
    ylim = get(gca,'YLim');
    line([0 0],[0 max(ylim)])
    title(['Histogram of Residuals for ' num2str(lambda(i)) ' spikes/sec'])
end

%% Bootstrapping Data for IQR and Skewness

bootstrpstat = cell(1,length(lambda));
bootcistat = cell(1,length(lambda));

for i = 1:length(lambda)
    bootstrpstat{i} = bootstrp(10000,@(y) [iqr(y) length(find(y>0))./length(find(y<0))],...
        MInoinf{i}-theoMInoinf{i},'Options',paroptions);
    bootcistat{i} = bootci(10000,{@(y) [iqr(y) length(find(y>0))./length(find(y<0))],...
        MInoinf{i}-theoMInoinf{i}},'Options',paroptions);
end

%% Drawing Bootstrap Data

%Allocate some variabls
g = cell(1,length(lambda)); %for number in each bin
l = cell(1,length(lambda)); %for bin location
h = cell(1,length(lambda)); %handle for bar/histogram object
b = cell(1,length(lambda)); %handle for barchart

figure(10)
for i = 1:length(lambda)
    subplot(2,2,1), hold on, title('Bootstrap IQR')
    [g{i},l{i}] = hist(bootstrpstat{i}(:,1),30);
    b{i} = bar(l{i},g{i});
    h{i} = findobj(gca,'Type','patch');
    switch i
        case 1 %NGR
            set(h{i}(1),'FaceColor',[.5 .5 .5],'EdgeColor','k');
        case 2 %DR
            set(h{i}(1),'FaceColor','k','EdgeColor','k');
        case 3 %LR
            set(h{i}(1),'FaceColor','b','EdgeColor','b');
        case 4 %OGAD
            set(h{i}(1),'FaceColor','r','EdgeColor','r');
    end
end

for i = 1:length(lambda)
    subplot(2,2,3), hold on, title('Bootstrap +/- Ratio')
    [g{i},l{i}] = hist(bootstrpstat{i}(:,2),30);
    b{i} = bar(l{i},g{i});
    h{i} = findobj(gca,'Type','patch');
    switch i
        case 1 %NGR
            set(h{i}(1),'FaceColor',[.5 .5 .5],'EdgeColor','k');
        case 2 %DR
            set(h{i}(1),'FaceColor','k','EdgeColor','k');
        case 3 %LR
            set(h{i}(1),'FaceColor','b','EdgeColor','b');
        case 4 %OGAD
            set(h{i}(1),'FaceColor','r','EdgeColor','r');
    end
end

switch length(lambda)
    case 4
        subplot(2,2,2), hold on
        title('Bootstrap IQR')
        bar(1:length(lambda),[median(bootstrpstat{1}(:,1))  median(bootstrpstat{2}(:,1)) median(bootstrpstat{3}(:,1))...
            median(bootstrpstat{4}(:,1))])
        errorbar(1:length(lambda),[median(bootstrpstat{1}(:,1))  median(bootstrpstat{2}(:,1)) median(bootstrpstat{3}(:,1))...
            median(bootstrpstat{4}(:,1))],[std(bootstrpstat{1}(:,1))  std(bootstrpstat{2}(:,1)) std(bootstrpstat{3}(:,1))...
            std(bootstrpstat{4}(:,1))])

        subplot(2,2,4), hold on
        title('Bootstrap +/- Ratio')
        bar(1:length(lambda),[median(bootstrpstat{1}(:,2))  median(bootstrpstat{2}(:,2)) median(bootstrpstat{3}(:,2))...
            median(bootstrpstat{4}(:,2))])
        errorbar(1:length(lambda),[median(bootstrpstat{1}(:,2))  median(bootstrpstat{2}(:,2)) median(bootstrpstat{3}(:,2))...
            median(bootstrpstat{4}(:,2))],[std(bootstrpstat{1}(:,2))  std(bootstrpstat{2}(:,2)) std(bootstrpstat{3}(:,2))...
            std(bootstrpstat{4}(:,2))])
    case 3
        subplot(2,2,2), hold on
        title('Bootstrap IQR')
        bar(1:length(lambda),[median(bootstrpstat{1}(:,1))  median(bootstrpstat{2}(:,1)) median(bootstrpstat{3}(:,1))])
        errorbar(1:length(lambda),[median(bootstrpstat{1}(:,1))  median(bootstrpstat{2}(:,1)) median(bootstrpstat{3}(:,1))],...
            [std(bootstrpstat{1}(:,1))  std(bootstrpstat{2}(:,1)) std(bootstrpstat{3}(:,1))])

        subplot(2,2,4), hold on
        title('Bootstrap +/- Ratio')
        bar(1:length(lambda),[median(bootstrpstat{1}(:,2))  median(bootstrpstat{2}(:,2)) median(bootstrpstat{3}(:,2))])
        errorbar(1:length(lambda),[median(bootstrpstat{1}(:,2))  median(bootstrpstat{2}(:,2)) median(bootstrpstat{3}(:,2))],...
            [std(bootstrpstat{1}(:,2))  std(bootstrpstat{2}(:,2)) std(bootstrpstat{3}(:,2))])
end

    


%% Reset randomstream

reset(s) %resets the stream so that the same set of numbers are generated each time

toc %ends timer

%% look at iqr and skewness (maybe median too)





