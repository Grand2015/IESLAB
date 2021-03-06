% 函蔵主要实现对实验蔵綢的压力处理或者压力变化的处理
% flag=1表示输出δP的结果，Output=δInput；flag=0表示输出P的结果，Output=Input
% 作者：grand
% 时间：2017.09.10
function [average,standard,Output] = POrDeltaP(Input,flag)

[row,column] = size(Input);%row矩阵的GG，column矩阵的罣
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
