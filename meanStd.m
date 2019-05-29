function [mean, std] = meanStd(img)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
mean = zeros(1,100);
std = zeros(1,100);
for l=1:100
mean(l) = mean2(img{l}); 
std(l) = std2(img{l});
end
end

