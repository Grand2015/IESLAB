function y=CalcuRMS(data,n)
%计算有效值函数
y=0;
ga(1)=data(1)^2;
ga(2)=data(2)^2;
for i=3:n
    ga(i)=data(i)^2;
    y=y+(ga(i-2)+4*ga(i-1)+ga(i))/6;
end
y=sqrt(y/n);