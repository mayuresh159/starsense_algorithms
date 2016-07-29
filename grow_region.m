function reg_img = grow_region(img,reg_img,row,col,thresh,region_count)
% 8 neighbour region growing to detect slant lines too 

[r c] = size(img);
neighb = [0,1; 1,0; 0,-1; -1,0; 1,1; 1,-1; -1,-1; -1,1];
reg_img(row,col) = region_count;
for i=1:8
    rown = row+neighb(i,1); coln = col+neighb(i,2);
    if (rown>0 && coln>0 && rown<r && coln<c)
        if(reg_img(rown,coln)==0 && img(rown,coln)>thresh)
            reg_img(rown,coln) = region_count;
            reg_img = grow_region(img,reg_img,rown,coln,thresh,region_count);
        end
    end
end
end