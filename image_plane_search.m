function [thresh_img] = image_plane_search(img,thresh,inc)
[r c] = size(img);
thresh_img = zeros(size(img));

for i=1:inc:r
    for j=1:inc:c
        if (img(i,j)>thresh)
            thresh_img(i,j) = 1;
        end
    end
end
end