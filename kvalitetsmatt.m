%% Kvalitetsmått 
% Signal to Ratio 
portrattDouble = im2double(portratt);
morkDouble = im2double(mork);
ljusDouble = im2double(ljus);

mosaicPortrattDouble = im2double(mosaicPortratt);
mosaicMorkDouble = im2double(mosaicMork);
mosaicLjusDouble = im2double(mosaicLjus);

noise_p = portrattDouble - mosaicPortrattDouble;
noise_m = morkDouble - mosaicMorkDouble;
noise_l = ljusDouble - mosaicLjusDouble;

snrValue_p = snr(portrattDouble,noise_p);
snrValue_m = snr(morkDouble,noise_m);
snrValue_l = snr(ljusDouble,noise_l);

%% Euclidian Distance 
portrattLab = rgb2lab(portrattDouble);
morkLab = rgb2lab(morkDouble);
ljusLab = rgb2lab(ljusDouble);

[max_value_p,mean_value_p] = compute_euclidian(portrattLab,mosaicPortrattDouble);
[max_value_m,mean_value_m] = compute_euclidian(morkLab,mosaicMorkDouble);
[max_value_l,mean_value_l] = compute_euclidian(ljusLab,mosaicLjusDouble);

