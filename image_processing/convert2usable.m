function [imagedata,numberofimages,step,time,numofdiffsessions] = convert2usable(textdata,data)
%Converts metamorph text file into a nicely structured file for matlab
%processing
%
%Written by D.M. Brady 2/2010

%Getting rid of headers in textdata
textdata(1:3,:) = [];

imagedata.time = zeros(length(textdata(:,1)),1); %All the variables of interests
imagedata.region = zeros(length(textdata(:,1)),1);
imagedata.area = zeros(length(textdata(:,1)),1);
imagedata.distance = zeros(length(textdata(:,1)),1);
imagedata.angle = zeros(length(textdata(:,1)),1);
imagedata.intensity = zeros(length(textdata(:,1)),1);

%Making timeline
imagedata.time = str2double(textdata(:,1)); %Converts first column of textdata
%to numbers, and puts them in new structure - image
numberofimages = max(imagedata.time); %Finds the number of images taken per session
step = 9/numberofimages; %Gives difference in time between each image
time = [0:step:9-step]'; %Timeline of session
numofdiffsessions = length(find(numberofimages==imagedata.time)); 
%Finds number of different types of imaging sessions/regions 
%(should be 9, both/aud/vis for 3 regions)
imagedata.time = repmat(time,numofdiffsessions,1); %Converts image number to appropriate time

%Making regions (1 = V1, 2 = V2, 3 = Ref)
for i = 1:length(textdata(:,2)) %Series of logic statments to convert strings to numbers
    if strcmp(textdata(i,2),'1') == 1  %If working in older matlab, write '"1"' instead of '1'
        imagedata.region(i) = 1;
    elseif strcmp(textdata(i,2),'2') == 1
        imagedata.region(i) = 2;
    elseif strcmp(textdata(i,2),'3') == 1
        imagedata.region(i) = 3;
    end
end

%Making area
imagedata.area = data(:,1);

%Making distance
imagedata.distance = data(:,2);

%Making angle
imagedata.angle = data(:,3);

%Making intensity
imagedata.intensity = data(:,4);


