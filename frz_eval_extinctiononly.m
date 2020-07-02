%% frz_eval_extinctiononly() s-by-s freeze data

function [frz2] = frz_eval_extinctiononly(frz,a,b,tones, n_cs)

frz2 = nan(size(frz,1),3,n_cs);  % 3 extinction days

for m = 1:size(frz,1)
    for extd = 1:3
        expd = extd + 1;
        for cs=1:n_cs
            cs_start = tones(cs,expd)+a;
            cs_end = min(tones(cs,expd)+b,size(frz,3));
            frz2(m,extd,cs) = nanmean(frz(m,expd,cs_start:cs_end),3);
        end
    end
end

end