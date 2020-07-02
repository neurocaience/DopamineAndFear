%% frz_eval() Takes a continuous freezing file (s-by-s)
% Outputs trial-by-trial for the section (a to b) you want
% Inputs: 
%   (1) data matrix
%   (2) a - start index relative to CS
%   (3) b - end index relative to CS
%   (4) tones matrix: CS on times
%   (5) num_cs 
% 
% Outputs: 
%   (1) frz_o: 
%   (2) frz_op: 
%   (3) frz_or: reshaped to dimensions: mouse, 84 trials
function [frz_or, frz_o, frz_op] = frz_eval(frz,a,b,tones, num_cs)

frz_o = nan(size(frz,1), size(frz,2), num_cs);   % during CS

for m=1:size(frz,1)
    for extd = 1:4 %4 %CHANGE ME
        for cs = 1:num_cs
            cs_st = tones(cs,extd)+a;      % time relative to CS where you want data
            cs_end = tones(cs,extd)+b;  % time relative to CS where you end data

            if isnan(cs_st) == 1   % skip if NaN 
            else
                if (m > size(frz,1))
                else
                    frz_o(m,extd,cs) = nanmean(frz(m,extd,cs_st:cs_end));
                end
            end
        end
    end
end

frz_op = permute(frz_o,[1 3 2]);  % permute the matrix 
frz_or = reshape(frz_op,[size(frz_o,1), size(frz_o,2)*num_cs]);  % reshape

end


