%% �յ�ȷ������
% ȷ��ѹ�����ݵĹյ㺯������������Ƶ������

function LimitQuery(input,interval)
[row,column] = size(inputSample);
for i=1:column
    inputSample(:,i) = downsample(input(:,i), interval);
end
[row,column] = size(inputSample);
for i = 1:column
    figure(i);
	normplot(inputSample(:,i));
	title(['��',num2str(i),'���ѹ���仯�ۼƸ���']);
end
