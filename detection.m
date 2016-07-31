% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Copyright 2016 Mayuresh Sarpotdar
% % 
% %    Licensed under the Apache License, Version 2.0 (the "License");
% %    you may not use this file except in compliance with the License.
% %    You may obtain a copy of the License at
% % 
% %        http://www.apache.org/licenses/LICENSE-2.0
% % 
% %    Unless required by applicable law or agreed to in writing, software
% %    distributed under the License is distributed on an "AS IS" BASIS,
% %    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% %    See the License for the specific language governing permissions and
% %    limitations under the License.
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
