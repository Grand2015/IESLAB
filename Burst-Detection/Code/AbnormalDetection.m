%% �쳣�¼����
% 1,HJM��P���� 
% 2,��P����
% 3,ZDD�յ㷽��
% ������Ϊ1,2��ʱ��input1��ʾaverage��input2��ʾstandard
% ������Ϊ3��ʱ��input1��ʾ�յ����ݣ�input��Ϊ0
% multiple:Delta�ı���
% ���ߣ�grand
% ʱ�䣺2017.09.11

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
		[row,column] = size(input);%row������У�column�������
		

	else
	end
end

