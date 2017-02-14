%Group mean firing rate
%
%Calculates mean firing rate and standard deviation for the stronger single 
%stimulus and combined stimuli for all animals in all regions
%
%Written by D.M. Brady May 2011

%% Loading all_animals and setting up variables

tic

load all_animals5 %loads the dataset that has information on all animal groups

%Reference of order for animal, region, and cell types
%name = {'DR' 'LR' 'NgR' 'OGAD_KO' 'NR2A'}; %name of animal group
%region = {'V1' 'V2' 'AC'}; %name of regions recorded
%type = {'Visual' 'Both' 'BothPref' 'Aud'}; %cell type

%% Calculating mean and sd by animal and cell type

for k = 1:length(name)
    for i = 1:length(region)
        for j = 1:length(type)
            try
                switch j %groups different firing rates dependent on cell type
                    case 1 %Visual Neurons
                        dataset.(name{k}).(region{i}).(type{j}).larger = zeros(size(dataset.(name{k}).(region{i}).(type{j}).data,1),2);
                        %Creates an empty variable -.larger
                        dataset.(name{k}).(region{i}).(type{j}).larger(:,1) = dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Visual',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        dataset.(name{k}).(region{i}).(type{j}).larger(:,2) = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Vis',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2;        
                                %Fills -.larger with all the relevant
                                %firing rates and var
                        dataset.(name{k}).(region{i}).(type{j}).mean = mean(dataset.(name{k}).(region{i}).(type{j}).larger); 
                        %Calculates FR for Vis Neurons
                        dataset.(name{k}).(region{i}).(type{j}).sd = std(dataset.(name{k}).(region{i}).(type{j}).larger);
                        %Calculates SD for Vis Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanovis = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Vis',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Visual',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Visual Response
                        %in Vis Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanoboth = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Both',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Both',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Both Response
                        %in Vis Neurons
                        
                    case 4 %Auditory Neurons
                        dataset.(name{k}).(region{i}).(type{j}).larger = zeros(size(dataset.(name{k}).(region{i}).(type{j}).data,1),2);
                        %Creates an empty variable -.larger
                        dataset.(name{k}).(region{i}).(type{j}).larger(:,1) = dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Auditory',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        dataset.(name{k}).(region{i}).(type{j}).larger(:,2) = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Aud',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2;        
                                %Creates a variable -.larger that includes
                                %all the relevant firing rates
                        dataset.(name{k}).(region{i}).(type{j}).mean = mean(dataset.(name{k}).(region{i}).(type{j}).larger); 
                        %Calculates FR for Auditory Neurons
                        dataset.(name{k}).(region{i}).(type{j}).sd = std(dataset.(name{k}).(region{i}).(type{j}).larger);
                        %Calculates SD for Auditory Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanoaud = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Aud',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Auditory',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Auditory Response
                        %in Aud Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanoboth = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Both',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Both',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Both Response
                        %in Aud Neurons
                    
                    otherwise %Both and BothPref Neurons
                        dataset.(name{k}).(region{i}).(type{j}).larger = zeros(size(dataset.(name{k}).(region{i}).(type{j}).data,1),2);
                        %Creates an empty variable -.larger
                        for m = 1:size(dataset.(name{k}).(region{i}).(type{j}).data,1)
                            if dataset.(name{k}).(region{i}).(type{j}).data(m,strcmp('FR Visual',...
                                    dataset.(name{k}).(region{i}).(type{j}).textdata)) > dataset.(name{k}).(region{i}).(type{j}).data(m,...
                                    strcmp('FR Auditory',dataset.(name{k}).(region{i}).(type{j}).textdata))
                                dataset.(name{k}).(region{i}).(type{j}).larger(m,1) = dataset.(name{k}).(region{i}).(type{j}).data(m,...
                                    strcmp('FR Visual',dataset.(name{k}).(region{i}).(type{j}).textdata));
                                dataset.(name{k}).(region{i}).(type{j}).larger(m,2) = (dataset.(name{k}).(region{i}).(type{j}).data(m,...
                                    strcmp('SD: Vis',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2;
                                %Compares the firing rate for visual and
                                %auditory conditions. if one is higher, it
                                %gets placed into a new variable -.larger
                                %that is used to calculte the group FR
                            else
                                dataset.(name{k}).(region{i}).(type{j}).larger(m,1) = dataset.(name{k}).(region{i}).(type{j}).data(m,...
                                    strcmp('FR Auditory',dataset.(name{k}).(region{i}).(type{j}).textdata));
                                dataset.(name{k}).(region{i}).(type{j}).larger(m,2) = (dataset.(name{k}).(region{i}).(type{j}).data(m,...
                                    strcmp('SD: Aud',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2;
                            end
                        end
                        dataset.(name{k}).(region{i}).(type{j}).mean = mean(dataset.(name{k}).(region{i}).(type{j}).larger);
                        %Calculates FR for Both Neurons
                        dataset.(name{k}).(region{i}).(type{j}).sd = std(dataset.(name{k}).(region{i}).(type{j}).larger);
                        %Calculates SD for Both Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanovis = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Vis',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Visual',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Visual Response
                        %in Vis Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanoaud = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Aud',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Auditory',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Both Response
                        %in Vis Neurons
                        dataset.(name{k}).(region{i}).(type{j}).fanoboth = (dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('SD: Both',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2 ...
                                    ./dataset.(name{k}).(region{i}).(type{j}).data(:,...
                                    strcmp('FR Both',dataset.(name{k}).(region{i}).(type{j}).textdata));
                        %Calculates Fano Factor for Both Response
                        %in Vis Neurons
                end
            catch err
                continue
            end
        end
    end
end

%% Calculating single modality group mean and sd by animal type

for k = 1:length(name)
    for i = 1:length(region)
        if myIsField(dataset.(name{k}),(region{i})) %Checks to see if a certain region (V1,V2,AC) is in the dataset. If so, it makes a new
            %variable called -.SMgroup that includes all of the SMs for a
            %certain animal and region. If not, it skips to the next loop.
            dataset.(name{k}).(region{i}).SMgroup = [];
            for j = 1:length(type)
                try
                    dataset.(name{k}).(region{i}).SMgroup = [dataset.(name{k}).(region{i}).SMgroup;...
                        dataset.(name{k}).(region{i}).(type{j}).larger]; %makes a matrix that includes all SM for a particular brain region
                catch err
                    continue
                end
            end
            dataset.(name{k}).(region{i}).SMgroupmean = mean(dataset.(name{k}).(region{i}).SMgroup); %mean of SM for a region
            dataset.(name{k}).(region{i}).SMgroupsd = std(dataset.(name{k}).(region{i}).SMgroup); %sd of SM for a region
        else
            continue
        end
    end
end

%% Calculating combined modality group mean and sd by animal type

for k = 1:length(name)
    for i = 1:length(region)
        if myIsField(dataset.(name{k}),(region{i}))
            dataset.(name{k}).(region{i}).CMgroupFR = [];
            dataset.(name{k}).(region{i}).CMgroupVar = [];
            for j=1:length(type)
                try
                    dataset.(name{k}).(region{i}).CMgroupFR = [dataset.(name{k}).(region{i}).CMgroupFR;...
                        dataset.(name{k}).(region{i}).(type{j}).data(:,strcmp('FR Both',dataset.(name{k}).(region{i}).(type{j}).textdata))];
                    dataset.(name{k}).(region{i}).CMgroupVar = [dataset.(name{k}).(region{i}).CMgroupVar;...
                        (dataset.(name{k}).(region{i}).(type{j}).data(:,strcmp('SD: Both',dataset.(name{k}).(region{i}).(type{j}).textdata))).^2];
                    %collects all the FR to Both conditions
                catch err
                    continue
                end
            end
            dataset.(name{k}).(region{i}).CMgroupmean = [mean(dataset.(name{k}).(region{i}).CMgroupFR),mean(dataset.(name{k}).(region{i}).CMgroupVar)]; %mean of CM for a region
            dataset.(name{k}).(region{i}).CMgroupsd = [std(dataset.(name{k}).(region{i}).CMgroupFR),std(dataset.(name{k}).(region{i}).CMgroupVar)]; %sd of CM for a region
            dataset.(name{k}).(region{i}).compare_fano(:,1) = dataset.(name{k}).(region{i}).SMgroup(:,2)./dataset.(name{k}).(region{i}).SMgroup(:,1);
            dataset.(name{k}).(region{i}).compare_fano(:,2) = dataset.(name{k}).(region{i}).CMgroupVar./dataset.(name{k}).(region{i}).CMgroupFR;
        else
            continue
        end
    end
end

%% Save Data

save('all_animals6','dataset','name','region','type')

toc
            



                        
                        
                        
                        
                        
                        
                        