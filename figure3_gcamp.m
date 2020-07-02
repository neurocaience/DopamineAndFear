%% This does Linear Mixed Effects analysis on gcamp and freezing 

% Author: Lili X. Cai, last update: 3/2/2020

addpath('../Data')
addpath('helper_functions')
load tones.mat 

% Load data matrices
load mvta_sbs
load mvta_gc
load mvta_gctones
load mvta_mID

load lvta_sbs
load lvta_gc
load lvta_gctones
load lvta_mID

load lvtayfp_sbs
load lvtayfp_gc
load lvtayfp_gctones
load lvtayfp_mID

load mvtayfp_sbs
load mvtayfp_gc
load mvtayfp_gctones
load mvtayfp_mID

% load shuffled data: 
load mvta_gctones_shuffle_mean
load mvta_gctones_shuffle_std
load lvta_gctones_shuffle_mean
load lvta_gctones_shuffle_std
load mvtayfp_gctones_shuffle_mean
load mvtayfp_gctones_shuffle_std
load lvtayfp_gctones_shuffle_mean
load lvtayfp_gctones_shuffle_std


% define colors for plotting:
[rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b] = colors();

%% Figure 3 + Supplementary figure 1F, G, H

% Freezing for both medial & lateral VTA
mvta_sbs_bytrial = bytrial_sbs(mvta_sbs,tones);
lvta_sbs_bytrial = bytrial_sbs(lvta_sbs,tones);
plotFrz([mvta_sbs_bytrial; lvta_sbs_bytrial], 50)

num_cs = 21; 
mlvta_tbt = frz_eval([mvta_sbs; lvta_sbs],0,19,tones, num_cs);  
plotFrzFig2(mlvta_tbt, 56)

% Medial VTA
plotgcampforfigure(mvta_sbs, mvta_gctones, mvta_gc, ...
    mean_shuffle, std_shuffle, 1000, rose, r2b);

% Lateral VTA
plotgcampforfigure(lvta_sbs, lvta_gctones, lvta_gc, ...
    lvta_mean_shuffle, lvta_std_shuffle, 1000, blue, b2b);

%% Supplementary figure 1D, E
% Example mouse from medial and lateral VTA, throughout the whole trial +
% ITI: 
mvta_mousenum = 5; 
lvta_mousenum = 4;
mvta_trialsITI= bytrial_iti_gcamp(mvta_gc, tones); mvta_trialsITI(isnan(mvta_trialsITI)==1)=0;
lvta_trialsITI= bytrial_iti_gcamp(lvta_gc, tones); lvta_trialsITI(isnan(lvta_trialsITI)==1)=0;

figure(1), clf, imagesc(squeeze(mvta_sbs_bytrial(mvta_mousenum,:,:))), colormap(gray)
figure(2), clf, plotGcamp(squeeze(mvta_trialsITI(mvta_mousenum,:,:)), 2, r2b)
figure(3), clf, imagesc(squeeze(lvta_sbs_bytrial(lvta_mousenum,:,:))), colormap(gray)
figure(4), clf, plotGcamp(squeeze(lvta_trialsITI(lvta_mousenum,:,:)), 4, b2b)


%% Supplementary Figure 3

% Freezing for all YFP
mvtayfp_sbs_bytrial = bytrial_sbs(mvtayfp_sbs,tones);
lvtayfp_sbs_bytrial = bytrial_sbs(lvtayfp_sbs,tones);
plotFrz([mvtayfp_sbs_bytrial; lvtayfp_sbs_bytrial], 60)

% Medial VTA YFP
plotgcampforfigure(mvtayfp_sbs, mvtayfp_gctones, mvtayfp_gc, ...
    mvtayfp_mean_shuffle, mvtayfp_std_shuffle, 1000, rose, r2b);

% Lateral VTA YFP
plotgcampforfigure(lvtayfp_sbs, lvtayfp_gctones, lvtayfp_gc, ...
    lvtayfp_mean_shuffle, lvtayfp_std_shuffle, 1000, blue, b2b);

%% Supplementary figure 1B
plot_firstShock(mvta_gc, mvta_mID, 1, rose)
plot_firstShock(lvta_gc, lvta_mID, 2, blue)

%% Supplementary figure 1C
% Will take 3 min to run:
plotShockOnly(mvta_mID, 2, rose)
plotShockOnly(lvta_mID, 3, blue)

