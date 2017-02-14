%% Plot SD vs. SD
% Vis vs. Aud
figure(1)
subplot(2,2,1)
scatter(a(:,2),a(:,5))
hold on
b(1) = max(a(:,2));
b(2) = max(a(:,5));
b = max(b);
x = 0:1:b;
plot(x,x)

% Vis vs. Both
subplot(2,2,2)
scatter(a(:,2),a(:,8))
hold on
b(1) = max(a(:,2));
b(2) = max(a(:,8));
b = max(b);
x = 0:1:b;
plot(x,x)

% Vis vs. Blank
subplot(2,2,3)
scatter(a(:,2),a(:,11))
hold on
b(1) = max(a(:,2));
b(2) = max(a(:,11));
b = max(b);
x = 0:1:b;
plot(x,x)

%% Comparing CV

% Vis vs. Aud
figure(2)
subplot(2,2,1)
scatter(a(:,3),a(:,6))
hold on
b(1) = max(a(:,3));
b(2) = max(a(:,6));
b = max(b);
x = 0:1:b;
plot(x,x)

% Vis vs. Both
subplot(2,2,2)
scatter(a(:,3),a(:,9))
hold on
b(1) = max(a(:,3));
b(2) = max(a(:,9));
b = max(b);
x = 0:1:b;
plot(x,x)

% Vis vs. Blank
subplot(2,2,3)
scatter(a(:,3),a(:,12))
hold on
b(1) = max(a(:,3));
b(2) = max(a(:,12));
b = max(b);
x = 0:1:b;
plot(x,x)































