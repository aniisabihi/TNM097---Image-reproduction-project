%% Detta tar tid!
% Gör en mat fil av alla bilder (minibilderna blir storlek 25x25 pixlar
% Detta behövs endast göras när vi vill ändra storlek på de små bilderna
for k=1:250
   image = imread(sprintf('ImageDatabase/%d.jpg',k));
   h{k} = imresize(image, [25 25], 'bicubic');
end
save ImageData h

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
%% Detta funkar inte än
% Vill jämföra en pixel i originalbilden med varje bild i datasettet. 
% Beräkna det euklidiska avståndet och ta det som har minst medelvärde 

for i = 1:250
     [max_value,mean_value(i)] = compute_euclidian(RepImageLab(1:1:250,1:1:250,:),data{i});
end
 

