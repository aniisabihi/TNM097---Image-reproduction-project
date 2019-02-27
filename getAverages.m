function [ ret ] = getAverages(ImData, nBlocks)

% Get dimensions of the tiles-set
[height, width, ~, numTiles] = size(ImData);

% Check to see if nBlocks makes sense
if (nBlocks < 1) 
    error('nBlocks must be greater than 0.'); end
if (nBlocks > round(height)) 
    error('nBlocks must be less than (height of tile).'); end
if (nBlocks > round(width)) 
    error('nBlocks must be less than (width of tile).'); end
if ((nBlocks - floor(nBlocks)) ~= 0) 
    error('nBlocks must be an integer.'); end

% Initialize the matrix that will be returned
ret = zeros(nBlocks^2, numTiles, 3);
		
% Generate the boundaries for the blocks
colIdx = floor(linspace(0, width, nBlocks+1));
rowIdx = floor(linspace(0, height, nBlocks+1));

% Iterate through each tile
for n = 1:numTiles
	k = 1;
	% Iterate through each sub-block of the tile and record it's average for each color channel
	for i = 1:length(colIdx)-1
		for j = 1:length(rowIdx)-1
			
            % Red
			ret(k, n, 1) = mean2(ImData(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 1, n));
			% Green
			ret(k, n, 2) = mean2(ImData(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 2, n));
			% Blue
			ret(k, n, 3) = mean2(ImData(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 3, n));
			
			% inc the block
			k = k + 1;
		end
	end			
end	
	