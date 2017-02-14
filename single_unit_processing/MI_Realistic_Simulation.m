% MI Realistic Simulation for Paper
%
% Similar to the other MI simulation programs but fine tuned for my
% dissertation/paper #2
%
% Written by D.M. Brady June 2011

%% Timer

tic %starts timer

%% Preparing parallel processing

%Make sure to type 'matlab pool open' before running this program to start
%parallel matlabs

%matlab pool open

paroptions = statset('UseParallel','always'); %tells random number generator to use parallel processing

%% Setting up variables

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%% FIRING RATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambda = [3.0593 3.3462 6.2371]; %different firing rates 
%V2(NgR, DR, LR: 3.0593 3.3462 6.2371); V1(NgR, DR, LR, OGAD: 3.0241 5.6185 9.9528 10.1962)
%medians V2(NgR, DR, LR: 1.8421 2.2105 4.9); V1(NgR, DR, LR, OGAD: 2.35 3.9474 7.2 7.475)

%lambda = logspace(0,2,3); %to explore lambda parameter space

%lambda = ones(1,3); %for exploring other parameters


%%%%%%%%%%%%%%%%%%%%%%%% MIN MODULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minmod = zeros(1,length(lambda)); %minimal modulation possible (100% decrease in FR)


%%%%%%%%%%%%%%%%%%%%%%%%% MAX MODULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxmod = 4*ones(1,length(lambda)); %maximal modulation V2(realistic = 6, other = 10); V1(realistic = 4, other = 10)

%maxmod = linspace(2,10,3); %to explore maxmod parameter space

%maxmod = 10*ones(1,length(lambda)); %to explore other parameters


%%%%%%%%%%%%%%%%%%%%%%%%% NUMBER OF NEURONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nneurons = [84 105 104]; %number of neurons in simulation (realistic = 100, other = 1000)
    %V2(NgR, DR, LR: 84 105 104); V1(NgR, DR, LR, OGAD: 71 118 127 66)

%nneurons = [50 100 500]; %to explore number of neurons parameter space

%nneurons = 500*ones(1,length(lambda)); %to explore other parameters
    

%%%%%%%%%%%%%%%%%%%%%%%%% NUMBER OF TRIALS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ntrials = 20*ones(1,length(lambda)); %number of trials in our simulation

%ntrials = linspace(10,50,3); %to explore number of trials parameter space

%ntrials = 10*ones(1,length(lambda)); %to explore other parameters


%%%%%%%%%%%%%%%%%%%%%%%%% OTHER VARIALBES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numrepeats = 1000; %number of times to repeat to do our bootstrapping

color = {[.5 .5 .5] 'k' 'b' 'r'}; %Color of bars

%% Setting up random number generator

%%%%%%%%%%%%%%%%%%%%%%%%%%% RANDOM NUMBER GENERATOR %%%%%%%%%%%%%%%%%%%%%%
s = RandStream('swb2712','Seed',50); %Starts a random number generator at a particular seed
RandStream.setGlobalStream(s)

%% Preparing modulation

%%%%%%%%%%%%%%%%%%%%%%%%%% PREPARING MODULATION %%%%%%%%%%%%%%%%%%%%%%%%%%
mod = cell(1,length(nneurons));   
parfor i = 1:length(nneurons)
    mod{i} = minmod(i) + (maxmod(i)-minmod(i))*rand(nneurons(i),1); %generates a column specifying the degree of modulation for each neuron
    mod{i} = repmat(mod{i},[1 1 numrepeats]);
end

%figure(1),scatter(mod{1},mod{1}); %if you would like to look at the distribution of modulation

%% Generating Average Firing Rate of Neurons
%Assuming neurons have poisson-like behavior

SM = cell(1,length(lambda)); %Single stimulus condition
theoCM = cell(1,length(lambda)); %Theoritical combined condition
CM = cell(1,length(lambda)); %'Measured' combined condition

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GENERATING FR of NEURONS %%%%%%%%%%%%%%%%%%
parfor i = 1:length(lambda)
    SM{i} = mean(poissrnd(lambda(i),[nneurons(i),ntrials(i),numrepeats]),2); 
    %mean of ntrials in response to the single stimulus at a firing rate of lambda
    %2 denotes averaging the rows, not columns
    theoCM{i} = SM{i} .* mod{i}; %theorical response to modulation
    
    CM{i} = zeros(nneurons(i),1,numrepeats); %create a matrix for 'measured' combined stimuli
    for j = 1:size(mod{i},1)
        for k = 1:size(mod{i},3)
            CM{i}(j,k) = mean(poissrnd(lambda(i).*mod{i}(j,k),1,ntrials(i)),2); 
        end
    end
