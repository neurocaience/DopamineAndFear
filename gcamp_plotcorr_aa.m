function [gcamp_mean, frz_mean, h, p] = gcamp_plotcorr_aa(ts, te, mvta_mID, mvta_gctones, mvta_tbt, darkrose, fig_n, title1, title2)

gcamp_mean = nan(1, size(mvta_mID,1));
frz_mean   = nan(1, size(mvta_mID,1));

for m = 1:size(mvta_mID,1)
    gcamp_mean(m) = squeeze(nanmean(nanmean(mvta_gctones(m, 22:84, ts:te), 3)));
    frz_mean(m) = nanmean(mvta_tbt(m, 22:84));
end

[h, p] = corr(gcamp_mean', frz_mean');
glm = fitglm(gcamp_mean, frz_mean);
frz_estimate = glm.Coefficients.Estimate(1) + glm.Coefficients.Estimate(2)*gcamp_mean;

figure(fig_n), clf, hold on, set(gcf, 'color', 'white')
plot(gcamp_mean, frz_estimate, '--', 'color', [.6 .6 .6])
plot(gcamp_mean, frz_mean, 'o', 'color', darkrose, 'markerfacecolor', darkrose)
fitglm(gcamp_mean, frz_mean)
ylim([0 80])
title(title1)
xlabel(title2)
ylabel('Mean % Freezing')

end