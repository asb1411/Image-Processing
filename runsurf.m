function [ye,nc,sc,per] = runsurf(numVar, numImg)
%addpath('C:\Users\ameya\Documents\MATLAB\seg');
%addpath('C:\Users\ameya\Documents\MATLAB\PRoiN');
addpath('C:\Users\ameya\Documents\MATLAB\iitr');
%[imds, imgs, bag, cls, cls2, c, clfr, ca, cak, imds2, imgs2, nc, ye]
cls=zeros(numVar*numImg,1);

cls2=zeros(numVar,1);

c=1;

err=[];

ca=cell([numVar*numImg,1]);

for in=1:numVar
%     if in>10 && in<18
%         continue
%     end
for ii=1:numImg
    
%     if(in<10)
%         apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
%     
%     if(in>9 && in<100)
%         apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
%     
%     if(in>99)
%         apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
% %     
%      apa="ROI-"+apa;
% 
    if(in<10)
        apa="00"+in+"_"+ii+".bmp";
    end
    
    if(in>9 && in<100)
        apa="0"+in+"_"+ii+".bmp";
    end
    
    if(in>99)
        apa=""+in+"_"+ii+".bmp";
    end
    
    try
    jst=imread(apa);
%     if jst==0
%         continue
%     end
    apa=char(apa);
    ca{c}=apa;
    
     
     cls(c)=in;
     c=c+1;
     catch
        err=[err; in;ii];
     end
     
end
end

% rmpath('C:\Users\ameya\Documents\MATLAB\iitr');
% addpath('C:\Users\ameya\Documents\MATLAB\seg');
% 
% for in=1:numVar
% %     if in>10 && in<18
% %         continue
% %     end
% for ii=1:numImg
%     
% %     if(in<10)
% %         apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     if(in>9 && in<100)
% %         apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     if(in>99)
% %         apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     apa="ROI-"+apa;
% 
%     if(in<10)
%         apa="00"+in+"_"+ii+".bmp";
%     end
%     
%     if(in>9 && in<100)
%         apa="0"+in+"_"+ii+".bmp";
%     end
%     
%     if(in>99)
%         apa=""+in+"_"+ii+".bmp";
%     end
%     
%     try
%     jst=imread(apa);
% %     if jst==0
% %         continue
% %     end
%     apa=char(apa);
%     ca{c}=apa;
%     
%      
%      cls(c)=in;
%      c=c+1;
%      catch
%         err=[err; in;ii];
%      end
%      
% end
% end


c=c-1;

imds=imageDatastore(ca,'LabelSource','foldernames');
imgs=readall(imds);
nn=grp2idx(imds.Labels);
%fh=@sift;
%fh=@brisk;

for uo=1:length(nn)
    nn(uo)=cls(uo);
end

imds.Labels=categorical(nn);
bag = bagOfFeatures(imds,'Verbose',false,'StrongestFeatures',0.5) ;%'CustomExtractor',fh,

% for uo=1:length(nn)
%     fv(uo,:)=encode(bag,imgs{uo});
% end

%ml=TreeBagger(c, fv, cls, 'Method', 'Classification');
clfr=trainImageCategoryClassifier(imds,bag);
%ml=fitcknn(fv, cls, 'NSMethod', 'euclidean');

nc=0;
crt=0;
cak=cell([numVar,1]);
c2=1;
in=1;
lbl=zeros(numVar,1);

for in=1:numVar
for ii=1:5
    
%     if(in<10)
%         apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
%     
%     if(in>9 && in<100)
%         apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
%     
%     if(in>99)
%         apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
%     end
% %     
%      apa="ROI-"+apa;
%     
    if(in<10)
        apa="00"+in+"_"+ii+".bmp";
    end
    
    if(in>9 && in<100)
        apa="0"+in+"_"+ii+".bmp";
    end
    
    if(in>99)
        apa=""+in+"_"+ii+".bmp";
    end

    %ap=newRoi(apa);
    try
        
    ap=imread(apa);
    cls2(c2)=in;
    
    apa=char(apa);
    cak{c2}=apa;
    c2 = c2 + 1;
    
    catch
        continue
    end
end
end

% rmpath('C:\Users\ameya\Documents\MATLAB\seg');
% addpath('C:\Users\ameya\Documents\MATLAB\iitr');
%    
% for in=1:numVar
%     ii=5;
%     
% %     if(in<10)
% %         apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     if(in>9 && in<100)
% %         apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     if(in>99)
% %         apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
% %     end
% %     
% %     apa="ROI-"+apa;
%     
%     if(in<10)
%         apa="00"+in+"_"+ii+".bmp";
%     end
%     
%     if(in>9 && in<100)
%         apa="0"+in+"_"+ii+".bmp";
%     end
%     
%     if(in>99)
%         apa=""+in+"_"+ii+".bmp";
%     end
% 
%     %ap=newRoi(apa);
%     try
%         
%     ap=imread(apa);
%     cls2(c2)=in;
%     
%     apa=char(apa);
%     cak{c2}=apa;
%     c2 = c2 + 1;
%     
%     catch
%         continue
%     end
% end

sc=[];
imds2=imageDatastore(cak,'LabelSource','foldernames');
imgs2=readall(imds2);
%nn=grp2idx(imds2.Labels);
%bag2 = bagOfFeatures(imds2,'Verbose',false) ;

for uo=1:length(cls2)
%     if uo>10 && uo<18
%         continue
%     end
    %fv2=encode(bag,imgs2{uo});
    [labelIdx, sc(nc+1,:)] = predict(clfr,imgs2{uo});
    %[labelIdx, sc(nc+1,:)] = predict(ml,fv2);
    %labelIdx = predict(ml,fv2);
%     if cls2(uo)<17
    if labelIdx==cls2(uo)
        crt=crt+1;
    end
%     end
%     if cls2(uo)>17
%         if labelIdx+7==cls2(uo)
%         crt=crt+1;
%         end
%     end
%     if str2num(labelIdx{1})==cls2(uo)
%         crt=crt+1;
%     end
    nc=nc+1;
    lbl(nc)=labelIdx;
end

for yu=1:length(cls)
     %fv3=encode(bag,imgs{yu});
%     try
     [labelIdx, sc((nc+1),:)] = predict(clfr,imgs{yu});
     %[labelIdx, sc(nc+1,:)] = predict(ml,fv3);
%     labelIdx = predict(ml,fv3);
%    if cls(yu)<17
     if labelIdx==cls(yu)
         crt=crt+1;
     end
%     end
%     if cls(yu)>17
%         if labelIdx+7==cls(yu)
%         crt=crt+1;
%         end
%     end
%     catch
%         continue
%     end
%     if str2num(labelIdx{1})==cls(yu)
%         crt=crt+1;
%     end
      nc=nc+1;
% end
% 
 per=(crt/nc)*100;
ye=crt;
end

