%% 拐点确定函数
% 确定压力数据的拐点函数，包括采样频率设置

function LimitQuery(input,interval)
[row,column] = size(inputSample);
for i=1:column
    inputSample(:,i) = downsample(input(:,i), interval);
end
[row,column] = size(inputSample);
for i = 1:column
    figure(i);
	normplot(inputSample(:,i));
	title(['第',num2str(i),'测点压力变化累计概率']);
end
