function [greatest] = preparepsths2(spike_count,window)
%Similar to preparerasters. Sets axes, stim on/off, and ylabel for PSTHs.
%
%Written by D.M. Brady 4/2010

gvis = max(spike_count.vis);
gaud = max(spike_count.aud);
gboth = max(spike_count.both);
gblank = max(spike_count.blank);

greatest = max([gvis gaud gboth gblank])+3; %Will be upper limit of y axis

xlim([-window.pre (window.stim+window.post)])
ylim([0 3*greatest])
%stimulus_start = line([0 0],[0 3*greatest]); %Creates a line indicating when stimulus started
%set(stimulus_start,'Color','k','LineStyle','-','LineWidth',1)
%stimulus_end = line([window.stim window.stim],[0 3*greatest]); %Creates a line indicating when stimulus ended
%set(stimulus_end,'Color','k','LineStyle','--','LineWidth',1)
%ylabel('# of Spikes','FontSize',12,'FontName','Arial')