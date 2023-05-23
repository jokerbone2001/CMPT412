% Your solution to Q2.1.5 goes here!

%% Read the image and convert to grayscale, if necessary
I1 = imread('../data/cv_cover.jpg');
if (size(I1,3) == 3)
    I1 = rgb2gray(I1);
end
counts1 = zeros(36,1);
counts2 = zeros(36,1);
countFast = [];
countSurf = [];
%% Compute the features and descriptors
det_featureFast = detectFASTFeatures(I1);
[descFast,locsFast] = computeBrief(I1,det_featureFast.Location);

det_featureSurf = detectSURFFeatures(I1);
[descSurf,locsSurf] = extractFeatures(I1,det_featureSurf.Location, 'Method', 'SURF');

for i = 0:36
    %% Rotate image
    rotate_I1=imrotate(I1,10*i);
    %% Compute features and descriptors
    det_featureFastR1 = detectFASTFeatures(rotate_I1);
    [descFastR1,locsFastR1] = computeBrief(rotate_I1,det_featureFastR1.Location);

    det_featureSurfR1 = detectSURFFeatures(rotate_I1);
    [descSurfR1,locsSurfR1] = extractFeatures(rotate_I1,det_featureSurfR1.Location, 'Method', 'SURF');
 
    %% Match features
    matchesFast = matchFeatures(descFast, descFastR1,'MatchThreshold', 10.0, 'MaxRatio', 0.8);
    matchesSurf = matchFeatures(descSurf, descSurfR1,'MatchThreshold', 10.0, 'MaxRatio', 0.8);

    locs1Fast = locsFast(matchesFast(:,1),:);
    locs2Fast = locsFastR1(matchesFast(:,2),:);

    locs1Surf = locsSurf(matchesSurf(:,1),:);
    locs2Surf = locsSurfR1(matchesSurf(:,2),:);
    if i == 27 || i == 16 || i == 8
        figure()
        showMatchedFeatures(I1,rotate_I1,locs1Fast,locs2Fast,'montage');
  
        title(['Brief degree', num2str(i*10)]);
    end
    if i == 27 || i == 16 || i == 8
        figure()
        showMatchedFeatures(I1,rotate_I1,locs1Surf,locs2Surf,'montage');
   
        title(['Surf degree', num2str(i*10)]);
    end
    %% Update histogram
    if i ~= 36 && i~=0
        countFast = size(matchesFast,1);
        countSurf = size(matchesSurf,1);
        counts1(i+1) = countFast;
        counts2(i+1) = countSurf;
    end
  
    
end

%% Display histogram
figure;
bar(counts1);
title('Brief');
ylabel('Number of matches');
xlabel('Count');

figure;
bar(counts2);
title('Surf');
ylabel('Number of matches');
xlabel('Count');