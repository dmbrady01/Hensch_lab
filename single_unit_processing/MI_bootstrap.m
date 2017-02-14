%Median and slope (spread) calculations of MI distribution using
%bootstrapping
%
%
%Instead of using empirical cdfs or fitted gaussians to compare the MI
%distributions between animal groups, Nao suggested to use the
%bootstrapping method to compare median and slope (spread).
%
%Written by D.M. Brady June 2011

%% Make sure to load the parallel toolbox!

%matlabpool open n (n is number of servers, max is 4)
%matlabpool close

paroptions = statset('UseParallel','always'); %allows us to use parallel processing in certain functions

%% Load relevant data and prepare names

tic %timer on

%load MI_version1 %loads variable MI which has all the relevant data
load MI_version6 %has 2 NR2A animal included
%load MI_overlap

name = {'DR' 'LR' 'NGR' 'OGAD' 'NR2A' 'DR_Light'}; %name of animal group
region = {'V1' 'V2' 'AC'}; %name of regions recorded
color = {'k' 'b' [.5 .5 .5] 'r' 'y' 'c'};


%% Making histograms and cdf of observed data

%Allocate some variabls
g = cell(1,length(name)); %for number in each bin
l = cell(1,length(name)); %for bin location
h = cell(1,length(name)); %handle for bar/histogram object
b = cell(1,length(name)); %handle for barchart

for j = 1:length(region)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MEDIAN RAW DATA HISTOGRAM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(name)
        figure(1), subplot(length(region),2,2*j-1), hold on, title(['Histogram of MI Distribution in ' region{j}])
        try
            [g{i},l{i}] = hist(MI.(name{i}).(region{j}),30); %values for histogram
            b{i} = bar(l{i},g{i}); %makes a bar graph using the values from g{i} and l{i}
            h{i} = findobj(gca,'Type','patch');
            set(h{i}(1),'FaceColor',color{i},'EdgeColor',color{i});
            ylim = get(gca,'YLim'); %to get the y limit of the histograms
            line([median(MI.(name{i}).(region{j})) median(MI.(name{i}).(region{j}))],...
                [min(ylim) max(ylim)],'Color','y'); %line showing where the median is
            line([0 0],[min(ylim) max(ylim)],'Color','k'); %line showing where zero is
        catch err
            continue
        end
    end
    switch j
        case 1
            h{4} = flipud(h{4}); %flips the order of the handle so that DR will be on top
            legend(h{4}(1:end),name{1},name{2},name{3},name{4},name{5}) %depending on the region, there is a different legend
        case 2
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
        case 3
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
    end
    h = cell(1,length(name));
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MEDIAN RAW DATA CDF  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hand = zeros(1,length(name));
    for i = 1:length(name)
        figure(1), subplot(length(region),2,2*j), hold on, title(['CDF of MI Distribution in ' region{j}])
        try
            hand(i) = cdfplot(MI.(name{i}).(region{j})); %makes a cdfplot
            set(hand(i),'Color',color{i});
            ylim = get(gca,'YLim');
            line([median(MI.(name{i}).(region{j})) median(MI.(name{i}).(region{j}))],...
                [min(ylim) max(ylim)],'Color','y');
            line([0 0],[min(ylim) max(ylim)],'Color','k'); %line showing where zero is
        catch err
            continue
        end
    end
    switch j
        case 1
            legend(hand(1:end),name{1},name{2},name{3},name{4},name{5})
        case 2
            legend(hand(1:end-1),name{1},name{2},name{3})
        case 3
            legend(hand(1:end-1),name{1},name{2},name{3})
    end
end

%% Calculating median for + cells, iqr, +/- ratio, and skewness of distributions

numtrials = 100000; %number of trials we run (100,000 seems to be a good number from simulation)

