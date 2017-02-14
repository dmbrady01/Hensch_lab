%Bar graphs for paper #2: IQR and +/- ratio
%
%Written by D.M. Brady 7/2011

region_bar = {'V2'};
for i = 1:length(region_bar)
    figure(3), hold on, title([region_bar{i} ' IQR + errorbars'])
    for j = 1:length(name)
        try
            h = bar(j,MIboot.(name{j}).(region_bar{i}).boot.iqr);
            set(h,'FaceColor',color{j})
            h = errorbar(j, MIboot.(name{j}).(region_bar{i}).boot.iqr, MIboot.(name{j}).(region_bar{i}).boot.iqr_sd);
            %set(h,'Color',color{j})
            set(h,'Color',color{j},'LineWidth',2)
            xlim([0 j+1])
        catch err
            continue
        end
    end
end

for i = 1:length(region_bar)
    figure(4), hold on, title([region_bar{i} ' +/- Ratio + errorbars'])
    for j = 1:length(name)
        try
            h = bar(j,MIboot.(name{j}).(region_bar{i}).boot.pnratio);
            set(h,'FaceColor',color{j})
            h = errorbar(j, MIboot.(name{j}).(region_bar{i}).boot.pnratio, MIboot.(name{j}).(region_bar{i}).boot.pnratio_sd);
            %set(h,'Color',color{j})
            set(h,'Color',color{j},'LineWidth',2)
            xlim([0 j+1])
        catch err
            continue
        end
    end
end