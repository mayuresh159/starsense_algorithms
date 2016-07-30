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
slew = 5; % degree/sec
inc = slew/pixel_scale/1000; %  pixels/ms  (shift of gaussian centre during each subexposure)

%% Generate function for streaked star image
% all units in terms of pixels
fwhm = 4;
sig = fwhm/(2*sqrt(2*log10(2)));
k = 1/(milli*sig*sqrt(2*pi));   % Scale the amplitude of gaussian for subexposure compensation by milli
den = 2*sig^2;
x = 1:1024;
y = 1:1024;
[X,Y] = meshgrid(x,y);

img = double(zeros(1024,1024));
noise_img = double(zeros(1024,1024));

for l=1:milli
    xc = 512+(l-1)*inc;
    yc = 512+(l-1)*inc;
    for i=1:1024
        for j=1:1024
            img(i,j) = img(i,j) + ( k*exp(-( (i-xc)^2 + (j-yc)^2 ) / den) );
        end
    end
    %noise_img = noise_img + imnoise(img,'gaussian', 1/snr, 0.01);
end

img = img/max(max(img));
%noise_img = noise_img/max(max(noise_img));
% Noisy image
noise_img = imnoise(img,'gaussian', 1/snr, 0.01);


%% Get centroid for clean image
[seg, reg_count, cent] = detection(img,0.5);
figure, imshow(img); hold on;
plot(cent(1,1),cent(1,2),'rx');

%% Display noisy image
figure, imshow(noise_img); hold on;
[noise_seg, noise_reg_count, noise_cent] = detection(noise_img,0.8);
plot(noise_cent(1,1),noise_cent(1,2),'rx');

%% Generate unit vector of the centroid
x_centroid = cent(1,1);
y_centroid = cent(1,2);

u_z = ( 1 + ((x_centroid - xp)*ppx/f_mm)^2 + ((y_centroid - yp)*ppy/f_mm)^2 )^-0.5;
u_x = (x_centroid - xp)*ppx/f_mm*u_z;
u_y = (y_centroid - yp)*ppy/f_mm*u_z;

noise_x_centroid = noise_cent(1,1);
noise_y_centroid = noise_cent(1,2);

noise_u_z = ( 1 + ((noise_x_centroid - xp)*ppx/f_mm)^2 + ((noise_y_centroid - yp)*ppy/f_mm)^2 )^-0.5;
noise_u_x = (noise_x_centroid - xp)*ppx/f_mm*u_z;
noise_u_y = (noise_y_centroid - yp)*ppy/f_mm*u_z;