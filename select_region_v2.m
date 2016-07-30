function [seg, real_id] = select_region_v2(star_cat, fov, ra, dec)

ux_cent = cosd(dec)*cosd(ra);
uy_cent = sind(dec); % cosd(dec)*sind(ra)
uz_cent = cosd(dec)*sind(ra); % sind(dec);
R = [cosd(ra)*cosd(dec), -cosd(ra)*sind(dec), sind(ra); sind(dec), cosd(dec), 0; -sind(ra)*cosd(dec), sind(ra)*sind(dec), cosd(ra)]; % Rotation matrix for the field
count = 0;
for i=1:length(star_cat)
    d = acosd( ux_cent*star_cat(i,4) + uy_cent*star_cat(i,5) + uz_cent*star_cat(i,6));
    if (d<fov/2)
        count = count + 1;
        seg(count,1) = count;
        seg(count,2:3) = star_cat(i,2:3);
        seg(count,4:6) = (R*star_cat(i,4:6)')'; % unit vectors in the rotated coordinate system
%         ra_star_seg = star_cat(i,2) - ra;
%         dec_star_seg = star_cat(i,3) - dec;
%         seg(count,4) = cosd(dec_star_seg)*cosd(ra_star_seg);
%         seg(count,5) = sind(dec_star_seg); % cosd(dec_star_seg)*sind(ra_star_seg)
%         seg(count,6) = cosd(dec_star_seg)*sind(ra_star_seg); % sind(dec_star_seg);
        real_id(count,1) = i;
    end
end

if(count==0)
    seg = zeros(1,6);
    real_id = 0;

end
