%%
% Author: Lili X. Cai, Last update: 2/26/2020

% The scoring for this is from mice in medial VTA cohort: 
%   m747, m755, m756, 7m58, m761, m8203, m8204
% For each mouse, humans scored 15 'tones' trials, each trial had 315
% scored frames

% This script depends on the following functions: 
% dscatter_lxc()
% tp_tn_fp_fn

% Load data matrices
addpath('Data')
load cnn_sbs.mat           % CNN scoring second-by-second 
load freezeframe_sbs.mat   % FreezeFrame scoring second-by-second
load human1_sbs.mat        % Human 1 scoring second-by-second
load human2_sbs.mat        % Human 2 scoring second-by-second
load human1.mat            % Human 1 scoring raw (frame-by-frame)
load human2.mat            % Human 2 scoring raw (frame-by-frame)

%% Figure 1E
% Example Trial from one mouse
% Plot 1 example
figure(1), clf, set(gcf, 'color','white'), hold on
subplot(1,2,1), hold on
markersize=3;
x = 0.5:27.5;
bb=5; cs=1; % mouse number 5, CS (tone) # 1
    plot(x, squeeze(human_sbs(bb,cs,:)),'ko-','color','k', 'markerfacecolor','k', 'markersize', markersize) 
    plot(x-.1, squeeze(cnn_sbs(bb,cs,:)),'go-','color','g','markerfacecolor','g', 'markersize', markersize)
    plot(x-.2,squeeze(freezeframe_sbs(bb,cs,:)),'ro-','color','r','markerfacecolor','r', 'markersize', markersize)

ylim([0 100]), set(gca, 'ytick',[0 50 100])
plot([0 20], [11 11], 'b-', 'linewidth', 2)
ylim([0 100])
xlabel('Time (s)')
ylabel('% Freezing per sec')
title('Figure 1E: Left')

% Average over trials and mice
subplot(1,2,2), hold on
errorbar(x,squeeze(nanmean(nanmean(human_sbs,1),2)), squeeze(std(nanmean(human_sbs,2)))./sqrt(size(human_sbs,2)), 'ko-', 'capsize', 0)
errorbar(x-.1,squeeze(nanmean(nanmean(cnn_sbs,1),2)), squeeze(std(nanmean(cnn_sbs,2)))./sqrt(size(cnn_sbs,2)), 'go-', 'capsize', 0)
errorbar(x-.2,squeeze(nanmean(nanmean(freezeframe_sbs,1),2)), squeeze(std(nanmean(freezeframe_sbs,2)))./sqrt(size(freezeframe_sbs,2)), 'ro-', 'capsize', 0)
plot([0 20], [11 11], 'b-', 'linewidth', 2)
ylim([0 100])
legend('Human Scoring', 'CNN', 'FreezeFrame')
xlabel('Time from tone onset (s)')
ylabel('% Freezing to cue')
title('Figure 1E: Right')

%% Figure 1F, G & SuppFig 1F - Right

% display all correlations: 
[cor_cnn, pval_cnn] = corr(cnn_sbs(:), human_sbs(:))
[cor_ff, pval_ff] = corr(freezeframe_sbs(:), human_sbs(:))
[cor_ms, pval_ms] = corr(human2_sbs(:), human_sbs(:))

