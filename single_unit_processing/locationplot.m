%3-D Plot of Location of Different Cells
%
%Written by D.M. Brady

%% Getting Data
%visuallocation = xlsread('LocationNgR','Vis'); % NGR KO
visuallocation = xlsread('LocationDR','Vis'); % DR

%bothlocation = xlsread('LocationNgR','Both'); % NGR KO
bothlocation = xlsread('LocationDR','Both'); %  DR

%bothpreflocation = xlsread('LocationNgR','BothPref'); % NGR KO
bothpreflocation = xlsread('LocationDR','BothPref'); % DR

%audlocation = xlsread('LocationNgR','Aud'); % NGR KO
audlocation = xlsread('LocationDR','Aud'); % DR

%% All Together
figure(1)
%subplot(2,2,4)
title('All Cells')
xlabel('Distance: Medial to Lateral (mm)')
ylabel('Distance: Anterior to Posterior (mm)')
zlabel('Depth (um)')
axis([2 4 0 1.5 -900 0])
hold on
grid on
plot3(visuallocation(:,1),visuallocation(:,2),-1*visuallocation(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[1 1 100/255]) %Vis Cells
plot3(bothlocation(:,1),bothlocation(:,2),-1*bothlocation(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[1 100/255 100/255]) %Both Cells
plot3(bothpreflocation(:,1),bothpreflocation(:,2),-1*bothpreflocation(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[1 100/255 100/255]) %Both Pref Cells
plot3(audlocation(:,1),audlocation(:,2),-1*audlocation(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[100/255 100/255 1]) % V2 Aud Cells

%saveas(figure(1),'3d plot','epsc')

%% All Together with newloc

figure(1)
%subplot(2,2,4)
title('All Cells')
xlabel('Distance: Medial to Lateral (mm)')
ylabel('Distance: Anterior to Posterior (mm)')
zlabel('Depth (um)')
axis([2 4 0 1.5 -900 0])
hold on
grid on

plot3(loc.DR.vis(:,1),loc.DR.vis(:,2),-1*loc.DR.vis(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[1 1 100/255]) % Vis Cells
plot3(loc.DR.both(:,1),loc.DR.both(:,2),-1*loc.DR.both(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[1 100/255 100/255]) % V2 Both Cells
plot3(loc.DR.aud(:,1),loc.DR.aud(:,2),-1*loc.DR.aud(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor',[100/255 100/255 1]) % Aud Cells

%% Cell Types Pie Chart

distro.V2 = [length(visuallocation.DR.V2) length(bothlocation.DR.V2) length(audlocation.DR.V2)];
percentage.visual = round(length(visuallocation.DR.V2)./sum(distro.V2)*100);
percentage.aud = round(length(audlocation.DR.V2)./sum(distro.V2)*100);
percentage.both = round(length(bothlocation.DR.V2)./sum(distro.V2)*100);
LABELS = {[''] ['']...
    ['']};

subplot(2,2,3)
pie(distro.V2,LABELS);
colormap([1 1 200/255; 1 200/255 200/255; 200/255 200/255 1]);

%% Cell Types Pie Chart with newloc

distro.V2 = [36 (29+11) 11];
percentage.visual = round(distro.V2(1)./sum(distro.V2)*100);
percentage.aud = round(distro.V2(2)./sum(distro.V2)*100);
percentage.both = round(distro.V2(3)./sum(distro.V2)*100);
LABELS = {[''] ['']...
    ['']};

subplot(2,2,3)
pie(distro.V2,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);

%% Cell Types Pie Chart for V1

distro.V1 = [72 (24+7) 1];
percentage.visual = round(distro.V1(1)./sum(distro.V1)*100);
percentage.aud = round(distro.V1(2)./sum(distro.V1)*100);
percentage.both = round(distro.V1(3)./sum(distro.V1)*100);
LABELS = {[''] ['']...
    ['']};

subplot(2,2,4)
pie(distro.V1,LABELS);
colormap([1 1 100/255; 1 100/255 100/255; 100/255 100/255 1]);

%% Just Visual
figure(2)
%subplot(2,2,1)
title('Visual Cells')
xlabel('Distance: Medial to Lateral (mm)')
ylabel('Distance: Anterior to Posterior (mm)')
zlabel('Depth (um)')
axis([2 4 0 1.5 -900 0])
hold on
grid on
plot3(visuallocation.DR.V2(:,1),visuallocation.DR.V2(:,2),-1*visuallocation.DR.V2(:,3),...
    'bo','MarkerSize',8,'MarkerFaceColor','b') % V2 Cells
plot3(visuallocation.DR.V1(:,1),visuallocation.DR.V1(:,2),-1*visuallocation.DR.V1(:,3),...
    'bo','MarkerSize',8,'MarkerFaceColor','b') % V1 Cells

%% Just Auditory
figure(3)
%subplot(2,2,2)
title('Auditory Cells')
xlabel('Distance: Medial to Lateral (mm)')
ylabel('Distance: Anterior to Posterior (mm)')
zlabel('Depth (um)')
axis([2 4 0 1.5 -900 0])
hold on
grid on
plot3(audlocation.DR.V2(:,1),audlocation.DR.V2(:,2),-1*audlocation.DR.V2(:,3),...
    'ro','MarkerSize',8,'MarkerFaceColor','r') % V2 Cells
plot3(audlocation.DR.A1(:,1),audlocation.DR.A1(:,2),-1*audlocation.DR.A1(:,3),...
    'ro','MarkerSize',8,'MarkerFaceColor','r') % A1 Aud Cells

%% Just Both
figure(4)
%subplot(2,2,3)
title('Both Cells')
xlabel('Distance: Medial to Lateral (mm)')
ylabel('Distance: Anterior to Posterior (mm)')
zlabel('Depth (um)')
axis([2 4 0 1.5 -900 0])
hold on
grid on
plot3(bothlocation.DR.V2(:,1),bothlocation.DR.V2(:,2),-1*bothlocation.DR.V2(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor','k') % V2 Cells
plot3(bothlocation.DR.V1(:,1),bothlocation.DR.V1(:,2),-1*bothlocation.DR.V1(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor','k') % V1 Cells
plot3(bothlocation.DR.A1(:,1),bothlocation.DR.A1(:,2),-1*bothlocation.DR.A1(:,3),...
    'ko','MarkerSize',8,'MarkerFaceColor','k') % A1 Both Cells



