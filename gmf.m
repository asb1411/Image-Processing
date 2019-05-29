function [m] = gmf(img)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
m = zeros(1,100);
[c, sig] = meanStd(img);

for o=1:100
    siz=(size(img{o},1)*size(img{o},2));
    colv = zeros(1,siz);
    if(sig(o)~=0)
    sum=0;
    colv = double(reshape(img{o}, [], 1));
    for u=1:siz
        sum = sum + colv(u)*gaussmf(colv(u), [sig(o) c(o)]);
    end
    m(o)=sum/(siz);
    end
end    
end

