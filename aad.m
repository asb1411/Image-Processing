function [t] = aad(img)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
t=zeros(1,100);

[c, ~]=meanStd(img);

for y=1:100
    siz=(size(img{y},1)*size(img{y},2));
    colv = zeros(1,siz);
    sum=0;
    colv = double(reshape(img{y}, [], 1));
    for r=1:siz
        sum = sum + abs(colv(r)-c(y));
    end
    t(y)=sum/(siz);
end    
end

