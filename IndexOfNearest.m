function [index] = IndexOfNearest(pixel,dataBase)
    
    mean_value = zeros(1,250);
    for i = 1:250
        [mean_value(i)] = compute_euclidian(pixel,dataBase{i});
    end


    [val,index] = min(mean_value);
end