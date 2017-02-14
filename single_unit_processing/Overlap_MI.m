
%% Load Data
load all_animals3 %loads the dataset that has information on all animal groups

%Reference of order for animal, region, and cell types
%name = {'DR' 'LR' 'NgR' 'OGAD_KO'}; %name of animal group
%region = {'V1' 'V2' 'AC'}; %name of regions recorded
%type = {'Visual' 'Both' 'BothPref' 'Aud'}; %cell type

%% Append all MI to one big file per animal/region
for i = 1:length(name)
    for j = 1:length(fieldnames(dataset.(name{i})))
        overlapdata.(name{i}).(region{j}).MI = [];
        switch j
            case 1
                for k = 1:length(fieldnames(dataset.(name{i}).(region{j})))-6 %gets rid of extra calculations like mean, std, etc.
                    a = fieldnames(dataset.(name{i}).(region{j}));
                    overlapdata.(name{i}).(region{j}).MI = [overlapdata.(name{i}).(region{j}).MI;...
                    dataset.(name{i}).(region{j}).(a{k}).data(find(dataset.(name{i}).(region{j}).(a{k}).larger...
                    < max(dataset.NgR.(region{j}).SMgroup)...
                    & dataset.(name{i}).(region{j}).(a{k}).larger > min(dataset.OGAD_KO.(region{j}).SMgroup)),...
                    strcmp(dataset.(name{i}).(region{j}).(a{k}).textdata,'Multi Interaction'))];
                end
            case 2
                for k = 1:length(fieldnames(dataset.(name{i}).(region{j})))-6 %gets rid of extra calculations like mean, std, etc.
                    a = fieldnames(dataset.(name{i}).(region{j}));
                    overlapdata.(name{i}).(region{j}).MI = [overlapdata.(name{i}).(region{j}).MI;...
                    dataset.(name{i}).(region{j}).(a{k}).data(find(dataset.(name{i}).(region{j}).(a{k}).larger...
                    < max(dataset.NgR.(region{j}).SMgroup)...
                    & dataset.(name{i}).(region{j}).(a{k}).larger > min(dataset.LR.(region{j}).SMgroup)),...
                    strcmp(dataset.(name{i}).(region{j}).(a{k}).textdata,'Multi Interaction'))];
                end  
            case 3
                for k = 1:length(fieldnames(dataset.(name{i}).(region{j})))-6 %gets rid of extra calculations like mean, std, etc.
                    a = fieldnames(dataset.(name{i}).(region{j}));
                    overlapdata.(name{i}).(region{j}).MI = [overlapdata.(name{i}).(region{j}).MI;...
                    dataset.(name{i}).(region{j}).(a{k}).data(find(dataset.(name{i}).(region{j}).(a{k}).larger...
                    < max(dataset.LR.(region{j}).SMgroup)...
                    & dataset.(name{i}).(region{j}).(a{k}).larger > min(dataset.DR.(region{j}).SMgroup)),...
                    strcmp(dataset.(name{i}).(region{j}).(a{k}).textdata,'Multi Interaction'))];
                end 
        end
    end
end
                

%%
%mean(dataset.DR.V1.SMgroup(find(dataset.DR.V1.larger<max(dataset.NgR.V1.SMgroup) & dataset.DR.V1.larger>min(dataset.OGAD_KO.V1.SMgroup))))

%mean(dataset.LR.V1.SMgroup(find(dataset.LR.V1.SMgroup<max(dataset.NgR.V1.SMgroup) & dataset.LR.V1.SMgroup>min(dataset.OGAD_KO.V1.SMgroup))))

%mean(dataset.NgR.V1.SMgroup(find(dataset.NgR.V1.SMgroup<max(dataset.NgR.V1.SMgroup) & dataset.NgR.V1.SMgroup>min(dataset.OGAD_KO.V1.SMgroup))))

%mean(dataset.OGAD_KO.V1.SMgroup(find(dataset.OGAD_KO.V1.SMgroup<max(dataset.NgR.V1.SMgroup) & dataset.OGAD_KO.V1.SMgroup>min(dataset.OGAD_KO.V1.SMgroup))))