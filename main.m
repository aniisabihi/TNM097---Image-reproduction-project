%% Detta tar tid!
for k=1:250
   image = imread(sprintf('ImageDatabase/%d.jpg',k));
   h(:,:,:,k) = imresize(image, [25 25], 'bicubic');
   % Skapar en mat fil av alla bilder (minibilderna blir storlek 25x25 pixlar
   % Detta sker endast om vi vill byta storlek hos de mindre bilderna
end
save ImageData h

%% Mosaic
im = imread('ImageDatabase/1.jpg'); %bilden som ska reproduceras
inImg = imresize(im, [1500 1500]); %1500x1500 pixlar

nBlocks = 3; % Anger antalet subblocks
tileAve = getAverages(h,nBlocks);
mosaicImg = mosaic(inImg, h, tileAve); %skapar mosaicbilden 