function [star_catalog] = read_catalog(limiting_mag)
% @ param
% limiting mag - cut off magnitude for selecting star coverage of the sky
% fov - field of view in degrees
% min_separation - min. separation between stars to be detected

% catalog file input
[filename, filepath] = uigetfile('*.txt','Load Catalog file.. ');
pwd = strcat(filepath,filename);
%pwd = 'Data/asu_hipparcos_catalog_ra_dec_deg.tsv';
fid = fopen(pwd);
data = textscan(fid,'%d %f %f %f');
fclose(fid);
% data = tdfread(pwd);
len = length(data{1});

% filter the catalog to select only stars brighter than limiting magnitude
count = 0;
for i=1:len
   if (data{2}(i,1)<limiting_mag)
       count = count + 1;
       ra_new(count,1) = data{3}(i,1);
       ra_hours(count,:) = degrees2dms(ra_new(count,1)/15);
       dec_new(count,1) = data{4}(i,1);
       % get unit vectors of stars from the ra, dec values known
       u_cat(count,1) = cosd(data{4}(i,1))*cosd(data{3}(i,1));
       u_cat(count,2) = cosd(data{4}(i,1))*sind(data{3}(i,1)); % sind(data{4}(i,1));
       u_cat(count,3) = sind(data{4}(i,1)); % cosd(data{4}(i,1))*sind(data{3}(i,1)) 
   end
end

star_catalog = [(1:count)', ra_new, dec_new, u_cat];
s1 = sprintf('Limiting Magnitude = %0.2f', limiting_mag); disp(s1);
s2 = sprintf('Number of stars = %d', count); disp(s2);

end
