%Compare Coefficient of Variation - DR
%
%Written by D.M. Brady 11/1/2010


%% Visual vs. Auditory, Visual vs. Both, Auditory vs. Both - CV

%Vis vs. Aud
figure(1)
subplot(2,2,1)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Aud')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Aud')),...
    50,'b');
title('Vis vs. Aud')
xlabel('CV: Visual Response')
ylabel('CV: Auditory Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Aud'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Vis vs. Both
subplot(2,2,2)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Both')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Both')),...
    50,'b');
title('Vis vs. Both')
xlabel('CV: Visual Response')
ylabel('CV: Both Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Both
subplot(2,2,3)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Both')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Both')),...
    50,'b');
title('Aud vs. Both')
xlabel('CV: Auditory Response')
ylabel('CV: Both Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Aud'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%% Blank vs. ....  CV

%Vis vs. Blank
figure(2)
subplot(2,2,1)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Vis vs. Blank')
xlabel('CV: Visual Response')
ylabel('CV: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Blank
subplot(2,2,2)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Aud vs. Blank')
xlabel('CV: Auditory Response')
ylabel('CV: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Aud'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Both vs. Blank
subplot(2,2,3)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Both')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Both')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Both vs. Blank')
xlabel('CV: Both Response')
ylabel('CV: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'CV: Both'))));
b(2) = max(data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)



%% Visual vs. Auditory, Visual vs. Both, Auditory vs. Both - SD

%Vis vs. Aud
figure(3)
subplot(2,2,1)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Aud')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Aud')),...
    50,'b');
title('Vis vs. Aud')
xlabel('SD: Visual Response')
ylabel('SD: Auditory Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Aud'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Vis vs. Both
subplot(2,2,2)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Both')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Both')),...
    50,'b');
title('Vis vs. Both')
xlabel('SD: Visual Response')
ylabel('SD: Both Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Both
subplot(2,2,3)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Both')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Both')),...
    50,'b');
title('Aud vs. Both')
xlabel('SD: Auditory Response')
ylabel('SD: Both Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Aud'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%% Blank vs. ....  SD

%Vis vs. Blank
figure(4)
subplot(2,2,1)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Vis')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Blank')),...
    50,'b');
title('Vis vs. Blank')
xlabel('SD: Visual Response')
ylabel('SD: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Vis'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Blank
subplot(2,2,2)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Aud')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Blank')),...
    50,'b');
title('Aud vs. Blank')
xlabel('SD: Auditory Response')
ylabel('SD: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Aud'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Both vs. Blank
subplot(2,2,3)
hold on
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Both')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) <= 0),strcmp(textdata,'SD: Blank')),...
    50,'r');
scatter(data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Both')),...
    data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) > 0),strcmp(textdata,'SD: Blank')),...
    50,'b');
title('Both vs. Blank')
xlabel('SD: Both Response')
ylabel('SD: Blank Response')
b(1) = max(data(:,(strcmp(textdata,'SD: Both'))));
b(2) = max(data(:,(strcmp(textdata,'SD: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)