end

toc
%% Generating Multisensory Interaction Index
% MI = (CM-SM)/SM

MI = cell(1,length(lambda)); %'Measured' MI
theoMI = cell(1,length(lambda)); %'Theoritcal' MI
MIdiff = cell(1,length(lambda));

%%%%%%%%%%%%%%%%%%%%%%%%%% GENERATING MI AND THEOMI %%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(lambda)
    MI{i} = (CM{i}-SM{i})./ SM{i};
    theoMI{i} = (theoCM{i}-SM{i})./ SM{i};
    MIdiff{i} = MI{i}-theoMI{i};
end

%% CDF Plot of MIdiff Data

figure

%%%%%%%%%%%%%%%%%%%%%%%% GENERATING CDFPLOT FOR MIDIFF %%%%%%%%%%%%%%%%%%%%
for j = 1:length(lambda)
    for i = 1:numrepeats
        h = cdfplot(MIdiff{j}(:,:,i));
        set(h,'Color',color{j})
        hold on
    end
end


%% CDF Plot of MI Data
% figure
% % 
% % %%%%%%%%%%%%%%%%%%%%%%%% GENERATING CDFPLOT FOR MI %%%%%%%%%%%%%%%%%%%%%%%%
% for j = 1:length(lambda)
%     for i = 1:numrepeats
%         h = cdfplot(MI{j}(:,:,i));
%         set(h,'Color',color{j})
%         hold on
%     end
% end
% 
%% CDF Plot of theoMI Data
 
figure
 
% %%%%%%%%%%%%%%%%%%%%%%%% GENERATING CDFPLOT FOR THEOMI %%%%%%%%%%%%%%%%%%%%
for j = 1:length(lambda)
    h = cdfplot(theoMI{j}(:,:,1));
    set(h,'Color',color{j},'LineWidth',2)
    hold on
end
% 
% if length(lambda)==3
%     legend(['FR: ' num2str(lambda(1)) ' spikes/sec'],['FR: ' num2str(lambda(2)) ' spikes/sec'],...
%         ['FR: ' num2str(lambda(3)) ' spikes/sec'], 'Location','best')
% elseif length(lambda)==4
%     legend(['FR: ' num2str(lambda(1)) ' spikes/sec'],['FR: ' num2str(lambda(2)) ' spikes/sec'],...
%         ['FR: ' num2str(lambda(3)) ' spikes/sec'],['FR: ' num2str(lambda(4)) ' spikes/sec'], 'Location','best')
% end

%% Sample Histogram and Bar Plot of Residuals

%%%%%%%%%%%%%%%%%%%%%%%% FIGURING OUT YLIMs %%%%%%%%%%%%%%%%%%%%
%Y Limit for Measured vs. Theoritical
y_minMT = ones(length(lambda),1);
y_maxMT = ones(length(lambda),1);
for i = 1:length(lambda)
    y_maxMT(i) = max(MI{i}(:,:,1));
    y_minMT(i) = min(MI{i}(:,:,1));
    %Figures out the max and min y values for residuals under each lambda condition
end
y_widthMT = [min(y_minMT) max(y_maxMT)]; %To be used to fix all graphs to the same scale

%Y Limit for Residuals
y_maxR = ones(length(lambda),1);
for i = 1:length(lambda)
    y_maxR(i) = max(MIdiff{i}(:,:,1));
    %Figures out the max and min y values for residuals under each lambda condition
end
y_widthR = [-max(y_maxR) max(y_maxR)]; %To be used to fix all graphs to the same scale

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAMPLE DATA FIGURE %%%%%%%%%%%%%%%%%%%%%%%%%%
figure
for i = 1:length(lambda)
    
    %%%%%%%%%%%%%%%%%% SCATTER MEASURED MI VS. THEO MI %%%%%%%%%%%%%%%%%%%%