for i = 1:length(name)
    for j = 1:length(region)
        try
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  BOOTSTRAPPING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            MIboot.(name{i}).(region{j}).boot.bootstrptrials = bootstrp(numtrials,@(y) ...
                [median(y(y>0)) iqr(y) length(find(y>0))./length(find(y<0))],MI.(name{i}).(region{j}),'Options',paroptions); 
            %will give the distribution of [median iqr pos/neg] for each group
            MIboot.(name{i}).(region{j}).boot.bootstrpci = bootci(numtrials,{@(y) ...
                [median(y(y>0)) iqr(y) length(find(y>0))./length(find(y<0))],MI.(name{i}).(region{j})},'Options',paroptions);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Median, sd of median, ci of median  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            MIboot.(name{i}).(region{j}).boot.med = median(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,1)); %calculates center
            %(median) of sampling distribution of the median
            MIboot.(name{i}).(region{j}).boot.med_sd = std(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,1)); %calculates standard
            %deviation of the sampling distribution (similar to standard
            %error of the population. Used for error bars
            MIboot.(name{i}).(region{j}).boot.med_ci = MIboot.(name{i}).(region{j}).boot.bootstrpci(:,1);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Iqr, sd of Iqr, ci of Iqr  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            MIboot.(name{i}).(region{j}).boot.iqr = median(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,2)); %calculates median of
            %sampling distribution of the interquartile range (using it as a measure of spread of
            %modulation (slope of cdf))
            MIboot.(name{i}).(region{j}).boot.iqr_sd = std(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,2)); %calculates standard
            %deviation of the sampling distribution of iqr (used for error
            %bars)
            MIboot.(name{i}).(region{j}).boot.iqr_ci = MIboot.(name{i}).(region{j}).boot.bootstrpci(:,2);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  +/- ratio, sd of +/- ratio, ci of +/-  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            MIboot.(name{i}).(region{j}).boot.pnratio = median(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,3)); 
            %calculates median of sampling distribution of the positive/negative ratio
            MIboot.(name{i}).(region{j}).boot.pnratio_sd = std(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,3)); %calculates standard
            %deviation of the sampling distribution of iqr (used for error
            %bars)
            MIboot.(name{i}).(region{j}).boot.pnratio_ci = MIboot.(name{i}).(region{j}).boot.bootstrpci(:,3);
        catch err
            continue
        end
    end
end

%% Histograms of median, iqr, p/n ratio

%Allocate some variabls
g = cell(1,length(name)); %for number in each bin
l = cell(1,length(name)); %for bin location
h = cell(1,length(name)); %handle for bar/histogram object
b = cell(1,length(name)); %handle for barchart

%Very similar structure to making histograms in figure(1)
for j = 1:length(region)   
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MEDIAN BOOT HISTOGRAM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(name)
        figure(2), subplot(length(region),4,4*j-3:4*j-2), hold on, title([region{j} ' Sampling Distribution of the (+) Median'])
        try
            [g{i},l{i}] = hist(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,1),30);
            b{i} = bar(l{i},g{i});
            h{i} = findobj(gca,'Type','patch');
            set(h{i}(1),'FaceColor',color{i},'EdgeColor',color{i});
            ylim = get(gca,'YLim');
            line([MIboot.(name{i}).(region{j}).boot.med MIboot.(name{i}).(region{j}).boot.med],...
                [min(ylim) max(ylim)],'Color','y');
        catch err
            continue
        end
    end
    switch j
        case 1
            h{4} = flipud(h{4});
            legend(h{4}(1:end),name{1},name{2},name{3},name{4},name{5})
        case 2
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
        case 3
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
    end
    h = cell(1,length(name));
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  IQR BOOT HISTOGRAM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(name)
        figure(3), subplot(length(region),4,4*j-3:4*j-2), hold on, title([region{j} ' Sampling Distribution of the IQR'])
        try
            [g{i},l{i}] = hist(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,2),30);
            b{i} = bar(l{i},g{i});
            h{i} = findobj(gca,'Type','patch');
            set(h{i}(1),'FaceColor',color{i},'EdgeColor',color{i});
            ylim = get(gca,'YLim');
            line([MIboot.(name{i}).(region{j}).boot.iqr MIboot.(name{i}).(region{j}).boot.iqr],...
                [min(ylim) max(ylim)],'Color','y');
        catch err
            continue
        end
    end
    switch j
        case 1
            h{4} = flipud(h{4});
            legend(h{4}(1:end),name{1},name{2},name{3},name{4},name{5})
        case 2
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
        case 3
            h{3} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
    end
    h = cell(1,length(name));
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  +/- RATIO BOOT HISTOGRAM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:length(name)
        figure(4), subplot(length(region),4,4*j-3:4*j-2), hold on, title([region{j} ' Sampling Distribution of the +/- Ratio'])
        try
            [g{i},l{i}] = hist(MIboot.(name{i}).(region{j}).boot.bootstrptrials(:,3),30);
            b{i} = bar(l{i},g{i});
            h{i} = findobj(gca,'Type','patch');
            set(h{i}(1),'FaceColor',color{i},'EdgeColor',color{i});
            ylim = get(gca,'YLim');
            line([MIboot.(name{i}).(region{j}).boot.pnratio MIboot.(name{i}).(region{j}).boot.pnratio],...
                [min(ylim) max(ylim)],'Color','y');
        catch err
            continue
        end
    end
    switch j
        case 1
            h{4} = flipud(h{4});
            legend(h{4}(1:end),name{1},name{2},name{3},name{4},name{5})
        case 2
            h{4} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
        case 3
            h{4} = flipud(h{3});
            legend(h{3}(1:end),name{1},name{2},name{3})
    end
    h = cell(1,length(name));
    hold off
