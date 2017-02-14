function [stimulus_start, stimulus_end] = preparerasters(numberoftrials, window)
%Creates standard axes for rasters and lines for stimulus onset and end,
%also labels y axis
%
%Written by D.M. Brady 4/2010

ylim([0 numberoftrials])
xlim([-window.pre (window.stim+window.post)])
%ylabel('Trials','FontSize',12,'FontName','Arial')
stimulus_start = line([0 0],[0 numberoftrials]); %Creates a line indicating when stimulus started
set(stimulus_start,'Color','k','LineStyle','-','LineWidth',1)
stimulus_end = line([window.stim window.stim],[0 numberoftrials]); %Creates a line 
%indicating when stimulus ended
set(stimulus_end,'Color','k','LineStyle','--','LineWidth',1)