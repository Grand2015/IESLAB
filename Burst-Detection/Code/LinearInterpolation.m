function Output = LinearInterpolation(Input)
%对数据进行线性插值处理
preSub = Input;
[row,column] = size(preSub);
NaNCount = numel(find(isnan(preSub)));%某天压力数据中缺省个数
    if NaNCount
        for n = 1:column %矩阵的列数，待测试
            if numel(find(isnan(preSub(:,n))))
                [rowNaN,columnNaN] = find(isnan(preSub(:,n)));
                count = numel(columnNaN);
                for c = 1:count
                    valNum = rowNaN(c,1);%valNum是压力数据中每个监测点的缺省压力值的纵坐标
                    valNext = valNum+1;
                    while (isnan(preSub(valNext,n)))
                        valNext = valNext+1;
                    end
                    a = 1/(valNext-valNum+1);
                    preSub(valNum,n) = preSub(valNum-1,n)+a*(preSub(valNext,n)-preSub(valNum-1,n));
                end
            end
        end
    end
    %检验线性插值处理结果
    NaNCountCheck = numel(find(isnan(preSub)));
    if NaNCountCheck
        fprintf('压力数据中仍然存在: %d 个缺省值', NaNCountCheck);
        pause( );
    end
	Output = preSub;