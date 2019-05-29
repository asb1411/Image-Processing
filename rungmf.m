function [msmat, cls, c, nc, per, sc] = rungmf(numVar, numImg)
%addpath('D:\IITD Palmprint V1\Segmented\Right');
c=0;
%addpath('C:\Users\ameya\Documents\MATLAB\iitr');
addpath('C:\Users\ameya\Documents\MATLAB\PRoiN');
msmat=zeros(numVar*numImg,100);
cls=zeros(numVar*numImg,1);
c=1;
err=[];
%ca=cell([numVar*numImg,1]);
for in=1:numVar
for ii=1:numImg
%     if(in<10)
%         apa="00"+in+"_"+ii+".bmp";
%     end
%     if(in>9 && in<100)
%         apa="0"+in+"_"+ii+".bmp";
%     end
%     if(in>99)
%         apa=""+in+"_"+ii+".bmp";
%     end

    if(in<10)
        apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    if(in>9 && in<100)
        apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    if(in>99)
        apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    apa="ROI-"+apa;
    
    
    apa=char(apa);
    %ca{c}=apa;
    
    try
    ty=imread(apa);
    catch
        continue
    end 
    if ty==0
        continue
    end
    try
     app=divImg(ty);
     appd=meanStd(app);
     msmat(c,:)=appd;
    cls(c)=in;
    c=c+1;
    catch
        err=[err; c-1];
    end
    
end
end

% rmpath('C:\Users\ameya\Documents\MATLAB\iitr');
% addpath('C:\Users\ameya\Documents\MATLAB\seg');
% 
% for in=1:numVar
% for ii=1:numImg
%     if(in<10)
%         apa="00"+in+"_"+ii+".bmp";
%     end
%     if(in>9 && in<100)
%         apa="0"+in+"_"+ii+".bmp";
%     end
%     if(in>99)
%         apa=""+in+"_"+ii+".bmp";
%     end
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
%     
%     %apa=char(apa);
%     %ca{c}=apa;
%     
%     try
%     ty=imread(apa);
%     catch
%         continue
%     end 
%     if ty==0
%         continue
%     end
%     try
%      app=divImg(ty);
%      appd=aad(app);
%      aadmat(c,:)=appd;
%     cls(c)=in;
%     c=c+1;
%     catch
%         err=[err; c-1];
%     end
%     
% end
% end

c=c-1;
% fh=@sift;
% imds=imageDatastore(ca,'LabelSource','foldernames');
% imgs=readall(imds);
% nn=grp2idx(imds.Labels);
% bag = bagOfFeatures(imds,'Verbose',false,'CustomExtractor',fh,'VocabularySize',fghj,'StrongestFeatures',hjkl) ;
% for uo=1:length(nn)
%     nn(uo)=cls(uo);
%     fv(uo,:)=encode(bag,imgs{uo});
% end
% imds.Labels=categorical(nn);
% clfr=trainImageCategoryClassifier(imds,bag);


ml=fitcknn(msmat, cls, 'NSMethod', 'euclidean');
% %ml=TreeBagger(c, msmat, cls, 'Method', 'Classification');
sc=[];
%ml=fitcecoc(gmfmat, cls, 'Coding', 'onevsall', 'Learners', 'svm');
nc=0;
crt=0;

for in=1:numVar
for ii=1:8
%         if(in<10)
%             apa="00"+in+"_"+ii+".bmp";
%         end
%         if(in>9 && in<100)
%             apa="0"+in+"_"+ii+".bmp";
%         end
%         if(in>99)
%             apa=""+in+"_"+ii+".bmp";
%         end
    %ap=newRoi(apa);
    if(in<10)
        apa="00"+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    if(in>9 && in<100)
        apa="0"+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    if(in>99)
        apa=""+in+"_"+"F"+"_"+"0"+ii+".bmp";
    end
    
    apa="ROI-"+apa;
    
        
    try
    ap=imread(apa);
    
    catch
        continue
    end
    
%     [labelIdx, score] = predict(clfr,ap);
%     nc=nc+1;
%     if labelIdx==in
%         crt=crt+1;
%     end
%     try
     app=divImg(ap);
     appd=meanStd(app);
     [aan,sc(nc+1,:)]=predict(ml, appd);
%     if str2num(aan{1})==in
%         crt=crt+1;
%     end
     if aan==in
         crt=crt+1;
     end
    nc=nc+1;
%     catch
%         err=[err; nc-1];
%     end
    per=(crt/nc)*100;
    %t="s"+apa;
    %imwrite(ap, t);
    
end
end
% rmpath('C:\Users\ameya\Documents\MATLAB\seg');
% addpath('C:\Users\ameya\Documents\MATLAB\iitr');
% for in=1:numVar
%     for ii=1:5
%         if(in<10)
%             apa="00"+in+"_"+ii+".bmp";
%         end
%         if(in>9 && in<100)
%             apa="0"+in+"_"+ii+".bmp";
%         end
%         if(in>99)
%             apa=""+in+"_"+ii+".bmp";
%         end
%     %ap=newRoi(apa);
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
%         
%     try
%     ap=imread(apa);
%     
%     catch
%         continue
%     end
%     
% %     [labelIdx, score] = predict(clfr,ap);
% %     nc=nc+1;
% %     if labelIdx==in
% %         crt=crt+1;
% %     end
% %     try
%      app=divImg(ap);
%      appd=aad(app);
%      [aan,sc(nc+1,:)]=predict(ml, appd);
% %     if str2num(aan{1})==in
% %         crt=crt+1;
% %     end
%      if aan==in
%          crt=crt+1;
%      end
%     nc=nc+1;
% %     catch
% %         err=[err; nc-1];
% %     end
%     per=(crt/nc)*100;
%     %t="s"+apa;
%     %imwrite(ap, t);
%     end
%     
% end
end

