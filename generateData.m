function [data, average] = generateData(tileData, tileAve, dataSize)
    
    [subImg, numTilesAve, colorChannels] = size(tileAve); 
    [height, width, colorChannel, numTiles] = size(tileData);
    data = zeros(height, width, colorChannel, numTiles);
    average = zeros(subImg, dataSize, colorChannels);
    
    for y = 1:dataSize
       
        dist = zeros(1,numTilesAve);	% Initialize distance vector
        
        for k = 1:numTilesAve
            % Compute the euclidean distance
            dist = dist + sqrt(  (tileAve(:, y, 1) - tileAve(:, k, 1)).^2 + ...
                                 (tileAve(:, y, 2) - tileAve(:, k, 2)).^2 + ...
                                 (tileAve(:, y, 3) - tileAve(:, k, 3)).^2  );
        end           
       
        % Remove the first value 
        dist(1) = [];  
        
        % Find the minium distance, minDist = value, match = index of that value
		[~, match] = min(dist);  

		data(:,:,:,y) = tileData(:,:,:,match);
        average(:,y,:) = tileAve(:,match,:);
    end
end

