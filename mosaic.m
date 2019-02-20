% http://ssli.ee.washington.edu/courses/ee299/labs/Lab4.pdf
% MOSAIC Builds a photographic mosaic.
%
%	MOSAIC(IMG, TILEDATA, TILEAVE) generate a photographic mosaic from the
%	source image IMG with tiles from the tile-set TILEDATA.  Uses averages
%	stored in TILEAVE to find best matching tile in the tile-set.
%

function [ ret ] = mosaic(img, tileData, tileAve)

% Get the size of tiles in the tile-set
tileSize = size(tileData, 1);

% Figure out how many nBlocks there were
nBlocks = round(sqrt(size(tileAve, 1)));

% Get the dimensions of the image
[imgHeight, imgWidth, imgChan] = size(img);

% Check that the image is cropped correctly
if (floor(mod(imgHeight, tileSize)) ~= 0) error('Tiles do not divide equally into the size of the image, is the image cropped?'); end;
if (floor(mod(imgWidth, tileSize)) ~= 0) error('Tiles do not divide equally into the size of the image, is the image cropped?'); end;
if (imgChan ~= 3) error('This does not seem to be an RGB image.'); end;

% Initialize the image to be returned
ret = img; %zeros(imgHeight, imgWidth, 3, 'uint8');

% Generate the boundaries for the blocks
colIdx = floor(linspace(0, tileSize, nBlocks+1));
rowIdx = floor(linspace(0, tileSize, nBlocks+1));

figure

% Iterate through each sub-image in the image
for y = 1:tileSize:imgHeight
	for x = 1:tileSize:imgWidth
		% Pick out which sub-image we want to work on
		vectY = y:y+tileSize-1;
		vectX = x:x+tileSize-1;
	
		% Get a sub-image
		subBlock = img(vectY, vectX, :);
		
		dist = zeros(1, size(tileAve,2));	% Initialize distance vector
		k = 1; % Index for each sub-sub-block in tile
		
		% Iterate through each block and record it's average for each color channel
		for i = 1:length(colIdx)-1
			for j = 1:length(rowIdx)-1
				% Red
				blockAve(1) = mean2(subBlock(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 1));
				% Green
				blockAve(2) = mean2(subBlock(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 2));
				% Blue
				blockAve(3) = mean2(subBlock(colIdx(i)+1:colIdx(i+1), rowIdx(j)+1:rowIdx(j+1), 3));

				% Compute the distance between this sub-image and every tile in 
				% the tile-set at the kth sub-sub-block
				dist = dist + sqrt(  (tileAve(k, :, 1) - blockAve(1)).^2 + ...
									 (tileAve(k, :, 2) - blockAve(2)).^2 + ...
									 (tileAve(k, :, 3) - blockAve(3)).^2  );
								
				% Increment the sub-sub-block index
				k = k + 1;
			end
		end			
					
		% Find the minium distance, minDist = value, match = index of that value
		[minDist match] = min(dist);  
	
		% Put the tile from the tile-set into our result image
		ret(vectY, vectX, :) = tileData(:,:,:,match);
	end
	
	% Update each row as we go
	imshow(ret, 'InitialMagnification', 'fit')
	pause(0.001) % Gives imshow some time to draw	
end