% CNN vs. human scorer
figure(2), clf, hold on, set(gcf, 'color','white')

    [~, F, Y, H, G, bin, edges1, edges2] = dscatter_lxc(human_sbs(:), cnn_sbs(:), 'PLOTTYPE','surf', 'bins', [12, 12]); colormap(hot); clf;  % don't plot this figure
    % Note on dscatter_lxc(), a modified version of dscatter(): 
    % - The plot that dscatter() outputs is a surf plot. It is unclear
    % what the colorbar axis is, because it's been smoothed data. Also, you
    % have to play around with the caxis ([0 .001]) because otherwise you don't
    % see the 'effect' as much, since most values are either 0 or 100.
    % - So, I modified it to outputs H (the raw histogram). This value is the % of total
    % number of values divided by total number of values. 
    % For example, cnn_sbs(:) = 2940 values total. a bin with colorbar value of .1 = 10% of
    % 2940 bins were in that particular bin. 
    % - Also added an ouput 'edges'. This is the values used to create bins. 
    % - The 'bins' input I used was [12, 12] because since our video is ~11.23 fps, we
    % will have 0, 1, 2 ...11 frames per second that could be 'freeze' or 'not
    % freeze'.  (try 11, or 13, and you will see strange edge effects for the
    % bins)
    % - Plot log(H) because most seconds are either fully frozen, or fully
    % moving. So the values in the middle are more rare and not visualized as well. log(H) brings that out 

    imagesc(flip(log(H))), h = colorbar; colormap(hot)
    set(gca,'xtick',1:12, 'xticklabel',{'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'})
    set(gca, 'ytick', 1:12, 'yticklabel', flip({'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'}))
    caxis([-8 0])
    c_vals = [-8 -7 -6 -5 -4 -3 -2 -1 0]; c_vals_exp = round(exp(c_vals),3);
    set(h, 'ytick', [c_vals], 'yticklabel',c_vals_exp)

    ylabel(h, 'Histogram Distribution Proportion (log scale)')
    ylabel('CNN (% Frz per Second)')
    xlabel('Human Observer (% Frz per Second)')
    title('CNN vs. Human Observer')
    
% CNN vs. human scorer
figure(2), clf, hold on, set(gcf, 'color','white')

    [~, F, Y, H, G, bin, edges1, edges2] = dscatter_lxc(human_sbs(:), cnn_sbs(:), 'PLOTTYPE','surf', 'bins', [12, 12]); colormap(hot); clf;  % don't plot this figure
    % Note on dscatter_lxc(), a modified version of dscatter(): 
    % - The plot that dscatter() outputs is a surf plot. It is unclear
    % what the colorbar axis is, because it's been smoothed data. Also, you
    % have to play around with the caxis ([0 .001]) because otherwise you don't
    % see the 'effect' as much, since most values are either 0 or 100.
    % - So, I modified it to outputs H (the raw histogram). This value is the % of total
    % number of values divided by total number of values. 
    % For example, cnn_sbs(:) = 2940 values total. a bin with colorbar value of .1 = 10% of
    % 2940 bins were in that particular bin. 
    % - Also added an ouput 'edges'. This is the values used to create bins. 
    % - The 'bins' input I used was [12, 12] because since our video is ~11.23 fps, we
    % will have 0, 1, 2 ...11 frames per second that could be 'freeze' or 'not
    % freeze'.  (try 11, or 13, and you will see strange edge effects for the
    % bins)
    % - Plot log(H) because most seconds are either fully frozen, or fully
    % moving. So the values in the middle are more rare and not visualized as well. log(H) brings that out 

    imagesc(flip(log(H))), h = colorbar; colormap(hot)
    set(gca,'xtick',1:12, 'xticklabel',{'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'})
    set(gca, 'ytick', 1:12, 'yticklabel', flip({'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'}))
    caxis([-8 0])
    c_vals = [-8 -7 -6 -5 -4 -3 -2 -1 0]; c_vals_exp = round(exp(c_vals),3);
    set(h, 'ytick', [c_vals], 'yticklabel',c_vals_exp)

    ylabel(h, 'Histogram Distribution Proportion (log scale)')
    ylabel('CNN (% Frz per Second)')
    xlabel('Human Observer (% Frz per Second)')
    title('CNN vs. Human Observer')
    
