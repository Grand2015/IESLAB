%% Òì³£ÊÂ¼þÕì²â
% ±í1
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% | ÐòºÅ |        ·½·¨        | input |      input1     |    input2   | method |   mltiple  |  interval |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |   1    | HJMµÄP·½·¨  |   P   |     average    | standard |       1      | ²Î¿¼±í2 | 1,2,3,4  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |   2    |      ¦ÄP·½·¨      |   ¦ÄP  | averageDel | standard |       2      | ²Î¿¼±í2 | 1,2,3,4  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |   3   | ZDD¹Õµã·½·¨ |   ¦ÄP  |   boundary   |        0      |        3     |       0       | 1,2,3,4  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª


% multiple:DeltaµÄ±¶Êý(±í2)
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% | ÐòºÅ | multiple | step | 
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |  1   |     1    |   8  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |  2   |     2    |   4  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |  3   |     3    |   2  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% |  4   |     4    |   1  |
% ¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª¡ª
% ×÷Õß£ºgrand
% Ê±¼ä£º2017.09.11

function [output] = AbnormalDetection(input,input1,input2,method,multiple,interval)

%% SPC¼ì²â·½·¨±ê×¼
if multiple==1
	step = 8;
elseif multiple==2
	step = 4;
elseif multiple==3
	step = 2;
elseif multiple==4
	step = 1;
end

%% ±¬¹Ü¼ì²â
% row¾ØÕóµÄÐÐ£¨Öµ£ºP1440£¬¦ÄP1439£©£¬column¾ØÕóµÄÁÐ£¨Öµ£º14ÁÐ£©
[row,column] = size(input);

%Ôö´ó²ÉÑù¼ä¸ô
% ´ÓµÚÒ»Ïî¿ªÊ¼£¬µÈ¼ä¸ôn¶Ôx²ÉÑù£¬µÃµ½µÄÐòÁÐ¡£Îªy¡£
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

