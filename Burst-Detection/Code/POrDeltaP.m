% ���i��Ҫʵ�ֶ�ʵ���i�I��ѹ����������ѹ���仯�Ĵ���
% flag=1��ʾ�����P�Ľ����Output=��Input��flag=0��ʾ���P�Ľ����Output=Input
% ���ߣ�grand
% ʱ�䣺2017.09.10
function [average,standard,Output] = POrDeltaP(Input,flag)

[row,column] = size(Input);%row�����GG��column������G
if flag==1
    for i=1:column
        for j=1:row-1
            InputDelta(j,i) = Input(j+1,i)-Input(j,i);
        end
    end
    Output = InputDelta;
else
    Output = Input;
end
average = mean(Output,2);
standard = std(Output,0,2);