%     subplot(length(lambda),4,4*i-3),hold on %If including histograms
    subplot(length(lambda),3,3*i-2), hold on
    ylabel('Measured MI')
    text(0,y_widthMT(2)*.8,[num2str(lambda(i)) ' spikes/sec'])
    h = line((minmod(i)-1):(maxmod(i)-1),(minmod(i)-1):(maxmod(i)-1)); %Reference Line
    set(h,'LineWidth',2,'LineStyle','-','Color','k')
    h = scatter(theoMI{i}(:,:,100),MI{i}(:,:,100)); %Scatter of TheoMI vs MI
    set(h,'MarkerEdgeColor',color{i});
    ylim(y_widthMT)
    xlim([minmod(i)-1 maxmod(i)-1])
    if i == 1
        title('Measured MI vs. Theoritical MI')
    elseif i == length(lambda)
        xlabel('Theoritical MI')
    end
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%% SCATTER RESIDUALS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     subplot(length(lambda),4,4*i-2), hold on
    subplot(length(lambda),3,3*i-1), hold on
    ylabel('Residuals')
    %text(0.5,y_width(2)./2,[num2str(lambda(i)) ' spikes/sec'])
    h = line([minmod(i) maxmod(i)],[0 0]); %Reference Line
    set(h,'LineWidth',2,'LineStyle','-','Color','k')
    h = scatter(mod{i}(:,:,100),MIdiff{i}(:,:,100)); %Scatter Residuals
    set(h,'MarkerEdgeColor',color{i});
    ylim(y_widthR);
    xlim([minmod(i) maxmod(i)])
    if i == 1
        title('Measured MI - Theoritical MI')
    elseif i == length(lambda)
        xlabel('Degree of Modulation')
    end
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%% HISTOGRAM RESIDUALS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     subplot(length(lambda),4,4*i-1),hold on
%     ylabel('Normalized Counts')
%     [count,bin] = hist(MIdiff{i}(:,:,1),30);
%     bar(bin,count./sum(count))
%     h = line([0 0], [0 max(count./sum(count))]);
%     set(h,'Color','r','Linewidth',2)
%     if i == 1
%         title('Normalized Histogram of Residuals')
%     elseif i == length(lambda)
%         xlabel('Residuals')
%     end
%     hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%% CDF RESIDUALS %%%%%%%%%%%%%%%%%%%%%%%%%%%
%     subplot(length(lambda),4,4*i),hold on
    subplot(length(lambda),3,3*i), hold on
    ylabel('Cumulative Fraction')
    h = cdfplot(MIdiff{i}(:,:,100));
    set(h,'LineWidth',2,'Color',color{i})
    h = line([0 0], [0 1]);
    set(h,'Color','r','Linestyle','--')
    if i == 1
        title('Normalized Histogram of Residuals')
    elseif i == length(lambda)
        xlabel('Residuals')
    end
    hold off
end


%% KS Test

%%%%%%%%%%%%%%%%%%%%%%%%%  KS TEST AGAINST GROUP 1 %%%%%%%%%%%%%%%%%%%%%%%
ks_h = cell(1,length(lambda)-1); %the number of times the ks test passes
ks_pvalue = cell(1,length(lambda)-1); %gives the actual p value for each test
ks_pvalue_ci = cell(1,length(lambda)-1); %to create a CI for the p value
ks_percent_pass = zeros(1,length(lambda)-1); %to see percentage of passes

for i = 1:length(lambda)-1
    for j = 1:numrepeats
        [ks_h{i}(j),ks_pvalue{i}(j)] = kstest2(MIdiff{1}(:,:,j),MIdiff{i+1}(:,:,j),.05,'unequal');
    end
    ks_percent_pass(i) = sum(ks_h{i})./length(ks_h{i})*100;
    ks_pvalue_ci{i} = [prctile(ks_pvalue{i},2.5) prctile(ks_pvalue{i},97.5)];
end  


figure
for i = 1:length(ks_pvalue_ci)
    
    %%%%%%%%%%%%%%%%%%%% HISTOGRAM OF BOOTSTRAP KS TEST %%%%%%%%%%%%%%%%%%%%
%     subplot(2,5,[1:3 6:8])
%     hold on
%     [count,bin] = hist(ks_pvalue{i},80);
%     h = bar(bin,count./sum(count));
%     set(h,'FaceColor',color{i})
%     h = line([.05 .05],[0 max(get(gca,'ylim'))]); %reference line to show alpha of 0.05
%     set(h,'Color','y','LineStyle','--','LineWidth',2)
%     xlabel('P Value')
%     ylabel('Normalized Count')
%     title('Histogram of P Values')
%     hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%% PLOT OF BOOTSTRAP KS TEST CI %%%%%%%%%%%%%%%%%%%%
%    subplot(2,5,[4:5 9:10])
    hold on
    title('Confidence Intervals of KS Test P Values')