% Freeze Frame vs. human scorer
figure(3), clf, hold on, set(gcf, 'color','white')

    [~, F, Y, H, G, bin, edges1, edges2] = dscatter_lxc(human_sbs(:), freezeframe_sbs(:), 'PLOTTYPE','surf', 'bins', [12, 12]); colormap(hot); clf;  % don't plot this figure
    % Note on dscatter_lxc(), a modified version of dscatter(): 
    % - The plot that dscatter() outputs is a surf plot. It is unclear
    % what the colorbar axis is, because it's been smoothed data. Also, you
    % have to play around with the caxis ([0 .001]) because otherwise you don't
    % see the 'effect' as much, since most values are either 0 or 100.
    % - So, I modified it to outputs H (the raw histogram). This value is the % of total
    % number of values divided by total number of values. 
    % For example, cnn_sbs(:) = 2940 values total. a bin with colorbar value of .1 = 10% of
    % 2940 bins were in that particular bin. 
    % - Also added an ouput 'edges'. This is the values used to create bins. 
    % - The 'bins' input I used was [12, 12] because since our video is ~11.23 fps, we
    % will have 0, 1, 2 ...11 frames per second that could be 'freeze' or 'not
    % freeze'.  (try 11, or 13, and you will see strange edge effects for the
    % bins)
    % - Plot log(H) because most seconds are either fully frozen, or fully
    % moving. So the values in the middle are more rare and not visualized as well. log(H) brings that out 

    imagesc(flip(log(H))), h = colorbar; colormap(hot)
    set(gca,'xtick',1:12, 'xticklabel',{'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'})
    set(gca, 'ytick', 1:12, 'yticklabel', flip({'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'}))
    caxis([-8 0])
    c_vals = [-8 -7 -6 -5 -4 -3 -2 -1 0]; c_vals_exp = round(exp(c_vals),3);
    set(h, 'ytick', [c_vals], 'yticklabel',c_vals_exp)

    ylabel(h, 'Histogram Distribution Proportion (log scale)')
    ylabel('Freeze Frame (% Frz per Second)')
    xlabel('Human Observer (% Frz per Second)')
    title('Freeze Frame vs. Human Observer')    
    
% human scorer 2 vs. human scorer
figure(4), clf, hold on, set(gcf, 'color','white')

    [~, F, Y, H, G, bin, edges1, edges2] = dscatter_lxc(human_sbs(:), human2_sbs(:), 'PLOTTYPE','surf', 'bins', [12, 12]); colormap(hot); clf;  % don't plot this figure
    % Note on dscatter_lxc(), a modified version of dscatter(): 
    % - The plot that dscatter() outputs is a surf plot. It is unclear
    % what the colorbar axis is, because it's been smoothed data. Also, you
    % have to play around with the caxis ([0 .001]) because otherwise you don't
    % see the 'effect' as much, since most values are either 0 or 100.
    % - So, I modified it to outputs H (the raw histogram). This value is the % of total
    % number of values divided by total number of values. 
    % For example, cnn_sbs(:) = 2940 values total. a bin with colorbar value of .1 = 10% of
    % 2940 bins were in that particular bin. 
    % - Also added an ouput 'edges'. This is the values used to create bins. 
    % - The 'bins' input I used was [12, 12] because since our video is ~11.23 fps, we
    % will have 0, 1, 2 ...11 frames per second that could be 'freeze' or 'not
    % freeze'.  (try 11, or 13, and you will see strange edge effects for the
    % bins)
    % - Plot log(H) because most seconds are either fully frozen, or fully
    % moving. So the values in the middle are more rare and not visualized as well. log(H) brings that out 

    imagesc(flip(log(H))), h = colorbar; colormap(hot)
    set(gca,'xtick',1:12, 'xticklabel',{'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'})
    set(gca, 'ytick', 1:12, 'yticklabel', flip({'0', '8', '16', '25', '33', '41', '50', '58', '66', '75', '83', '91-100'}))
    caxis([-8 0])
    c_vals = [-8 -7 -6 -5 -4 -3 -2 -1 0]; c_vals_exp = round(exp(c_vals),3);
    set(h, 'ytick', [c_vals], 'yticklabel',c_vals_exp)

    ylabel(h, 'Histogram Distribution Proportion (log scale)')
    ylabel('Hand Scorer 2 (% Frz per Second)')
    xlabel('Hand Scorer 1 (% Frz per Second)')
    title('Human Observer 2 vs. Human Observer 1')     
    
%% Supplementary Figure 1F - left

[tp, tn, fp, fn, fpr, fnr, tp_num, tn_num, fp_num, fn_num ] = tp_tn_fp_fn(human1(:), human2(:));

acc = (length(tp_num) + length(tn_num)) / length(human1(:));

b(1) = acc;
b(2) = tp;
b(3) = tn;
b(4) = fp;
b(5) = fn;
b(6) = fpr;
b(7) = fnr;

figure(5), set(gcf, 'color','white'), clf, hold on
bar(b, 'facecolor', 'k')
set(gca,'xtick', [1 2 3 4 5 6 7])
set(gca, 'xticklabel', {'Acc','TP','TN','FP','FN','FPR','FNR'})
title('Human Observer vs. Human Observer (frame-by-frame)')

for bb=1:7
    text(bb,b(bb)+.1,[num2str(b(bb)*100,'%.2f') '%'])
end


