%% This plots trial-by-trial and across animal correlations

% Author: Lili X. Cai, last update: 3/2/2020

addpath('../Data')
addpath('helper_functions')
addpath('scripts')
addpath('..\data')
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

load tones.mat

% define colors for plotting:
[rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b] = colors();


%% Figure 4
% correlations across trials
% y axis: correlation per mouse. x axis: cue ON or cue OFF

% mVTA
num_cs = 21; 
mvta_tbt = frz_eval(mvta_sbs,0,19,tones, num_cs);  

% cue ON 5 s: time start: 500 to 1000 s + display significance values
[corr_r, h, p] = gcampcorr_acrosstrials(500, 1000, mvta_gctones, mvta_tbt, mvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[corr_r_off, h_off, p_off] = gcampcorr_acrosstrials(2500, 3000, mvta_gctones, mvta_tbt, mvta_mID)

% plot
gcamp_plotcorr_trials(mvta_mID, corr_r, corr_r_off, rose, darkrose, 30), title({'Medial VTA Trial-by-Trial', 'Freeze(t) vs. GCaMP(t)'})

% latVTA
num_cs = 21; 
lvta_tbt = frz_eval(lvta_sbs,0,19,tones, num_cs);  

% cue ON 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r, lvta_h, lvta_p] = gcampcorr_acrosstrials(500, 1000, lvta_gctones, lvta_tbt, lvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r_off, lvta_h_off, lvta_p_off] = gcampcorr_acrosstrials(2500, 3000, lvta_gctones, lvta_tbt, lvta_mID)

% plot
gcamp_plotcorr_trials(lvta_mID, lvta_corr_r, lvta_corr_r_off, blue, darkblue, 32), title({'Lateral VTA Trial-by-Trial', 'Freeze(t) vs. GCaMP(t)'})

%% Across mice correlations

% mVTA
% cue ON corr and plot + display correlation + p-value
ts = 500; te = 1000;
[mvta_gcamp_mean_cueon, mvta_frz_mean_cueon, aa_r_cueon, aa_p_cueon] = gcamp_plotcorr_aa(ts, te, mvta_mID, mvta_gctones, mvta_tbt, darkrose, 32, ...
    'Med VTA Across Mice', 'Mean GCaMP 5 s after Tone On')

% cue OFF corr and plot + display correlation + p-value
ts = 2500; te = 3000;
[mvta_gcamp_mean_cueoff, mvta_frz_mean_cueoff, aa_r_cueoff, aa_p_cueoff] = gcamp_plotcorr_aa(ts, te, mvta_mID, mvta_gctones, mvta_tbt, darkrose, 33, ...
    'Med VTA Across Mice', 'Mean GCaMP 5 s after Tone Off')

% lVTA
% cue ON corr and plot + display correlation + p-value
ts = 500; te = 1000;
[lvta_gcamp_mean_cueon, lvta_frz_mean_cueon, lvta_aa_r_cueon, lvta_aa_p_cueon] = gcamp_plotcorr_aa(ts, te, lvta_mID, lvta_gctones, lvta_tbt, darkblue, 34, ...
    'Lat VTA Across Mice', 'Mean GCaMP 5 s after Tone On')
% cue OFF corr and plot + display correlation + p-value
ts = 2500; te = 3000; 
[lvta_gcamp_mean_cueoff, lvta_frz_mean_cueoff, lvta_aa_r_cueoff, lvta_aa_p_cueoff] = gcamp_plotcorr_aa(ts, te, lvta_mID, lvta_gctones, lvta_tbt, darkblue, 35, ...
    'Lat VTA Across Mice', 'Mean GCaMP 5 s after Tone Off')

%% Figure 4 - X
% correlations across trials for DELTA_Freeze
% y axis: correlation per mouse. x axis: cue ON or cue OFF

% mVTA - calculate difference in freezing: freeze(t+1) - freeze(t)
mvta_tbt_next = circshift(mvta_tbt, -1, 2);
mvta_tbt_diff = mvta_tbt_next - mvta_tbt; mvta_tbt_diff(:,[21 42 63 84]) = NaN; % last trials of experiment day should = NaN, and not carry over from next day

% latVTA - calculate difference in freezing: freeze(t+1) - freeze(t)
lvta_tbt_next = circshift(lvta_tbt, -1, 2);
lvta_tbt_diff = lvta_tbt_next - lvta_tbt; lvta_tbt_diff(:,[21 42 63 84]) = NaN; % last trials of experiment day should = NaN, and not carry over from next day


