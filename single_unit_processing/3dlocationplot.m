%3-D Plot of Location of Different Cells
%
%Written by D.M. Brady

figure(1)
subplot(2,2,1)
hold on
plot3(visuallocation.DR.V2(:,1),visuallocation.DR.V2(:,2),visuallocation.DR.V2(:,3),...
    'bo','MarkerSize',5,'MarkerFaceColor','b')
plot3(bothlocation.DR.V2(:,1),bothlocation.DR.V2(:,2),bothlocation.DR.V2(:,3),...
    'ko','MarkerSize',5,'MarkerFaceColor','k')
plot3(audlocation.DR.V2(:,1),audlocation.DR.V2(:,2),audlocation.DR.V2(:,3),...
    'ro','MarkerSize',5,'MarkerFaceColor','r')