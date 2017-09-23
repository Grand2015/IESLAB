%% �쳣�¼����
% ��1
% ������������������������������������������������������������������������
% | ��� |        ����        | input |      input1     |    input2   | method |   mltiple  |  interval |
% ������������������������������������������������������������������������
% |   1    | HJM��P����  |   P   |     average    | standard |       1      | �ο���2 | 1,2,3,4  |
% ������������������������������������������������������������������������
% |   2    |      ��P����      |   ��P  | averageDel | standard |       2      | �ο���2 | 1,2,3,4  |
% ������������������������������������������������������������������������
% |   3   | ZDD�յ㷽�� |   ��P  |   boundary   |        0      |        3     |       0       | 1,2,3,4  |
% ������������������������������������������������������������������������


% multiple:Delta�ı���(��2)
% ����������������������������������������������������
% | ��� | multiple | step | 
% ����������������������������������������������������
% |  1   |     1    |   8  |
% ����������������������������������������������������
% |  2   |     2    |   4  |
% ����������������������������������������������������
% |  3   |     3    |   2  |
% ����������������������������������������������������
% |  4   |     4    |   1  |
% ����������������������������������������������������
% ���ߣ�grand
% ʱ�䣺2017.09.11

function [output] = AbnormalDetection(input,input1,input2,method,multiple,interval)

%% SPC��ⷽ����׼
if multiple==1
	step = 8;
elseif multiple==2
	step = 4;
elseif multiple==3
	step = 2;
elseif multiple==4
	step = 1;
end

%% ���ܼ��
% row������У�ֵ��P1440����P1439����column������У�ֵ��14�У�
[row,column] = size(input);

%����������
% �ӵ�һ�ʼ���ȼ��n��x�������õ������С�Ϊy��
for i=1:column
    inputSample(:,i) = downsample(input(:,i), interval);
end
%inputSample = downsample(input, interval);
if(interval==1)
    sampleNum=sampleNum-1;
else
    sampleNum=sampleNum/interval;
end

if method==3
	lowerLimit = input1;
else
	if method==1
		
	else
	
	end	
	for i = 1:column
		for j = 1:row 
			upperLimit(j,i) = input1(j,i)+multiple*input2(j,i);
			lowerLimit(j,i) = input1(j,i)-multiple*input2(j,i);
		end
	end 

end
burstCount = 0;
count = 0;
flag = 0;
burstBegin = 0;
burstEnd = 0;
indexTime = 1;

	

for i = 1:column
	for j = 1:row
		if(input(j,i)<lowerLimit(j,i))
			if(j<row)
				if(flag==0)
					burstBegin = j;
				end
				burstEnd = 0;
				flag = 1;
				count = count+1;
			elseif(j==row)					
				if(0==flag)
					count=1;
				else
					count=count+1;
				end
				if(count>=step)
				burstCount = burstCount+1;
					burstEnd = j;
					burstTime(i,indexTime) = burstBegin;
					burstTime(i,indexTime+1) = burstEnd;
					burstBegin = 0;
					burstEnd = 0;
				end
				flag = 0;
				count = 0;
			end
		elseif((input(j,i)>lowerLimit(j,i)) && (1==flag))
			if(count>=step)
				burstCount = burstCount+1;
				burstEnd = j-1;
				burstTime(i,indexTime) = burstBegin;
				burstTime(i,indexTime+1) = burstEnd;
				indexTime = indexTime+3;
				burstBegin = 0;
				burstEnd = 0;
			end
			flag = 0;
			count = 0;
		end
	end
	burstCountMatrix(1,i) = burstCount;
	burstCount = 0;
	indexTime=1;
end
disp('End')

