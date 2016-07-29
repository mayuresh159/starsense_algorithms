function [x,y] = centroid(img,reg_img,region_count)
[row, col] = size(img);
num_row = 0;
num_col = 0;
den = 0;
for i=1:row
    for j=1:col
        if (reg_img(i,j) == region_count)
            num_row = num_row + i*img(i,j);
            num_col = num_col + j*img(i,j);
            den = den + img(i,j);
        end
    end
end

x = num_col/den;
y = num_row/den;

end