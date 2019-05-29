c=1;
vcordg2=[];
p=0;

for t=0:0.005:1
    far=0;frr=0;
    for i=1:230
        temp=vscg(:,i);
        x=min(temp);
        y=max(temp);
        for j=1:1150%3088
            temp(j)=(temp(j)-x)/(y-x);
        end
        for j=1:1150
            
                if j==i*5
                if temp(j)<=t
                    frr=frr+1;
                end
                continue
                end
                
                if j==(i*5-1)
                if temp(j)<=t
                    frr=frr+1;
                end
                continue
                end
                
                if j==(i*5-2)
                if temp(j)<=t
                    frr=frr+1;
                end
                continue
                end
                
                if j==(i*5-3)
                if temp(j)<=t
                    frr=frr+1;
                end
                continue
                end
                
                if j==(i*5-4)
                if temp(j)<=t
                    frr=frr+1;
                end
                continue
                end
%                 if j==i
%                     if temp(j)<=t
%                         frr=frr+1;
%                     end
%                     continue
%                 end

%                 if j==(i*5-5)
%                 if temp(j)<=t
%                     frr=frr+1;
%                 end
%                 continue
%                 end
%                 
%                 if j==(i*5-6)
%                 if temp(j)<=t
%                     frr=frr+1;
%                 end
%                 continue
%                 end
%                 
%                 if j==(i*5-7)
%                 if temp(j)<=t
%                     frr=frr+1;
%                 end
%                 continue
%                 end
%                 
%                 if j==(i*5-8)
%                 if temp(j)<=t
%                     frr=frr+1;
%                 end
%                 continue
%                 end
%                 
%                 if j==(i*5-9)
%                 if temp(j)<=t
%                     frr=frr+1;
%                 end
%                 continue
%                 end
% 

            if temp(j)>t
                far=far+1;
            end 
        end
    end
    vcordg2(c,:)=[far*100/(230*1145) frr*100*4/(5*230)];%[far*50/(386*3080) frr*50*4/(386*8)];
    c=c+1;
end

                
            