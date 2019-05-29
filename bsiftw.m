function [apa] = bsiftw(numVar,numImg)
c=1;
ind=1;
p=0;
addpath('C:\Users\ameya\Documents\MATLAB\iitr');
%addpath('D:\IITD Palmprint V1\Segmented\Right');
%addpath('C:\Users\ameya\Documents\MATLAB\PRoiN');
%addpath('C:\Users\ameya\Documents\MATLAB\seg');
%addpath('D:\IITD Palmprint V1\Segmented\Left');
for in=1:numVar
for ii=1:numImg
    
    if in>10 && in<18
        ind=10;
        continue
    end
    for v=[34,38,57,61,63,70,76,104,113,121,150,173,196]
        if in==v
            ind=ind-1;
            p=1;
            break
        end
    end
    if p==1
        p=0;
        break
    end

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
%     
%     apa="ROI-"+apa;
    
    
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
    ty=imread(apa);
    %ty=adapthisteq(ty);
    catch
        continue
    end
    
    
    if(in<10)
        apa="00"+in+"_"+ii+".bmp";%
    end
    if(in==10)
        apa="0"+in+"_"+ii+".bmp";
    end
    if(ind>9 && ind<100)
        apa="0"+ind+"_"+ii+".bmp";
    end
    if(ind>99)
        apa=""+ind+"_"+ii+".bmp";
    end
    
%     apa=char(apa);
%     ca{c}=apa;
    
    
    %ty=adapthisteq(ty,'Distribution','rayleigh');
 %   if ty==4
    
%     try 
%         addpath('D:\IITD Palmprint V1\Left Hand');
%         app=char(apa);
%         appp=app(2:end);
%         im=imread(appp);
%         ty=Roi(im);
%         
%         ty=adapthisteq(ty);
%         rmpath('D:\IITD Palmprint V1\Left Hand');
%     catch 
%         continue
%     end
    
    
%     if ty==0
%         continue
%     end
    c=c+1;
%     try
%     app=divImg(ty);
% %     appd=gmf(app);
% %     gmfmat(c,:)=appd;
% %     cls(c)=in;
% %     c=c+1;
%     catch
%         err=[err; c-1];
%     end
        %baseFileName = sprintf('%d_%d.bmp', in,ii);
        %folder=sprintf('C:\Users\ameya\Documents\MATLAB\%d',ji);
        fullFileName = fullfile('C:','Users','ameya','Documents','MATLAB','niitr',apa);
        imwrite(ty, fullFileName);
   
    
end
ind=ind+1;
end
end