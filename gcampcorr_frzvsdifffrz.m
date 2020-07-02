function [corr_r, h, p] = gcampcorr_frzvsdifffrz(mvta_tbt_diff, mvta_tbt, mvta_mID)

corr_r = nan(size(mvta_mID,1), 1);

for m = 1:size(mvta_mID)

    frz_temp = mvta_tbt(m, 22:84);
    frz_temp_diff = mvta_tbt_diff(m, 22:84);
    
    % get rid of any tone trials with NaN values 
    % (only latVTA 7th mouse has some NaN values in freezing
    ind = find(isnan(frz_temp_diff));
    frz_temp(ind) = [];
    frz_temp_diff(ind) = [];
    
    corr_r(m) = corr(frz_temp_diff', frz_temp');
end

[h, p] = ttest(corr_r); 

end