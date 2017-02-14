function [peaktime] = calctimetopeaksu(within_time,centers,spike_count)
%Creates a structure with all the relevant peaktimes (vis, aud, vis+aud,
%and blank). This is for the first peak only, so have to set a limit on the
%time.
%
%Written by D.M. Brady 4/2010

reducedcenters = centers(0 < centers & centers < within_time);

peaktime.vis = min(reducedcenters(spike_count.vis(0 < centers & centers < within_time)==...
    max(spike_count.vis(0 < centers & centers < within_time)))); 
%Time to peak vis only value
%First we find the indices that correspond to the max value in
%spike_count.vis, then we look up the corresponding values in centers (to relate it to time centered
%around the stimulus and take the first one
peaktime.aud = min(reducedcenters(spike_count.aud(0 < centers & centers < within_time)...
    ==max(spike_count.aud(0 < centers & centers < within_time)))); %Time to peak aud only value
peaktime.both = min(reducedcenters(spike_count.both(0 < centers & centers < within_time)...
    ==max(spike_count.both(0 < centers & centers < within_time)))); %Time to peak vis+aud value
peaktime.blank = min(reducedcenters(spike_count.blank(0 < centers & centers < within_time)...
    ==max(spike_count.blank(0 < centers & centers < within_time)))); %Time to peak blank value (meaningless)