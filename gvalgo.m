function [id, v2] = gvalgo(cat,tab_cat,tab_image,loc_err)
% identify stars in the image tabulated in form of angles between them and
% compare them with a tabulated star catalog of angles between different
% stars in the complete sky


[n_image, ~]  = size(tab_image);
n_stars_img = max(tab_image(:,2));

% Voting
k_n = zeros(n_stars_img,1);

for i=1:n_image
    index_min = bsearch(tab_cat(:,3),tab_image(i,3)-loc_err);
    index_max = bsearch(tab_cat(:,3),tab_image(i,3)+loc_err);
    for j=index_min:index_max
        v(tab_image(i,1),2*k_n(tab_image(i,1),1)+1) =  tab_cat(j,1);      v(tab_image(i,1),2*k_n(tab_image(i,1),1)+2) =  tab_cat(j,2);           k_n(tab_image(i,1),1) = k_n(tab_image(i,1),1) + 1;
        v(tab_image(i,2),2*k_n(tab_image(i,2),1)+1) =  tab_cat(j,1);      v(tab_image(i,2),2*k_n(tab_image(i,2),1)+2) =  tab_cat(j,2);           k_n(tab_image(i,2),1) = k_n(tab_image(i,2),1) + 1;
    end
end

% Votes counting to id stars
id = zeros(n_stars_img,1);
for i=1:n_stars_img
    first_zero = find(v(i,:)==0,1,'first');
    id(i,1) = mode(v(i,1:first_zero));
    if (isnan(id(i,1))) 
        id(i,1) = 0; 
    end
end

% Second round of voting to check whether identities are proper
v2 = zeros(n_stars_img,1);
for i=1:n_image
    if (tab_image(i,1)~=0 && tab_image(i,2)~=0)
        a = id(tab_image(i,1),1);
        b = id(tab_image(i,2),1);
        if (a~=0 && b~=0)
            d_cat = acosd( cat(a,4)*cat(b,4) + cat(a,5)*cat(b,5) + cat(a,6)*cat(b,6) );
            d_image = tab_image(i,3);
            if (d_image-loc_err<d_cat && d_cat<d_image+loc_err)
                v2(tab_image(i,1),1) = v2(tab_image(i,1),1) + 1;
                v2(tab_image(i,2),1) = v2(tab_image(i,2),1) + 1;
            end
        end
    end
end

% for i=1:n_stars_img
%     if (v2(i,1)==0)
%        id(i,1) = 0;
%     end
% end


end

