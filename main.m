%% Detta tar tid!
% G�r en mat fil av alla bilder (minibilderna blir storlek 25x25 pixlar
% Detta beh�vs endast g�ras n�r vi vill �ndra storlek p� de sm� bilderna
for k=1:250
   image = imread(sprintf('ImageDatabase/%d.jpg',k));
   h{k} = imresize(image, [25 25], 'bicubic');
end
save ImageData h

%% Databas alternativ 2 
dataBase = cell(250,1);

for i=1:250
  dataBase{i}=imread(['ImageDatabase/' int2str(i) '.jpg']);
  k{i} = imresize(dataBase{i}, [25 25], 'bicubic'); 
end

save dataBase k

%%
load ImageData.mat
load dataBase.mat

%%
RepImage = imread('ImageDatabase/1.jpg');
RepImage = im2double(RepImage);
RepImage = imresize(RepImage, [100 100], 'bicubic');
RepImageLab = rgb2lab(RepImage);

newImage = zeros(2500,2500,3); % 150x25 = 3750

for a = 1:250
    data{a} = rgb2lab(h{a});
end


indexOfmin = zeros(100,100);
%% Detta funkar inte �n
% Vill j�mf�ra en pixel i originalbilden med varje bild i datasettet. 
% Ber�kna det euklidiska avst�ndet och ta det som har minst medelv�rde 


%% Skickar in en pixel tilsammans med hela datasettet
% Tar ocks� tid, hur g�r man utan loopar?

for m = 1:100
    for n = 1:100
        [indexOfmin(m,n)] = IndexOfNearest(RepImageLab(m,n,:),data);
    end
end

 %% Ta reda p� hur man g�r utan loopar!!

for j = 1:25:3750
     for k = 1:25:3750
         for t = 1:150
             for s = 1:150
                newImage(j:j+24,k:k+24,:) = h{indexOfmin(t,s)};
             end
         end
     end
end

%% Kommentarer och idéer 

% https://se.mathworks.com/matlabcentral/fileexchange/30039-mosaic-generator

% use 'corr2' function in matlab, it will take very less time for comparing images.

% https://stackoverflow.com/questions/29442214/comparing-multiple-images-in-matlab
% Assuming the sizes of all those images to be the same, here's one efficient approach -

%// Get dimensions of each image
%[nrows,ncols] = size(imageArray{1}) 

%// Convert the cell array to a 3D numeric array for vectorized operations
%im = reshape(cell2mat(imageArray),nrows,ncols,[])

%// Use MATLAB builtins min and max along the third dimension for final output
%minImg = min(im,[],3)
%maxImg = max(im,[],3)

%%
imshow(newImage)
% Warning: Image is too big to fit on screen; displaying at 50% 
 

