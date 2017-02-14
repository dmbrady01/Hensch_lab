%Compare Signal to Noise Ratio (mean/std)
%
%Written by D.M. Brady 11/1/2010


%% Visual vs. Auditory, Visual vs. Both, Auditory vs. Both - SNR

%Vis vs. Aud
figure(1)
subplot(2,2,1)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Aud')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Aud')),...
    50,'b');
title('Vis vs. Aud')
xlabel('SNR: Visual Response')
ylabel('SNR: Auditory Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Aud'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Vis vs. Both
subplot(2,2,2)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Both')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Both')),...
    50,'b');
title('Vis vs. Both')
xlabel('SNR: Visual Response')
ylabel('SNR: Both Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Both
subplot(2,2,3)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Aud')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Both')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Aud')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Both')),...
    50,'b');
title('Aud vs. Both')
xlabel('SNR: Auditory Response')
ylabel('SNR: Both Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Aud'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Both'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%% Blank vs. ....  SNR

%Vis vs. Blank
figure(2)
subplot(2,2,1)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Vis')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Vis vs. Blank')
xlabel('SNR: Visual Response')
ylabel('SNR: Blank Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Vis'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Auditory vs. Blank
subplot(2,2,2)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Aud')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Aud')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Aud vs. Blank')
xlabel('SNR: Auditory Response')
ylabel('SNR: Blank Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Aud'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)

%Both vs. Blank
subplot(2,2,3)
hold on
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Both')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) < 0),strcmp(textdata,'CV: Blank')),...
    50,'r');
scatter(1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Both')),...
    1./data(find(data(:,find(strcmp(textdata,'Multi Interaction'))) >= 0),strcmp(textdata,'CV: Blank')),...
    50,'b');
title('Both vs. Blank')
xlabel('SNR: Both Response')
ylabel('SNR: Blank Response')
b(1) = max(1./data(:,(strcmp(textdata,'CV: Both'))));
b(2) = max(1./data(:,(strcmp(textdata,'CV: Blank'))));
b = max(b);
x = 0:0.1:b;
plot(x,x)







