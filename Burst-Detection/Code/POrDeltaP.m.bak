% 函数主要实现对实验数据的压力处理或者压力变化的处理
% flag=1表示输出δP的结果，Output=δInput；flag=0表示输出P的结果，Output=Input
% 作者：grand
% 时间：2017.09.10
function [average,standard,Output] = POrDeltaP(Input,flag)

[row,column] = size(Input);%row矩阵的行，column矩阵的列
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
