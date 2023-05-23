function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m
c1=-inv(K1*R1)*K1*t1;
c2=-inv(K2*R2)*K2*t2;

r11 = (c1-c2)/norm(c1-c2);
r12 = cross(R1(3,:),r11)';
r13 = cross(r12,r11);
R1n = [r11 r12 r13]';
K1n = K2;
t1n = -R1n*c1;
M1 = (K1n*R1n)/(K1*R1);

R2n = R1n;
K2n = K1n;
t2n = -R2n*c2;
M2 = (K2n*R2n)/(K2*R2);