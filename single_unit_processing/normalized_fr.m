%Calculating normalized change in firing rate (Stim-Base)./(Stim+Base)



for i = 1:length(name)
    for j = 1:length(region)
        for k = 1:length(type)
            
            try
                %normalized response to visual stimuli
                normalized_FR.(name{i}).(region{j}).(type{k}).vis = (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Visual')) - ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank'))) ./ ...
                    (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Visual')) + ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank')));
            catch err
                continue
            end
            
            try
                %normalized response to both stimuli
                normalized_FR.(name{i}).(region{j}).(type{k}).both = (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Both')) - ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank'))) ./ ...
                    (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Both')) + ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank')));
            catch err
                continue
            end
            
            try
                %normalized response to auditory stimuli
                normalized_FR.(name{i}).(region{j}).(type{k}).aud = (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Auditory')) - ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank'))) ./ ...
                    (dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Auditory')) + ...
                    dataset.(name{i}).(region{j}).(type{k}).data(:,...
                    strcmpi(dataset.(name{i}).(region{j}).(type{k}).textdata, 'FR Blank')));
            catch err
                continue
            end
                        
            
        end
        
        try
            %group all cell types together visual response
            normalized_FR.(name{i}).(region{j}).all.vis = {};
            normalized_FR.(name{i}).(region{j}).all.both = {};
            normalized_FR.(name{i}).(region{j}).all.aud = {};
            temp = fieldnames(normalized_FR.(name{i}).(region{j}));
            temp = temp(~strcmpi(temp,'all'));
            for ii = 1:length(temp)
                %visual response
                normalized_FR.(name{i}).(region{j}).all.vis{ii} = normalized_FR.(name{i}).(region{j}).(temp{ii}).vis;
                
                %both response
                normalized_FR.(name{i}).(region{j}).all.both{ii} = normalized_FR.(name{i}).(region{j}).(temp{ii}).both;
                
                %auditory response
                normalized_FR.(name{i}).(region{j}).all.aud{ii} = normalized_FR.(name{i}).(region{j}).(temp{ii}).aud;
            end
            
            normalized_FR.(name{i}).(region{j}).all.vis = normalized_FR.(name{i}).(region{j}).all.vis';
            normalized_FR.(name{i}).(region{j}).all.vis = cell2mat(normalized_FR.(name{i}).(region{j}).all.vis);
            
            normalized_FR.(name{i}).(region{j}).all.both = normalized_FR.(name{i}).(region{j}).all.both';
            normalized_FR.(name{i}).(region{j}).all.both = cell2mat(normalized_FR.(name{i}).(region{j}).all.both);
            
            normalized_FR.(name{i}).(region{j}).all.aud = normalized_FR.(name{i}).(region{j}).all.aud';
            normalized_FR.(name{i}).(region{j}).all.aud = cell2mat(normalized_FR.(name{i}).(region{j}).all.aud);
            
            
            
        catch err
            continue
        end
                
        
        
        
        
        
    end
end
    