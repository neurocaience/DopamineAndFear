function [] = plotFrzFig2(mlvta_tbt, fignum)

figure(fignum), clf, set(gcf, 'color', 'w'), hold on
plot([10.5 10.5], [0 100], '--', 'color', [.7 .7 .7])
plot([21 21], [0 100], '--', 'color', [.7 .7 .7])
plot([42.5 42.5], [0 100], '--', 'color', [.7 .7 .7])
plot([63.5 63.5], [0 100], '--', 'color', [.7 .7 .7])
errorbar(nanmean(mlvta_tbt), nanstd(mlvta_tbt, [], 1)./sqrt(size(mlvta_tbt,1)), 'k.-', 'capsize', 0)
xlabel('Trial (Tone) Num')
ylabel('%Freezing to Tone')
title('Mean Freezing to Tone Across All Trials')


end