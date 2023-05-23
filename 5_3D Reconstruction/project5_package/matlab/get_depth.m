function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
[h,w]=size(dispM);
depthM = zeros(h,w);
f = K1(1,1);
b = sqrt(sum((t1-t2).^2));
for i = 1:h
    for j = 1:w
        if dispM(i,j)==0
            depthM(i,j)=0;
        else
            depthM(i,j)=b*f/dispM(i,j);
        end
    end
end