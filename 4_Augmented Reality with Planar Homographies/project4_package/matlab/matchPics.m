function [ locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if(size(I1,3) == 3)
    I1=rgb2gray(I1);
end
if(size(I2,3) == 3)
    I2=rgb2gray(I2);
end

%% Detect features in both images
det_feature1 = detectFASTFeatures(I1);
det_feature2 = detectFASTFeatures(I2); 
%% Obtain descriptors for the computed feature locations
[desc1,locs1] = computeBrief(I1,det_feature1.Location);
[desc2,locs2] = computeBrief(I2,det_feature2.Location);

%% Match features using the descriptors
matches  = matchFeatures(desc1, desc2,'MatchThreshold',10.0, 'MaxRatio', 0.7);
locs1 = locs1(matches(:,1),:);
locs2 = locs2(matches(:,2),:);
end

