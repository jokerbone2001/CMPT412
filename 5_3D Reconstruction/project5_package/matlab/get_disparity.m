function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
winsize = (windowSize-1)/2;
[h,w] = size(im1);
dispM = zeros(h,w);
for i=1+winsize:h-winsize
    for j=1+winsize+maxDisp:w-winsize-maxDisp
        win1 = im1(i-winsize:i+winsize,j-winsize:j+winsize);
        min_error = inf;
        best_d = 0;
        for d = 0:maxDisp
            win2 = im2(i-winsize:i+winsize,j-winsize-d:j+winsize-d);
            error = sum(sum((win1-win2).^2));
            if error<min_error
                min_error=error;
                best_d = d;
            end
        end
        dispM(i,j)=best_d;
    end
        
end