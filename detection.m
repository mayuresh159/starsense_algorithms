function [ reg_img, region_count, cent ] = detection( img, thresh )

% variables for thresholding process
[row col] = size(img);

% variables for region identification process
region_count = 0;
reg_img = zeros(size(img));

for i=1:1:row        % staggared image plane search for threshold 
    for j=1:1:col    % staggared image plane search for threshold
        if (reg_img(i,j)==0 && img(i,j)>thresh)
            region_count = region_count + 1;    
            reg_img = grow_region(img,reg_img,i,j,thresh,region_count);
        end
    end
end

cent = zeros(region_count,2);
for i=1:region_count
    [cent(i,1), cent(i,2)] = centroid(img,reg_img,i);
end


end
