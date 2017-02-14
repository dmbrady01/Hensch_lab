a.vis = mean(onresponse.vis);
a.aud = mean(onresponse.aud);
a.both = mean(onresponse.both);
a.blank = mean(onresponse.blank);
b.vis = var(onresponse.vis);
b.aud = var(onresponse.aud);
b.both = var(onresponse.both);
b.blank = var(onresponse.blank);
fano.vis = b.vis./a.vis;
fano.aud = b.aud./a.aud;
fano.both = b.both./a.both;
fano.blank = b.blank/a.blank;



N = 20;                               %The number of trials, in our case.
FANO = (0:0.001:2);                     %Define a range of FANO values we might observe.
y = gampdf(FANO, (N-1)/2, 2/(N-1));     %Compute the gamma distribution [See MATLAB Help if you're interested] ...
plot(FANO,y);                            
xlabel('Fano Factor')
ylabel('Counts (out of 1000 trials)')
title('Distribution of Fano factors we expect to observe for Poisson data')
upper = gaminv(0.975, (N-1)/2, 2/(N-1));  % 95% Confidence limit (upper)
lower = gaminv(0.025, (N-1)/2, 2/(N-1));  % 95% Confidence limit (lower)
hold on
plot([lower lower], [0 max(y)], 'r');
plot([upper upper], [0 max(y)], 'r');
hold off

a
b
fano
upper
lower