end

%% Bar graphs of bootstrap results with sd error bars

for i = 1:length(region)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MEDIAN BOOT BARGRAPH + ERROR  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(2), subplot(length(region),4,4*i-1), hold on, title([region{i} ' (+) Median + errorbars'])
    for j = 1:length(name)
        try
            h = bar(j,MIboot.(name{j}).(region{i}).boot.med);
            set(h,'FaceColor',color{j})
            h = errorbar(j, MIboot.(name{j}).(region{i}).boot.med, MIboot.(name{j}).(region{i}).boot.med_sd);
            set(h,'Color',color{j})
            xlim([0 j+1])
        catch err
            continue
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  IQR BOOT BARGRAPH + ERROR  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3), subplot(length(region),4,4*i-1), hold on, title([region{i} ' IQR + errorbars'])
    for j = 1:length(name)
        try
            h = bar(j,MIboot.(name{j}).(region{i}).boot.iqr);
            set(h,'FaceColor',color{j})
            h = errorbar(j, MIboot.(name{j}).(region{i}).boot.iqr, MIboot.(name{j}).(region{i}).boot.iqr_sd);
            set(h,'Color',color{j})
            %set(h,'Color',color{j},'LineWidth',2)
            xlim([0 j+1])
        catch err
            continue
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  +/- RATIO BOOT BARGRAPH + ERROR  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4), subplot(length(region),4,4*i-1), hold on, title([region{i} ' +/- Ratio + errorbars'])
    for j = 1:length(name)
        try
            h = bar(j,MIboot.(name{j}).(region{i}).boot.pnratio);
            set(h,'FaceColor',color{j})
            h = errorbar(j, MIboot.(name{j}).(region{i}).boot.pnratio, MIboot.(name{j}).(region{i}).boot.pnratio_sd);
            %set(h,'Color',color{j})
            set(h,'Color',color{j},'LineWidth',2)
            xlim([0 j+1])
        catch err
            continue
        end
    end
end

%% Bar graphs of bootstrap results with 95% confidence intervals

