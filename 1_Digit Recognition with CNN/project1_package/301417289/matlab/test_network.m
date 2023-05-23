%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix
% for i=1:100:size(xtest, 2)
%     [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
% end
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~, out] = max(P,[],1);
    prediction(:,i:i+99) = out;
end
confusionchart(confusionmat(ytest, prediction), (0:9))