function [img,ham,ri,regionLine,eeee] = newRoi(name)
try
ham=0;
%A = imread(name);
A=name;
G = rgb2gray(A);
ham=12;
%G=imadjust(G);
GG=imgaussfilt(G, 29);

%GG = wiener2(G, 15);
ham=12;
%GG=imboxfilt(A, 11);
BWE = im2bw(GG, graythresh(GG));

BNW = regionprops(BWE, 'BoundingBox');
BNW = struct2cell(BNW);
Box = BNW{1}; ham=1;
for e=1:length(BNW)
    tst=(BNW{e}(3))*(BNW{e}(4));
    if (Box(3)*Box(4))<tst
        Box=BNW{e};
    end
end
ham=2;
earnest=imcrop(G, Box);
BWS = regionprops(BWE, 'FilledImage');
BWS = struct2cell(BWS);
Imge = BWS{1};
for ee=1:length(BWS)
    sts=(size(BWS{ee},1))*(size(BWS{ee},2));
    if ((size(Imge,1))*(size(Imge,2)))<sts
        Imge=BWS{ee};
    end
end
BW = Imge;
[B,~,~] = bwboundaries(BW,'noholes');
centroid = regionprops(BW,'Centroid');
centroid = centroid.Centroid;
%[w, h]=size(G); 
ham=3;
outline = flipud(B{1});
regionLine = zeros(length(outline),3);
for i = 1:length(outline)
    regionLine(i,:) = [outline(i,2) outline(i,1) sqrt((outline(i,2)-centroid(1))^2+(outline(i,1)-centroid(2))^2)];
end
try
[~, i] = findpeaks(smooth(-regionLine(:,3),50),'MINPEAKDISTANCE',60,'MINPEAKHEIGHT',mean(-regionLine(:,3)));
catch    
[~, i] = findpeaks(smooth(-regionLine(:,3),50),'MINPEAKDISTANCE',10,'MINPEAKHEIGHT',mean(-regionLine(:,3)));    
end
ri=zeros(1,2);
if regionLine(i(1),2)>centroid(2)
    if (regionLine(i(1),1)+80)<regionLine(i(2),1)
        ri=[ri;[regionLine(i(1),1) regionLine(i(1),2)]];
    end
end  
ham=4;

for o=1:length(i)
    if regionLine(i(o),2)<centroid(2)
        ri=[ri;[regionLine(i(o),1) regionLine(i(o),2)]];
    end
end

ri=sortrows(ri);
xmin=floor((ri(2,1)+ri(3,1))/2); ymin=floor((ri(3,2)+ri(2,2))/2);
slp=(-ri(5,2)+ri(3,2))/(ri(5,1)-ri(3,1));  ham=13;
 ang=atan(slp)*180/pi;bluff=zeros(size((earnest),1),size((earnest),2));

 eeee=earnest;
%earnest=imrotate(earnest, -ang/2);
bluff((ymin:ymin+10),(xmin:xmin+10))=1;

%bluffed=imrotate(bluff, -ang/2, 'crop');
%[bl,~,~]=bwboundaries(bluffed);
bluffed=imrotate(bluff, -ang/2);
bluffed=bluff;
[bl,~,~]=bwboundaries(bluffed);
bll=cell2mat(bl(1)); nxmin=bll(1,2); nymin=bll(1,1);
ham=5;

if nymin>800
    nymin=800;
end
nxmin=nxmin+70;

% while (earnest((nymin+399),(nxmin+5))<80)
%    nymin=nymin-10;
% end
% while (earnest((nymin+399),(nxmin+345))<80)
%    nymin=nymin-10;
% end
img=imcrop(earnest, [nxmin nymin 349 399]);
if size(img,1)<400
    nymin=nymin-(400-size(img,1));
    img=imcrop(earnest, [nxmin nymin 349 399]);
end
%Adaptive histogram equalization is implemented
img=adapthisteq(img);
ham=6;
catch 
    img=zeros(400, 350);
    
end
end

