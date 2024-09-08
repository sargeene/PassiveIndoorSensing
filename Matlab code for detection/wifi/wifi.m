clc;
clear all;
%%%% router 1 processing
% Prediction for crossing router 1  %%%%%%%%%%%%%
%% checking if there is something between the router 1
load ('router1between.mat');
i = size(router1between,1);
ff = [];
label1=[];
for fn = 1:10
    fn;
    ddf =cell2mat(router1between(:,fn));
    ff=[ff,ddf];  
    label1=[label1,1];
end
load ('router1nothingbetween.mat');
i = size(router1nothingbetween,1);

for fn = 1:10
    fn;
    ddf =cell2mat(router1nothingbetween(:,fn));
    ff=[ff,ddf];  
    label1=[label1,0];
end

%classification algorithm... this can also be used for voice detection
trainedClassifier = fitcknn( ...
    ff', ...
     label1, ...
    'Distance','euclidean', ...
    'NumNeighbors',1, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(label1));
%%%%% change for crossing R1 here [13]
% a =[ -48;-47;-45;-51;-49;-49;-58;-50;-49;-51;-48;-52;-50]

[label,score,cost]  = predict(trainedClassifier,cell2mat(router1between(:,1))');
% [label,score,cost]  = predict(trainedClassifier,a');
prediction = int16(label);
if prediction == 1
        disp('there is some between the wifi')
end

% graph for a
% x=0:1:12;
% figure
% for fd=1:10
     %plot(x,cell2mat(router1between(:,1)))
%     plot(x*4.62,a)
% end
%    title('Graph of signal strenght VS Time')
% xlabel('Sec')
% ylabel('dBm')

%%new trainning

%plot(x,cell2mat(router1between(:,1)))
%%new trainning

%plot(x,cell2mat(router1between(:,1)))

%% Prediction for crossing router 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 fitcknn(ff',label1,'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'))

label2=[];
load ('router2between.mat');
i = size(router2between,1);
ff2 = [];

for fn = 1:10
    fn;
    ddf =cell2mat(router2between(:,fn))
    ff2=[ff2,ddf]  
    label2=[label2,1]
end

load ('router2nothingbetween.mat');
i = size(router2nothingbetween,1);


for fn = 1:10
    fn;
    ddf =cell2mat(router2nothingbetween(:,fn))
    ff2=[ff2,ddf]
    label2=[label2,0]
end
trainedClassifier2 = fitcknn( ...
    ff2', ...
     label2, ...
    'Distance','euclidean', ...
    'NumNeighbors',1, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(label2));

%%%%%%% change for between R2 here [13]
% b = [-42;-43;-41;-42;-41;-40;-44;-42;-42;-41;-42;-41;-41]
predictionn = predict(trainedClassifier2,cell2mat(router2nothingbetween(:,2))');
% predictionn = predict(trainedClassifier2,b');

predictionn = int16(predictionn);

% graph for b
% x=0:1:12;
% figure
% for fd=1:10
%  plot(x*4.62,b)
% end
%   title('Graph of signal strenght VS Time')
% xlabel('sec')
% ylabel('dBm')


%%%%%%%%% Prediction for closeness to Router 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
ff3=[];label3=[];
load ('router1c1.mat');
ii = size(router1c1,1)
for fnn = 1:5
    fnn
    size(cell2mat(router1c1(:,fnn)))
    ddff =cell2mat(router1c1(:,fnn))
    ff3=[ff3,ddff]  
    label3=[label3,1]
end
load ('router1c2.mat');
iii = size(router1c2,1);
for fnn = 1:10
    fnn;
    ddffq =cell2mat(router1c2(:,fnn))
    ff3=[ff3,ddffq]  
    label3=[label3,0]
end
size(ff3)
size(label3)
trainedClassifier3 = fitcknn( ...
    ff3', ...
     label3, ...
    'Distance','euclidean', ...
    'NumNeighbors',1, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(label3));
%%%%% change for close to R1 here [12]
% c = [ -51;-47;-51;-54;-50;-53;-49;-52;-48;-56;-52;-46]

predictionn3 = predict(trainedClassifier3,cell2mat(router1c2(:,2))');
% predictionn3 = predict(trainedClassifier3,c');

predictionn3 = int16(predictionn3);

% graph for c
%  x=0:1:11;
% figure
% for fd=1:10
%  plot(x*5,c)
% end
%    title('Graph of signal strenght VS Time')
% xlabel('sec')
% ylabel('dBm')

%plot(router1c2(:,2)),Y)

%%%%%%%%% Prediction for direction %%%%%%%%%%%%%%%%%%%%%%%%%%
ff4=[];label4=[];
load ('router1towards1.mat');
ii = size(router1towards1,1)
for fnn = 1:5
    fnn
    size(cell2mat(router1towards1(:,fnn)))
    ddff =cell2mat(router1towards1(:,fnn))
    ff4=[ff4,ddff]  
    label4=[label4,1]
end
load ('router1towards2.mat');
iii = size(router1towards2,1);
for fnn = 1:10
    fnn;
    ddffq =cell2mat(router1towards2(:,fnn))
    ff4=[ff4,ddffq]  
    label4=[label4,0]
end
size(ff4)
size(label4)
trainedClassifier4 = fitcknn( ...
    ff4', ...
     label4, ...
    'Distance','euclidean', ...
    'NumNeighbors',1, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(label4));

%%%%% change for R1 direction here [12]
 d = [ -48;-57;-57;-46;-51;-54;-51;-51;-53;-46;-52;-56]

predictionn33 = predict(trainedClassifier4,cell2mat(router1towards2(:,2))');
 predictionn33 = predict(trainedClassifier4,d');

predictionn33 = int16(predictionn33);

% graph for d
 x=0:1:11;
 figure
 for fd=1:10
  plot(x*5,d)
 end
    title('Graph of signal strenght VS Time')
 xlabel('sec')
 ylabel('dBm')

%%%%%%%%% Prediction for closeness to Router 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%
ff5=[];label5=[];
load ('router2c2.mat');
ii = size(router2c2,1)
for fnn = 1:10
    fnn
    size(cell2mat(router2c2(:,fnn)))
    ddfff =cell2mat(router2c2(:,fnn))
    ff5=[ff5,ddfff]  
    label5=[label5,1]
end
load ('router2c1.mat');
iii = size(router2c1,1);
for fnn = 1:5
    fnn;
    ddfff =cell2mat(router2c1(:,fnn))
    ff5=[ff5,ddfff]  
    label5=[label5,0]
end
size(ff5)
size(label5)
trainedClassifier5 = fitcknn( ...
    ff5', ...
     label5, ...
    'Distance','euclidean', ...
    'NumNeighbors',1, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(label5));

%%%%%% change for close to R1 here [12]
% e = [ -48;-57;-57;-46;-51;-54;-51;-51;-53;-46;-52;-56]
% e = [ -42;41;-42;-43;-42;-42;-42;-42;-41;-42;-46;-44]

predictionn333 = predict(trainedClassifier5,cell2mat(router2c2(:,2))');
% predictionn333 = predict(trainedClassifier5,e');

predictionn333 = int16(predictionn333);

% graph for e
%  x=0:1:11;
% figure
% for fd=1:10
%  plot(x*5,e)
% end
%   title('Graph of signal strenght VS Time')
% xlabel('sec')
% ylabel('dBm')
