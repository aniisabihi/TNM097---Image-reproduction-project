function [tileData, tileAve] = OptimizeData(tileData, tileAve, original, dataSize)

    [~, numberOfTiles, ~] = size(tileAve);
    
    [height, width, channels] = size(original);
    
    maxValue = max(sqrt((original(1,1,1).^2 + original(1,1,2).^2 + original(1,1,3).^2)));
    
    for i = 1: height
        for j = 1:width
            tempMax = sqrt((original(i,j,1).^2 + original(i,j,2).^2 + original(i,j,3).^2));
            if tempMax > maxValue
                maxValue = tempMax;
                indexwidth = j;
                indexHeight = i;
            end
        end
    end
    
    
    for y = 1:numberOfTiles
    
            
            [~, numberOfTiles, ~] = size(tileAve);
            dist = zeros(1,numberOfTiles);	% Initialize distance vector
            
            while numberOfTiles > dataSize
               
                for k = 1:numberOfTiles
                    % Compute the euclidean distance
                    dist = dist + sqrt(  (tileAve(:, y, 1) - tileAve(:, k, 1)).^2 + ...
                                         (tileAve(:, y, 2) - tileAve(:, k, 2)).^2 + ...
                                         (tileAve(:, y, 3) - tileAve(:, k, 3)).^2  );
                 
                end  
                % Remove the first value 
                [minDist, match] = min(dist); 
                if minDist == 0
                    dist(match) = [];  
                end

                % Find the minium distance, minDist = value, match = index of that value
                [~, match] = min(dist); 

                tileData(:,:,:,match) = [];
                tileAve(:,match,:) = [];

                [~, numberOfTiles, ~] = size(tileAve);
            
                
            end
      
    end
end