%     bar(i,median(ks_pvalue{i})); %bar of median
    h = line([i-.125 i+.125],[median(ks_pvalue{i}) median(ks_pvalue{i})]); %median KS p value
    set(h,'LineWidth',5,'Color','r')
    text(i+.2,median(ks_pvalue{i}),['Pass Rate: ' num2str(ks_percent_pass(i)) '%']) %Text that gives the % of passes
    h = line([i i],[min(ks_pvalue_ci{i}) max(ks_pvalue_ci{i})]); %CI for p value
    set(h,'LineWidth',2,'Color','r')
    h = line([i-.125 i+.125],[min(ks_pvalue_ci{i}) min(ks_pvalue_ci{i})]); %horizontal bar for min CI p value (2.5%)
    set(h,'LineWidth',2,'Color','r')
    h = line([i-.125 i+.125],[max(ks_pvalue_ci{i}) max(ks_pvalue_ci{i})]); %horizontal bar for max CI p value (97.5%)
    set(h,'LineWidth',2,'Color','r')
    h = line([i-.5 i+.5],[0.05 0.05]); %reference line to show alpha of 0.05
    set(h,'LineWidth',2,'Color','k','LineStyle','--')
    ylabel('P Value')
    xlim([0.5 length(ks_pvalue_ci)+0.5])
    hold off
end

%% Median of Positively Modulated Cells

%%%%%%%%%%%%%% CALCULATING MEDIAN OF POSTIVELY MODULATED CELLS%%%%%%%%%%%%
med_pos_cells_ci = cell(1,length(lambda));
med_pos_cells = cell(1,length(lambda));

for i = 1:length(lambda)
    for j = 1:numrepeats
        med_pos_cells{i}(j) = median(MIdiff{i}(MIdiff{i}(:,:,j)>0,:,j));
    end
    med_pos_cells_ci{i} = [prctile(med_pos_cells{i},2.5) prctile(med_pos_cells{i},97.5)]; %creates CI for median of + cells
end
 
%%%%%%%%%%%%%% HISTOGRAM AND CI FOR + Modulated Cells %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MIsimbootfigure(lambda,color,med_pos_cells,med_pos_cells_ci,'Median of Positively Modulated Cells') 
%Function to make a figure of bootstrap data


%% IQR

%%%%%%%%%%%%%% CALCULATING IQR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
boot_iqr_ci = cell(1,length(lambda));
boot_iqr = cell(1,length(lambda));

for i = 1:length(lambda)
    for j = 1:numrepeats
        boot_iqr{i}(j) = iqr(MIdiff{i}(MIdiff{i}(:,:,j)>0,:,j));
    end
    boot_iqr_ci{i} = [prctile(boot_iqr{i},2.5) prctile(boot_iqr{i},97.5)];
end
 
%%%%%%%%%%%%%% HISTOGRAM AND CI FOR IQR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MIsimbootfigure(lambda,color,boot_iqr,boot_iqr_ci,'IQR') %Function to make a figure of bootstrap data

%% +/- Ratio

%%%%%%%%%%%%%% CALCULATING +/- Ratio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pnratio_ci = cell(1,length(lambda));
pnratio = cell(1,length(lambda));

for i = 1:length(lambda)
    for j = 1:numrepeats
        pnratio{i}(j) = length(MIdiff{i}(MIdiff{i}(:,:,j)>0,:,j))./length(MIdiff{i}(MIdiff{i}(:,:,j)<0,:,j));
    end
    pnratio_ci{i} = [prctile(pnratio{i},2.5) prctile(pnratio{i},97.5)];
end

%%%%%%%%%%%%%% HISTOGRAM AND CI FOR +/- Ratio %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MIsimbootfigure(lambda,color,pnratio,pnratio_ci,'+/- Ratio') %Function to make a figure of bootstrap data

%% Save Data

save MI_V2_Sim_Real_MeanFR_bootstrap_25June2011 %saves all variables
saveas(figure(1),'MI_V2_Sim_Real_MeanFR_bootstrap_25June2011_CDF_MIdiff','fig') %Saves CDF of MIdiff
% saveas(figure(2),'MI_FR_bootstrap_19June2011_CDF_MI','fig') %Saves CDF of MI
% saveas(figure(3),'MI_FR_bootstrap_19June2011_CDF_mod','fig') %Saves CDF of modulation
saveas(figure(2),'MI_V2_Sim_Real_MeanFR_bootstrap_25June2011_HIST_PLOT_Sample','fig') %Saves sample data
saveas(figure(3),'MI_V2_Sim_Real_MeanFR_bootstrap_25June2011_CI_KSTest','fig') %Saves KS Test
saveas(figure(4),'MI_V2_Sim_Real_MeanFR_bootstrap_25June2011_HIST_CI_MedPos','fig') %Saves Median of + Cells
saveas(figure(5),'MI_V2_Sim_Real_MeanFR_bootstrap_25June2011_HIST_CI_IQR','fig') %Saves IQR
saveas(figure(6),'MI_V2_Sim_Real_MeanFR_25June2011_HIST_CI_PNRatio','fig') %Saves PN Ratio


%% Reset randomstream

reset(s) %resets the stream so that the same set of numbers are generated each time

%% Timer

toc %Timer off







