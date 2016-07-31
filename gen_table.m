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
