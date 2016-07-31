%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Copyright (c) 2005, Aroh Barjatya
% % All rights reserved.
% % 
% % Redistribution and use in source and binary forms, with or without
% % modification, are permitted provided that the following conditions are
% % met:
% % 
% %     * Redistributions of source code must retain the above copyright
% %       notice, this list of conditions and the following disclaimer.
% %     * Redistributions in binary form must reproduce the above copyright
% %       notice, this list of conditions and the following disclaimer in
% %       the documentation and/or other materials provided with the distribution
% % 
% % THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% % AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% % IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% % ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
% % LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% % CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% % SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% % INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% % CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% % ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% % POSSIBILITY OF SUCH DAMAGE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bsearch(x,var)
% Written by Aroh Barjatya
% Binary search for values specified in vector 'var' within data vector 'x'
% The data has to be pre-sorted in ascending or decending order
% There is no way to predict how the function will behave if there 
% are multiple numbers with same value.
% returns the index values of the searched numbers

function index = bsearch(x,var)

xLen = length(x);
[xRow xCol] = size(x);
if x(1) > x(xLen)	% means x is in descending order
    if xRow==1
        x = fliplr(x);  
    else
        x = flipud(x);
    end
    flipped = 1;
elseif x(1) < x(xLen)	% means x is in ascending order
    flipped = 0;
else
    'badly formatted data. Type ''help bsearch\'')';
    return;
end

for i = 1:length(var)
    low = 1;
    high = xLen;
    if var(i) <= x(low)
        index(i) = low;
        continue;
    elseif var(i) >= x(high)
        index(i) = high;
        continue;
    end
    flag = 0;
    while (low <= high)
        mid = round((low + high)/2);
        if (var(i) < x(mid))
            high = mid;
        elseif (var(i) > x(mid))
            low = mid;
        else
            index(i) = mid;
            flag = 1;
            break;
        end
        if (low == high - 1)
            break
        end
    end
    if (flag == 1)
        continue;
    end
    if (low == high)
        index(i) = low;
    elseif ((x(low) - var(i))^2 > (x(high) - var(i))^2)
        index(i) = high;
    else
        index(i) = low;
    end
end

if flipped
    index = xLen - index + 1;
end
