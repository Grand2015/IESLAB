% 函数实现对原始数据的预处理工作
% 主要包含是否进行小波降噪和平滑降噪两部分
% flag=1表示进行小波降噪和平滑降噪
% flag=0表示只进行平滑降噪

% 作者：grand
% 时间：2017.09.10

function Output = SmoothOrWden(Input,flag)
lev = 3;
[row,column] = size(Input);
for i = 1:column
    Output(:,i) = smooth(Input(:,i),5);
    if flag==1
        Output(:,i) = wden(Output(:,i),'heursure','s','mln',lev,'sym8');
    end
end

