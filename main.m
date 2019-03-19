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
im = imread('ImageDatabase/36.jpg'); % Bilden som ska reproduceras
[height, width, color] = size(im);
imgSize = 1500; 

if height < imgSize || width < imgSize || height > imgSize || width > imgSize
    f = warndlg('Your image does not have the desired height and width and will therefore be resized. This may affect the resemblance to the original image.','Warning');
end

inImg = imresize(im, [imgSize imgSize]); % 1500x1500 pixlar
inImgLab = rgb2lab(inImg); % Konverterar från rgb till lab

% Portrait 
portratt = imread('ImageDatabase/10.jpg');
portratt = imresize(portratt, [imgSize imgSize]); 
portrattLab = rgb2lab(portratt);

% Dark image
mork = imread('ImageDatabase/154.jpg'); 
mork = imresize(mork, [imgSize imgSize]);
morkLab = rgb2lab(mork);

% Light image 
ljus = imread('ImageDatabase/224.jpg');
ljus = imresize(ljus, [imgSize imgSize]);
ljusLab = rgb2lab(ljus);

nBlocks = 1; % Anger antalet subblocks
tileAve = getAverages(lab,nBlocks);

%% Vanligt resultat
mosaicBild = mosaic(inImg, inImgLab, h, tileAve); % Skapar mosaic

%% Resultat för kvalitetsmått
%mosaicPortratt = mosaic(portratt, portrattLab, h, tileAve); % Skapar portrait mosaic
%mosaicMork = mosaic(mork, morkLab, h, tileAve); % Skapar mork mosaic 
mosaicLjus = mosaic(ljus, ljusLab, h, tileAve); % Skapar ljus mosaic 

%% Halverar databasen till 100 bilder
[hundra, hunAve] = generateData(h, tileAve, 100);

%% Halverar databasen till 50 bilder
[femtio, femAve] = generateData(h, tileAve, 50); 

%% Resultat från halvering av databas
mosaic250 = mosaic(inImg, inImgLab, h, tileAve); % Skapar mosaic
mosaic100 = mosaic(inImg, inImgLab, hundra, hunAve); % Skapar mosaic
mosaic50 = mosaic(inImg, inImgLab, femtio, femAve); % Skapar mosaic

%% Optimering
[mosaicImg, new1]= getOptimalImages(inImg, inImgLab, h, tileAve); % Skapar mosaicbilden 
[mosaicImg, new2]= getOptimalImages(ljus, ljusLab, h, tileAve); % Skapar mosaicbilden 
[mosaicImg, new3]= getOptimalImages(mork, morkLab, h, tileAve); % Skapar mosaicbilden 
[mosaicImg, new4]= getOptimalImages(portratt, portrattLab, h, tileAve); % Skapar mosaicbilden 

%%
newHam = unique(new1);
newMork = unique(new3);
newLjus = unique(new2);
newPortratt = unique(new4);

%%
C = intersect(newLjus ,newMork);

B = intersect(newHam  ,newPortratt);

A = intersect(C,B);

%% Skapar nya databaser
for i = 1:38
    newDatabase38(:,:,:,i) = h(:,:,:,A(:,i));
    newDatabase38Lab(:,:,:,i) = rgb2lab(newDatabase38(:,:,:,i));
end

save OptimizedData38 newDatabase38 newDatabase38Lab

%% Load nya databaser 
load OptimizedData38
load OptimizedData20
load OptimizedData143
load OptimizedData59

%% Resultat från olika databaser med olika storlekar
tileAve = getAverages(newDatabase20Lab,nBlocks);
mosaic20 = mosaic(ljus, ljusLab, newDatabase20, tileAve);

%%
tileAve = getAverages(newDatabase38Lab,nBlocks);
mosaic38 = mosaic(ljus, ljusLab, newDatabase38, tileAve);

%%
tileAve = getAverages(newDatabase60Lab,nBlocks);
mosaic60 = mosaic(ljus, ljusLab, newDatabase60, tileAve);

%%
tileAve = getAverages(newDatabase143Lab,nBlocks);
mosaic143 = mosaic(ljus, ljusLab, newDatabase143, tileAve);
