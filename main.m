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


%%
RepImage = imread('ImageDatabase/1.jpg');
RepImage = im2double(RepImage);
RepImage = imresize(RepImage, [150 150], 'bicubic');
RepImageLab = rgb2lab(RepImage);

newImage = zeros(3750,3750,3); % 150x25 = 3750

for a = 1:250
    data{a} = rgb2lab(h{a});
end


mean_value = zeros(1,250);
%% Detta funkar inte �n
% Vill j�mf�ra en pixel i originalbilden med varje bild i datasettet. 
% Ber�kna det euklidiska avst�ndet och ta det som har minst medelv�rde 

for i = 1:250
     [max_value,mean_value(i)] = compute_euclidian(RepImageLab(1:1:250,1:1:250,:),data{i});
end
 

