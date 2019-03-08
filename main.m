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

%% Load database
load ImageData

%% Mosaic
im = imread('ImageDatabase/1.jpg'); % Bilden som ska reproduceras
[height, width, color] = size(im);
imgSize = 1500; 

if height < imgSize || width < imgSize || height > imgSize || width > imgSize
    f = warndlg('Your image does not have the desired height and width and will therefore be resized. This may affect the resemblance to the original image.','Warning');
end

inImg = imresize(im, [imgSize imgSize]); % 1500x1500 pixlar
inImgLab = rgb2lab(inImg); % Konverterar från rgb till lab

% Portrait 
portratt = imread('TestImages/portratt.jpg');
portratt = imresize(portratt, [1500 1500]); 
portrattLab = rgb2lab(portratt);

% Dark image
mork = imread('TestImages/mork.jpg'); 
mork = imresize(mork, [1500 1500]);
morkLab = rgb2lab(mork);

% Light image 
ljus = imread('TestImages/ljus.jpg');
ljus = imresize(ljus, [1500 1500]);
ljusLab = rgb2lab(ljus);

nBlocks = 3; % Anger antalet subblocks
tileAve = getAverages(lab,nBlocks);


%% Halverar databasen till 100 bilder
[hundra, hunAve] = generateData(h, tileAve, 100);

%% Halverar databasen till 50 bilder
[femtio, femAve] = generateData(h, tileAve, 50); 

%% Halverar databasen till 25 bilder
[tjugofem, tjugofemAve] = generateData(h, tileAve, 25); 

%% Resultat
mosaicImg = mosaic(ljus, ljusLab, femtio, femAve); % Skapar mosaicbilden 
% mosaicPortratt = mosaic(portratt, portrattLab, h, tileAve); % Skapar portrait mosaic
% mosaicMork = mosaic(mork, morkLab, h, tileAve); % Skapar mork mosaic 
% mosaicLjus = mosaic(ljus, ljusLab, h, tileAve); % Skapar ljus mosaic 


