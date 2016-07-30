function [table] = gen_table(cat,fov,min_separation)

[n, ~] = size(cat);
count = 0;

for i=1:n-1
    for j=i+1:n
        d = acosd( cat(i,4)*cat(j,4) + cat(i,5)*cat(j,5) + cat(i,6)*cat(j,6) ); 
        if (d<fov && d>min_separation)
            count = count + 1;
            table(count,1) = i;
            table(count,2) = j;
            table(count,3) = d;
        end
    end
end

end