clc;
clear all;
%% 
load('BurstTestDataSmooth.mat');
load('average.mat');
% load('X.mat');
% load('Y.mat');
% load('shuju.mat')
% shuju(4,4)=19851.32;
% for i=1:8
%     result(i,1)=sqrt((shuju(i,1)-shuju(i,3))^2+(shuju(i,2)-shuju(i,4))^2);
% end



observe4_3Smooth = BurstTestDataSmooth-average;

 for i = 1:14
     step=1;
    for row = 556:step:562
        burst1_l300(row-555,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 563:step:568
        burst1_l150(row-562,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第2次爆管数据
    for row = 575:step:581
        burst2_l300(row-574,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 582:step:606
        burst2_l200(row-581,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第3次爆管数据
    for row = 612:step:618
        burst3_l300(row-611,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 620:step:627
        burst3_l100(row-619,i)=(observe4_3Smooth(row,i)*100);
    end
    
     %第4次爆管数据
    for row = 633:step:639
        burst4_l300(row-632,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 644:step:648
        burst4_l100(row-643,i)=(observe4_3Smooth(row,i)*100);
    end
    
    %第5次爆管数据
    for row = 654:step:663
        burst5_l200(row-653,i)=(observe4_3Smooth(row,i)*100);
    end
    for row = 665:step:672
        burst5_l100(row-664,i)=(observe4_3Smooth(row,i)*100);
    end
    
%     step=1;
%     for row = 556:step:562
%         burst1_l300(row-555,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(555,i))*100);
%     end
%     for row = 563:step:568
%         burst1_l150(row-562,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(562,i))*100);
%     end
%     
%     %第2次爆管数据
%     for row = 575:step:581
%         burst2_l300(row-574,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(574,i))*100);
%     end
%     for row = 582:step:606
%         burst2_l200(row-581,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(581,i))*100);
%     end
%     
%     %第3次爆管数据
%     for row = 612:step:618
%         burst3_l300(row-611,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(611,i))*100);
%     end
%     for row = 620:step:627
%         burst3_l100(row-619,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(619,i))*100);
%     end
%     
%      %第4次爆管数据
%     for row = 633:step:639
%         burst4_l300(row-632,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(632,i))*100);
%     end
%     for row = 644:step:648
%         burst4_l100(row-643,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(643,i))*100);
%     end
%     
%     %第5次爆管数据
%     for row = 654:step:663
%         burst5_l200(row-653,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(653,i))*100);
%     end
%     for row = 665:step:672
%         burst5_l100(row-664,i)=((observe4_3Smooth(row,i)-observe4_3Smooth(664,i))*100);
%     end
%     

 end
% min1(:,1)=((burst1_l300))';
% min1(:,2)=((burst1_l150))';
% min1(:,3)=((burst2_l300))';
% min1(:,4)=((burst2_l200))';
% min1(:,5)=((burst3_l300))';
% min1(:,6)=((burst3_l100))';
% min1(:,7)=((burst4_l300))';
% min1(:,8)=((burst4_l100))';
% min1(:,9)=((burst5_l200))';
% min1(:,10)=((burst5_l100))';
 

burst1_l300=abs(burst1_l300);
burst1_l300(:,3)=[];
X(3,:)=[];
Y(3,:)=[];
for l=4:7
sumx=0;
sumy=0;
sump=0;
for i=1:13
    x=burst1_l300(l,i)*X(i,1);
    sumx=sumx+x;
    y=burst1_l300(l,i)*Y(i,1);
    sumy=sumy+y;
    sump=burst1_l300(l,i)+sump;
end
Cx=sumx/sump;
Cy=sumy/sump;

res(1,l)=Cx;
res(2,l)=Cy;
   
end


min1(:,1)=(min(burst1_l300))';
min1(:,2)=(min(burst1_l150))';
min1(:,3)=(min(burst2_l300))';
min1(:,4)=(min(burst2_l200))';
min1(:,5)=(min(burst3_l300))';
min1(:,6)=(min(burst3_l100))';
min1(:,7)=(min(burst4_l300))';
min1(:,8)=(min(burst4_l100))';
min1(:,9)=(min(burst5_l200))';
min1(:,10)=(min(burst5_l100))';


% min1=roundn(min1,-2);

min1=abs(min1);
i=1;%第i列
a=sum(min1(:,1));


min1()

for j=1:10
sumx=0;
sumy=0;
sump=0;
for i=1:14
    x=min1(i,j)*X(i,1);
    sumx=sumx+x;
    y=min1(i,j)*Y(i,1);
    sumy=sumy+y;
    sump=min1(i,j)+sump;
end
Cx=sumx/sump;
Cy=sumy/sump;

res(1,j)=Cx;
res(2,j)=Cy;

end


SystemInfor( )