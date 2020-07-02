addpath('scripts')
addpath('..\data')
addpath('helper_functions')
addpath('../Data')

load snc_sbs
load snc_gctones
load snc_gc
load snc_mID
load snc_gctones_shuffle_mean
load snc_gctones_shuffle_std

load 'tones.mat'

%%
[rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b, p2b, ...
    g2b, lg2b, lavendar, lightgreen, limegreen] = colors();

%% Figure 1 - supplement 3: SNc
% Use only the first 2 mice, 3rd mouse did not have histology
plotgcampforfigure(snc_sbs(1:2,:,:), snc_gctones(1:2,:,:), snc_gc(1:2,:,:,:), ...
    snc_mean_shuffle, snc_std_shuffle, 1000, lightgreen, g2b, [-1 3]);
snc_sbs_bytrial = bytrial_sbs(snc_sbs(1:2,:,:),tones);
plotFrz(snc_sbs_bytrial, 50)

plotfrzforfigure(snc_sbs(1:2,:,:), 20, tones)






