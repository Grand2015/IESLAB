%% 异常事件侦测
% 1,HJM的P方法 
% 2,δP方法
% 3,ZDD拐点方法
% 当方法为1,2的时候，input1表示average，input2表示standard
% 当方法为3的时候，input1表示拐点数据，input设为0
% multiple:Delta的倍数
% 作者：grand
% 时间：2017.09.11

function [] = AbnormalDetection(input,input1,input2,method,multiple)

if multiple==1
	step = 8;
elseif multiple==2
	step = 4;
elseif multiple==3
	step = 2;
elseif multiple==4
	step = 1;
end


if method==3
else
	if method==1
		[row,column] = size(input);%row矩阵的行，column矩阵的列
		

	else
	end
end

