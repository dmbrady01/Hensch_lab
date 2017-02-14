name = {'DR' 'LR' 'NGR' 'OGAD'}; %name of animal group
region = {'V1' 'V2' 'AC'}; %name of regions recorded
color = {'b' 'r'};

for i = 1:length(region)
    figure(i)
    for j = 1:length(name)
        h = rectangle('Position',[j-.75 0 .5 length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})<0))...
            ./length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})~=0))]);
        set(h,'FaceColor','b')
        
        h = rectangle('Position',[j-.75 length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})<0))...
            ./length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})~=0)) .5...
            length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})>0))./length(MI.(name{j}).(region{i})(MI.(name{j}).(region{i})~=0))]);
        set(h,'FaceColor','r')
    end
end