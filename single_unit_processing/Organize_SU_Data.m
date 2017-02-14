%Organize SU data by cell type
%
%Takes data from '.csv' files that are organized by mouse and cell type and
%places them into a structure 'dataset'
%
%Written by D.M. Brady May 2011



%% Load files and organize them in a structure

name = {'DR' 'LR' 'NgR' 'OGAD_KO' 'NR2A'}; %name of animal group
region = {'V1' 'V2' 'AC'}; %name of regions recorded
type = {'Visual' 'Both' 'BothPref' 'Aud'}; %cell type

for k = 1:length(name)
    for i = 1:length(region)
        for j = 1:length(type)
            try
                open([name{k} '_Cell_Types_' region{i} '_' type{j} '.csv']) %opens the csv file, need to click return twice to load the file
                pause; %pauses until you press return (gives time to load variables before moving onto the next line
                dataset.(name{k}).(region{i}).(type{j}).data = data; %saves all numerical data into the 'data' part of the structure
                dataset.(name{k}).(region{i}).(type{j}).textdata = textdata; %saves the column headings into a text part of the structure
            catch err
                continue %if there is an error because the file does not exist, it will move onto the next iteration of the loop
            end
        end
    end
end

%% Save files

save('all_animals5','dataset','name','region','type')