% Check calculation: 
%figure(1)
%subplot(3,1,1)
%imagesc(mvta_tbt), title('frz(t)'), xlabel('Trial'), ylabel('Mouse #'), colorbar
%subplot(3,1,2)
%imagesc(mvta_tbt_next), title('frz(t+1)'), xlabel('Trial'), ylabel('Mouse #'), colorbar
%subplot(3,1,3)
%imagesc(mvta_tbt_diff), title('\Delta frz'), xlabel('Trial'), ylabel('Mouse #'), colorbar

% Plot correlation for each mouse: GCaMP on trial vs. delta_freeze

% cue ON 5 s: time start: 500 to 1000 s + display significance values
[corr_r_diff, h_diff, p_diff] = gcampcorr_acrosstrials(500, 1000, mvta_gctones, mvta_tbt_diff, mvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[corr_r_off_diff, h_off_diff, p_off_diff] = gcampcorr_acrosstrials(2500, 3000, mvta_gctones, mvta_tbt_diff, mvta_mID)

% plot
gcamp_plotcorr_trials(mvta_mID, corr_r_diff, corr_r_off_diff, rose, darkrose, 31), title({'Medial VTA Trial-by-Trial', '\Delta Freeze and GCaMP(t)'})

% latVTA
num_cs = 21; 
lvta_tbt = frz_eval(lvta_sbs,0,19,tones, num_cs);  

% cue ON 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r_diff, lvta_h_diff, lvta_p_diff] = gcampcorr_acrosstrials(500, 1000, lvta_gctones, lvta_tbt_diff, lvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r_off_diff, lvta_h_off_diff, lvta_p_off_diff] = gcampcorr_acrosstrials(2500, 3000, lvta_gctones, lvta_tbt_diff, lvta_mID)

% plot
gcamp_plotcorr_trials(lvta_mID, lvta_corr_r_diff, lvta_corr_r_off_diff, blue, darkblue, 33), title({'Lateral VTA Trial-by-Trial', '\Delta Freeze and GCaMP(t)'})


% corr btwn diff_frz and frz(t)
[corr_r_mvta_frzvsdiff, h_mvta_frzvsdiff, p_mvta_frzvsdiff] = gcampcorr_frzvsdifffrz(mvta_tbt_diff, mvta_tbt, mvta_mID)

% corr btwn frz_next and frz(t)
[corr_r_mvta_frzvsnext, h_mvta_frzvsnext, p_mvta_frzvsnext] = gcampcorr_frzvsdifffrz(mvta_tbt_next, mvta_tbt, mvta_mID)


%% correlation with frz(t+1) (NEXT) ===================================
% cue ON 5 s: time start: 500 to 1000 s + display significance values
[corr_r_next, h_next, p_next] = gcampcorr_acrosstrials(500, 1000, mvta_gctones, mvta_tbt_next, mvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[corr_r_off_next, h_off_next, p_off_next] = gcampcorr_acrosstrials(2500, 3000, mvta_gctones, mvta_tbt_next, mvta_mID)

% plot
gcamp_plotcorr_trials(mvta_mID, corr_r_next, corr_r_off_next, rose, darkrose, 31), title({'Medial VTA Trial-by-Trial', 'Freeze(t+1) and GCaMP(t)'})

% latVTA
num_cs = 21; 
lvta_tbt = frz_eval(lvta_sbs,0,19,tones, num_cs);  

% cue ON 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r_next, lvta_h_next, lvta_p_next] = gcampcorr_acrosstrials(500, 1000, lvta_gctones, lvta_tbt_next, lvta_mID)

% cue OFF 5 s: time start: 500 to 1000 s + display significance values
[lvta_corr_r_off_next, lvta_h_off_next, lvta_p_off_next] = gcampcorr_acrosstrials(2500, 3000, lvta_gctones, lvta_tbt_next, lvta_mID)

% plot
gcamp_plotcorr_trials(lvta_mID, lvta_corr_r_next, lvta_corr_r_off_next, blue, darkblue, 33), title({'Lateral VTA Trial-by-Trial', 'Freeze(t+1) and GCaMP(t)'})


% corr btwn diff_frz and frz(t)
[corr_r_lvta_frzvsdiff, h_lvta_frzvsdiff, p_lvta_frzvsdiff] = gcampcorr_frzvsdifffrz(lvta_tbt_diff, lvta_tbt, lvta_mID)

% corr btwn frz_next and frz(t)
[corr_r_lvta_frzvsnext, h_lvta_frzvsnext, p_lvta_frzvsnext] = gcampcorr_frzvsdifffrz(lvta_tbt_next, lvta_tbt, lvta_mID)






