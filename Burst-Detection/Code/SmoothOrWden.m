% ����ʵ�ֶ�ԭʼ���ݵ�Ԥ������
% ��Ҫ�����Ƿ����С�������ƽ������������
% flag=1��ʾ����С�������ƽ������
% flag=0��ʾֻ����ƽ������

% ���ߣ�grand
% ʱ�䣺2017.09.10

function Output = SmoothOrWden(Input,flag)
lev = 3;
[row,column] = size(Input);
for i = 1:column
    Output(:,i) = smooth(Input(:,i),5);
    if flag==1
        Output(:,i) = wden(Output(:,i),'heursure','s','mln',lev,'sym8');
    end
end

