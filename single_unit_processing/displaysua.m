%Display Single Unit Analysis
%
%Displays data to be entered in excel after singleunitanalysis
%
%Written by D.M. Brady 6/2010

displayed.firingrate = [firingrate.on.vis(end) firingrate.on.aud(end) firingrate.on.both(end)...
    firingrate.on.blank(end) firingrate.on.theoreticalboth(end)];
displayed.mutliint = [multiint.on(end) abs(multiint.on(end))];
displayed.mutlifac = [multifac.on(end) abs(multifac.on(end))];
displayed.peaktime = [peaktime.vis peaktime.aud peaktime.both];
displayed.location = [location.medial_lateral location.anterior_posterior location.depth_unit];

displayed