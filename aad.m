function [t] = aad(img)
% Extracts the Average Absolute Deviation of the given image cell
%   Input img: Cell of image windows...create image windows using divImg function
%   Output t: Feature vector of length 100
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

