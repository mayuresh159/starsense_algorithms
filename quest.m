function [q] = quest(cat, seg, star_id)
% calculate rotation quaternion from set of unit vectors corresponding to
% identified stars in inertial reference frame and sensor body reference
% frame
l = length(cat);
[n ~] = size(star_id);

u_inertial = zeros(n,3);
u_sensor = seg(:,4:6);

% extract unit vectors of the identified stars
for i=1:n
    if (star_id(i)~=0)
        index = cat(:,1)==star_id(i);
        u_inertial(i,:) = cat(index,4:6);
    end
end

% generate B matrix
% weightage for all measurements to be given 1, wrongly identified stars
% weightage is 0
B = zeros(3,3);
l_opt = 0;
for i=1:n
    if (star_id(i)~=0)
        B = B + (u_sensor(i,:))'*u_inertial(i,:);
        l_opt = l_opt + 1;
    end   
end

S = B + B';

Z = [-B(2,3)+B(3,2) -B(3,1)+B(1,3) -B(1,2)+B(2,1)]';

sigma = trace(B);

a = (l_opt + sigma)*eye(3);
p = (a-S)\Z;    

b = 1/sqrt(1+p'*p);
q = b*[1; p];
end