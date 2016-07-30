close all;
clear all;
clc; 

%% Signal to noise ratio considerations
snr = 5; 

%% Camera Parameters
f_mm = 80; % mm
ppx = 0.015; % Pixel pitch x in mm
ppy = 0.015; % Pixel pitch y in mm
xp = 512;
yp = 512;
pixel_scale = 10/1024; % degree/pixel

%% Integration time
% Each subexposure considered to be 1 ms
% 100 such exposures will make a complete exposure of 100 ms
milli = 100;

%% Angular motion of the spinning camera
slew = 0:0.5:5; % degree/sec
inc = slew/pixel_scale/1000; %  pixels/ms  (shift of gaussian centre during each subexposure)

%% Generate function for streaked star image
% all units in terms of pixels
fwhm = 2;
sig = fwhm/(2*sqrt(2*log10(2)));
k = 1/(milli*sig*sqrt(2*pi));   % Scale the amplitude of gaussian for subexposure compensation by milli
den = 2*sig^2;
x = 1:1024;
y = 1:1024;
[X,Y] = meshgrid(x,y);

table = zeros(length(slew),2);

for slew_var = 1:length(slew)
    
    img = double(zeros(1024,1024));
    noise_img = double(zeros(1024,1024));

    for l=1:milli
        xc = 300+(l-1)*inc(1,slew_var);
        yc = 200+(l-1)*inc(1,slew_var);
        for i=1:1024
            for j=1:1024
                img(i,j) = img(i,j) + ( k*exp(-( (i-xc)^2 + (j-yc)^2 ) / den) );
            end
        end
    end

    for l=1:milli
        xc = 400+(l-1)*inc(1,slew_var);
        yc = 600+(l-1)*inc(1,slew_var);
        for i=1:1024
            for j=1:1024
                img(i,j) = img(i,j) + ( k*exp(-( (i-xc)^2 + (j-yc)^2 ) / den) );
            end
        end
    end

    img = img/max(max(img));
    % Noisy image
    noise_img = imnoise(img,'gaussian', 1/snr, 0.01);


    %% Get centroid for clean image
    [seg, reg_count, cent] = detection(img,0.5);
    figure, imshow(img); hold on;
    plot(cent(:,1),cent(:,2),'rx');
    str = sprintf('Slew = %f (Clean)',slew(slew_var));
    title(str);

    %% Display noisy image
    figure, imshow(noise_img); hold on;
    [noise_seg, noise_reg_count, noise_cent] = detection(noise_img,0.8);
    plot(noise_cent(:,1),noise_cent(:,2),'rx');
    str = sprintf('Slew = %f (Noise)',slew(slew_var));
    title(str);

    %% Generate angle table between all centroids
    tab = gen_table(cent,xp,yp,ppx,ppy,f_mm);
    table(slew_var,1) = tab(1,3);
    tab = gen_table(noise_cent,xp,yp,ppx,ppy,f_mm);
    table(slew_var,2) = tab(1,3);
end