for i = 1:length(region)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  MEDIAN BOOT BARGRAPH + 95% CI  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(2), subplot(length(region),4,4*i), hold on, title([region{i} ' (+) Median + 95% CI'])
    for j = 1:length(name)
        try
            h = line([j-.125 j+.125],[MIboot.(name{j}).(region{i}).boot.med MIboot.(name{j}).(region{i}).boot.med]); 
            %median (+) median value
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j j],[min(MIboot.(name{j}).(region{i}).boot.med_ci) max(MIboot.(name{j}).(region{i}).boot.med_ci)]); 
            %CI for (+) median
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[min(MIboot.(name{j}).(region{i}).boot.med_ci) min(MIboot.(name{j}).(region{i}).boot.med_ci)]); 
            %horizontal bar for min CI p value (2.5%)
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[max(MIboot.(name{j}).(region{i}).boot.med_ci) max(MIboot.(name{j}).(region{i}).boot.med_ci)]); 
            %horizontal bar for max CI p value (97.5%)
            set(h,'LineWidth',2,'Color',color{j})
            xlim([0 j+1])
        catch err
            continue
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  IQR BOOT BARGRAPH + 95% CI  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(3), subplot(length(region),4,4*i), hold on, title([region{i} ' IQR + 95% CI'])
    for j = 1:length(name)
        try
            h = line([j-.125 j+.125],[MIboot.(name{j}).(region{i}).boot.iqr MIboot.(name{j}).(region{i}).boot.iqr]); 
            %median (+) median value
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j j],[min(MIboot.(name{j}).(region{i}).boot.iqr_ci) max(MIboot.(name{j}).(region{i}).boot.iqr_ci)]); 
            %CI for (+) median
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[min(MIboot.(name{j}).(region{i}).boot.iqr_ci) min(MIboot.(name{j}).(region{i}).boot.iqr_ci)]); 
            %horizontal bar for min CI p value (2.5%)
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[max(MIboot.(name{j}).(region{i}).boot.iqr_ci) max(MIboot.(name{j}).(region{i}).boot.iqr_ci)]); 
            %horizontal bar for max CI p value (97.5%)
            set(h,'LineWidth',2,'Color',color{j})
            xlim([0 j+1])
        catch err
            continue
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  +/- RATIO BOOT BARGRAPH + 95% CI  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(4), subplot(length(region),4,4*i), hold on, title([region{i} ' +/- Ratio + 95% CI'])
    for j = 1:length(name)
        try
            h = line([j-.125 j+.125],[MIboot.(name{j}).(region{i}).boot.pnratio MIboot.(name{j}).(region{i}).boot.pnratio]); 
            %median (+) median value
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j j],[min(MIboot.(name{j}).(region{i}).boot.pnratio_ci) max(MIboot.(name{j}).(region{i}).boot.pnratio_ci)]); 
            %CI for (+) median
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[min(MIboot.(name{j}).(region{i}).boot.pnratio_ci)...
                min(MIboot.(name{j}).(region{i}).boot.pnratio_ci)]); %horizontal bar for min CI p value (2.5%)
            set(h,'LineWidth',2,'Color',color{j})
            h = line([j-.125 j+.125],[max(MIboot.(name{j}).(region{i}).boot.pnratio_ci)...
                max(MIboot.(name{j}).(region{i}).boot.pnratio_ci)]); %horizontal bar for max CI p value (97.5%)
            set(h,'LineWidth',2,'Color',color{j})
            xlim([0 j+1])
        catch err
            continue
        end
    end
end

%% Binomial Distribution Analysis of PN Ratio
%To see the chance that we could get the PN Ratio observed if + and - cells were
%equally likely (calculates either that many below half or that many above
%half depending on which side the question a group lies)

for i = 1:length(region)
    try
        for j = 1:length(name)
            if length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})>0))>length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})<0))
                MIboot.(name{j}).(region{i}).boot.bino_p = 1-binocdf(length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})>0))-1,...
                    length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})~=0)),.5);
            else
                MIboot.(name{j}).(region{i}).boot.bino_p = 1-binocdf(length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})<0))-1,...
                    length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})~=0)),.5);
            end
        end
    catch err
        continue
    end
end

%% Save
save Real_MI_Bootstrap_13DEC2012
saveas(figure(1),'Real_MI_Bootstrap_13DEC2012_RawData','fig')
saveas(figure(2),'Real_MI_Bootstrap_13DEC2012_PosMed','fig')
saveas(figure(3),'Real_MI_Bootstrap_13DEC2012_IQR','fig')
saveas(figure(4),'Real_MI_Bootstrap_13DEC2012_PNRatio','fig')
%% Timer Off

toc








