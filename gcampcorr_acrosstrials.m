function [corr_r, h, p] = gcampcorr_acrosstrials(ts, te, mvta_gctones, mvta_tbt, mvta_mID)

corr_r = nan(size(mvta_mID,1), 1);

for m = 1:size(mvta_mID)
    % mean gcamp per trial
    gcamp_temp = nanmean(mvta_gctones(m, 22:84, ts:te), 3);
    frz_temp = mvta_tbt(m, 22:84);
    
    % get rid of any tone trials with NaN values 
    % (only latVTA 7th mouse has some NaN values in freezing
    ind = find(isnan(frz_temp));
    frz_temp(ind) = [];
    gcamp_temp(ind) = [];
    
    corr_r(m) = corr(gcamp_temp', frz_temp');
    
    % plot (optional)
    %figure, clf, hold on
    %title(['mouse' num2str(m) ' ' num2str(corr_r(m))])
    %plot(gcamp_temp, frz_temp, 'o')
    
end

[h, p] = ttest(corr_r); 

end
