%Pie Charts of V1 and V2 Distribution
%
%Written by D.M. Brady 10/25/2010

%V1
figure(1)
subplot(2,2,1)
title('NgR V1 Distribution')
distro.V1 = [44 (16+8) 3];
percentage.visual = round(distro.V1(1)./sum(distro.V1)*100);
percentage.both = round(distro.V1(2)./sum(distro.V1)*100);
percentage.aud = round(distro.V1(3)./sum(distro.V1)*100);
LABELS = {['visual ' num2str(percentage.visual) '%'] ['both ' num2str(percentage.both) '%']...
    ['aud ' num2str(percentage.aud) '%']};

pie(distro.V1,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);

subplot(2,2,3)
LABELS = {['' ] ['']...
    ['']};

pie(distro.V1,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);

%saveas(figure(1),'NgR Ex Pie','pdf')


% V2
subplot(2,2,2)
title('NgR V2 Distribution')
distro.V2 = [39 (27+11) 7];
percentage.visual = round(distro.V2(1)./sum(distro.V2)*100);
percentage.both = round(distro.V2(2)./sum(distro.V2)*100);
percentage.aud = round(distro.V2(3)./sum(distro.V2)*100);
LABELS = {['visual ' num2str(percentage.visual) '%'] ['both ' num2str(percentage.both) '%']...
    ['auditory ' num2str(percentage.aud) '%']};

pie(distro.V2,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);


subplot(2,2,4)
LABELS = {[''] ['']...
    ['']};

pie(distro.V2,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);