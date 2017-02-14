%3-D Plot of Location of Different Cells
%
%Written by D.M. Brady

visuallocation = xlsread('LocationDR','Vis');
bothlocation = xlsread('LocationDR','Both');
bothpreflocation = xlsread('LocationDR','BothPref');
audlocation = xlsread('LocationDR','Aud')

figure(1)
subplot(2,2,1)
hold on
plot3(visuallocation(:,1),visuallocation(:,2),visuallocation(:,3),...
    'bo','MarkerSize',5,'MarkerFaceColor','b')
plot3(bothlocation(:,1),bothlocation(:,2),bothlocation(:,3),...
    'ko','MarkerSize',5,'MarkerFaceColor','k')
plot3(bothpreflocation(:,1),bothpreflocation(:,2),bothpreflocation(:,3),...
    'ko','MarkerSize',5,'MarkerFaceColor','k')
plot3(audlocation(:,1),audlocation(:,2),audlocation(:,3),...
    'ro','MarkerSize',5,'MarkerFaceColor','r')