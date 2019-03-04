%% Skapar en databas av 250 bilder - Detta tar tid!
% Skapar en mat fil av alla bilder (minibilderna blir storlek 25x25 pixlar)
for k=1:250
   % Läser in alla bilder från mappen
   image = imread(sprintf('ImageDatabase/%d.jpg',k));
   % Förstorar eller förminskar bilder till en bestämd storlek
   h(:,:,:,k) = imresize(image, [25 25], 'bicubic');
   % Konverterar från rgb till lab
   lab(:,:,:,k) = rgb2lab(h(:,:,:,k));
end
save ImageData h lab 

%% Mosaic
im = imread('ImageDatabase/1.jpg'); % Bilden som ska reproduceras
inImg = imresize(im, [1500 1500]); % 1500x1500 pixlar
inImgLab = rgb2lab(inImg);

% Portrait 
portratt = imread('TestImages/portratt.jpg'); % Bilden som ska reproduceras
portratt = imresize(portratt, [1500 1500]); % 1500x1500 pixlar
portrattLab = rgb2lab(portratt);

% Dark image
mork = imread('TestImages/mork.jpg'); % Bilden som ska reproduceras
mork = imresize(mork, [1500 1500]); % 1500x1500 pixlar
morkLab = rgb2lab(mork);

% Light image 
ljus = imread('TestImages/ljus.jpg'); % Bilden som ska reproduceras
ljus = imresize(ljus, [1500 1500]); % 1500x1500 pixlar
ljusLab = rgb2lab(ljus);

nBlocks = 3; % Anger antalet subblocks
tileAve = getAverages(lab,nBlocks);

%% Halverar databasen till 100 bilder
[hundra, hunAve] = generateData(h, tileAve, 100);

%% Halverar databasen till 50 bilder
[femtio, femAve] = generateData(h, tileAve, 50); 

%% Resultat
mosaicImg = mosaic(inImg, inImgLab, h, tileAve); %skapar mosaicbilden 
mosaicPortratt = mosaic(portratt, portrattLab, h, tileAve); %skapar portrait mosaic
mosaicMork = mosaic(mork, morkLab, h, tileAve); %skapar mork mosaic 
mosaicLjus = mosaic(ljus, ljusLab, h, tileAve); %skapar ljus mosaic 
