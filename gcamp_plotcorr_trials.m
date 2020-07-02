function [] = gcamp_plotcorr_trials(mvta_mID, corr_r, corr_r_off, rose, darkrose, fig_n)

figure(fig_n), clf, hold on, set(gcf, 'color', 'white')
x = ones(size(mvta_mID, 1), 1);
plot([-.5 2], [0 0], '--', 'color', [.5 .5 .5])
plot(x, corr_r, 'o', 'color', rose, 'markerfacecolor', rose)
errorbar(1, nanmean(corr_r), nanstd(corr_r), 'o', 'color', darkrose, 'markerfacecolor', darkrose, 'capsize', 0)
plot(x+.5, corr_r_off, 'o', 'color', rose, 'markerfacecolor', rose)
errorbar(1.5, nanmean(corr_r_off), nanstd(corr_r_off), 'o', 'color', darkrose, 'markerfacecolor', darkrose, 'capsize', 0)
xlim([.5 2])
ylim([-.6 .6])
set(gca, 'xtick', [1 1.5], 'xticklabel', {'GCaMP Cue On', 'GCaMP Cue Off'})
ylabel({'Correlation Coefficient'})

end