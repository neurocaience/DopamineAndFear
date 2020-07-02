%% This plots trial-by-trial and across animal correlations

% Author: Lili X. Cai, last update: 4/19/2020

% Note: this script requires MATLAB 2019b or higher to run. xcorr requires
% the 'normalized' option which is only available in later versions of
% MATLAB. 

addpath('../Data')
addpath('scripts')
addpath('helper_functions')
load tones.mat 

% Load data matrices
load mvta_sbs
load mvta_fbf
load mvta_gc
load mvta_gctones
load mvta_mID

load lvta_sbs
load lvta_fbf
load lvta_gc
load lvta_gctones
load lvta_mID

load tones.mat

% define colors for plotting:
[rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b] = colors();

%% Created functions to run for each brain region: 
run_xcorr(mvta_gc, mvta_fbf, tones, 'mVTA', 0, 112, rose, darkdarkrose);   % 0 -> figure number, function plots 6 figures
run_xcorr(lvta_gc, lvta_fbf, tones, 'latVTA', 10, 112, blue, darkdarkblue);


%% Older code to test functions =======================

% downsample gcamp + line up to freezing first tone
mvta_gc_res = resample_gcamp(mvta_gc, tones, 1123,10000);
% cut off tail end of frz matrix to match gc_res (resampled gcamp)
mvta_fbf = size_matrix(mvta_gc_res, mvta_fbf);

% Make each experiment day for cross correlation
mvta_gc_res_byday = byday(mvta_gc_res, tones, 11.23);
mvta_fbf_byday = byday(mvta_fbf, tones, 11.23);

% Do cross correlation for each animal, each experiment day
lag = 336; %(112)
[r_habi, lags_habi] = xcorr_byday(squeeze(mvta_gc_res_byday(:,1,:)), squeeze(mvta_fbf_byday(:,1,:)), 336);
[r_cond, lags_cond] = xcorr_byday(squeeze(mvta_gc_res_byday(:,2,:)), squeeze(mvta_fbf_byday(:,2,:)),336 );
[r_ext, lags_ext] = xcorr_byday(squeeze(mvta_gc_res_byday(:,3:5,:)), squeeze(mvta_fbf_byday(:,3:5,:)), 336);
[r_ext1, lags_ext1] = xcorr_byday(squeeze(mvta_gc_res_byday(:,3,:)), squeeze(mvta_fbf_byday(:,3,:)), 336);
[r_ext2, lags_ext2] = xcorr_byday(squeeze(mvta_gc_res_byday(:,4,:)), squeeze(mvta_fbf_byday(:,4,:)), 336);
[r_ext3, lags_ext3] = xcorr_byday(squeeze(mvta_gc_res_byday(:,5,:)), squeeze(mvta_fbf_byday(:,5,:)), 336);

r_ext = reshape(r_ext, [size(r_ext,1)*size(r_ext,2), size(r_ext,3)]);  % reshape so there's only 2 dimensions for extinction

% plot figures
plot_xcorr(r_habi, 1, [.5 .5 .5], [0 0 1], 'mVTA Habi. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])
plot_xcorr(r_cond, 2, [.5 .5 .5], [1 0 0], 'mVTA Fear Cond. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])
plot_xcorr(r_ext, 3, [.5 .5 .5], [0 0 1], 'mVTA Ext. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])
plot_xcorr(r_ext1, 4, [.5 .5 .5], [0 0 1], 'mVTA Ext1. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])
plot_xcorr(r_ext2, 5, [.5 .5 .5], [0 0 1], 'mVTA Ext2. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])
plot_xcorr(r_ext3, 6, [.5 .5 .5], [0 0 1], 'mVTA Ext3. (sampled at 11.23 Hz)', 11.23), ylim([-.25 .25])


%%
function [] = shadedError(nac_mean, nac_sem, eb_color, alpha_val, lag)
dy = nac_sem; dy = dy';
y = nac_mean; y = y';
%x = 1:length(nac_mean); x = x';
x = -lag:lag; x = x';
h = fill([x;flipud(x)],[y-dy;flipud(y+dy)],eb_color,'linestyle','none'); h.FaceAlpha = alpha_val;
end

function [r_habi, r_cond, r_ext] = run_xcorr(mvta_gc, mvta_fbf, tones, roi, fign, lag, rose, darkrose)
    if nargin < 5
        lag = 336; 
        rose = [.7 .7 .7];
        darkrose = 'k';
    end
    
    % downsample gcamp + line up to freezing first tone
    mvta_gc_res = resample_gcamp(mvta_gc, tones, 1123,10000);
    % cut off tail end of frz matrix to match gc_res (resampled gcamp)
    mvta_fbf = size_matrix(mvta_gc_res, mvta_fbf);

    %% Make each experiment day for cross correlation
    mvta_gc_res_byday = byday(mvta_gc_res, tones, 11.23);
    mvta_fbf_byday = byday(mvta_fbf, tones, 11.23);

    %% Do cross correlation for each animal, each experiment day
    disp('habituation'); [r_habi, lags_habi] = xcorr_byday(squeeze(mvta_gc_res_byday(:,1,:)), squeeze(mvta_fbf_byday(:,1,:)), lag);
    disp('fear conditioning'); [r_cond, lags_cond] = xcorr_byday(squeeze(mvta_gc_res_byday(:,2,:)), squeeze(mvta_fbf_byday(:,2,:)), lag);
    disp('extinction - all'); [r_ext, lags_ext] = xcorr_byday(squeeze(mvta_gc_res_byday(:,3:5,:)), squeeze(mvta_fbf_byday(:,3:5,:)), lag);
    disp('extinction - day 1'); [r_ext1, lags_ext1] = xcorr_byday(squeeze(mvta_gc_res_byday(:,3,:)), squeeze(mvta_fbf_byday(:,3,:)), lag);
    disp('extinction - day 2'); [r_ext2, lags_ext2] = xcorr_byday(squeeze(mvta_gc_res_byday(:,4,:)), squeeze(mvta_fbf_byday(:,4,:)), lag);
    disp('extinction - day 3'); [r_ext3, lags_ext3] = xcorr_byday(squeeze(mvta_gc_res_byday(:,5,:)), squeeze(mvta_fbf_byday(:,5,:)), lag);
    
    r_ext = reshape(r_ext, [size(r_ext,1)*size(r_ext,2), size(r_ext,3)]);  % reshape so there's only 2 dimensions for extinction
    %%
    % plot figures
    plot_xcorr(r_habi, fign + 1, rose, darkrose, [roi ' Habi. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])
    plot_xcorr(r_cond, fign + 2, rose, darkrose, [roi ' Fear Cond. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])
    plot_xcorr(r_ext, fign + 3, rose, darkrose, [roi ' Ext. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])
    
    plot_xcorr(r_ext1, fign + 4, rose, darkrose, [roi ' Ext1. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])
    plot_xcorr(r_ext2, fign + 5, rose, darkrose, [roi ' Ext2. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])
    plot_xcorr(r_ext3, fign + 6, rose, darkrose, [roi ' Ext3. (sampled at 11.23 Hz)'], 11.23), ylim([-.25 .25])

end

function [] = plot_xcorr(r_habi, fign, color_eb, color_line, title_info, Fs)
    dims = size(r_habi);
    lag = (dims(2)-1)/2; 
    x = -lag:lag;         
    figure(fign), clf, set(gcf, 'color', 'white'), hold on
    % only for this specific plot
    % plot([0 0], [-.25 .25], '--', 'color', [.9 .9 .9])
    % plot([11.23 11.23], [-.25 .25], '--', 'color', [.9 .9 .9])
    % plot([22.46 22.46], [-.25 .25], '--', 'color', [.9 .9 .9])
    % plot([-11.23 -11.23], [-.25 .25], '--', 'color', [.9 .9 .9])
    % plot([-22.46 -22.46], [-.25 .25], '--', 'color', [.9 .9 .9]) 
    % only for this specific plot
    
    %errorbar(x, nanmean(r_habi), nanstd(r_habi)./sqrt(dims(1)), 'capsize', 1, 'color', color_eb)
    shadedError(nanmean(r_habi), nanstd(r_habi)./sqrt(dims(1)), color_eb, .5, lag)
    
    for m = 1:dims(1)
        %plot(x, r_habi(m,:), 'color', [.7 m/dims(1) m/dims(1)])
        plot(x, r_habi(m,:), 'color', [.8 .8 .8])
    end
    plot(x, nanmean(r_habi), 'color', color_line, 'linewidth', 1)
    xlabel('Lag (s)')
    ylabel({'Cross-Correlation btwn'; 'GCaMP and Frz'})
    title(title_info)
    xlim([-lag lag])    
    
    % xlabel only for this 11.23 Hz with 112     
    x_tick = linspace(-lag, lag, 5);
    x_ticklabel = linspace(round(-lag/Fs), round(lag/Fs), 5);
    set(gca, 'xtick', x_tick)
    set(gca, 'xticklabel', x_ticklabel)
end


function [r, lags] = xcorr_byday(mvta_gc_res_byday ,mvta_fbf_byday, lag)
    if nargin < 3
        lag = 10; 
    end

    dims = size(mvta_fbf_byday);
    
    if size(dims,2) == 2    
        r = nan(size(mvta_fbf_byday,1), lag*2+1);
        lags = nan(size(mvta_fbf_byday,1), lag*2+1);
        for m = 1:size(mvta_fbf_byday,1)
            if sum(~isnan(mvta_gc_res_byday(m,:))) == 0 || sum(~isnan(mvta_fbf_byday(m,:))) == 0
                disp(['xcorr: skipped m' num2str(m) ', no data for gc or frz'])
            else
                [r(m,:), lags(m,:)] = nanxcorr(squeeze(mvta_gc_res_byday(m,:)),squeeze(mvta_fbf_byday(m,:)), lag);
            end
        end
    elseif size(dims,2) == 3
        r = nan(size(mvta_fbf_byday,1), dims(2), lag*2+1);
        lags = nan(size(mvta_fbf_byday,1), dims(2), lag*2+1);
        for m = 1:size(mvta_fbf_byday,1)
            for d = 1:dims(2)
                [r(m,d,:), lags(m,d,:)] = nanxcorr(squeeze(mvta_gc_res_byday(m,d,:)),squeeze(mvta_fbf_byday(m,d,:)), lag);
            end
        end        
    else
        disp('Dimensions of input matrix not 2 or 3')   
    end    
end


function gc_byday = byday(gc_res, tones, Fs)
    % Fs = sampling rate in Hz (ie. 11.23 Hz)
    dim3 = size(gc_res,3);
    tone11 = tones(11,1);  % tone 11 of conditioning day
    ind_tone11 = floor(Fs*tone11);
    
    gc_byday = nan(size(gc_res,1), 5, dim3);    
    gc_byday(:,1,1:(ind_tone11-1)) = gc_res(:,1,1:(ind_tone11-1));
    gc_byday(:,2,ind_tone11:end) = gc_res(:,1,ind_tone11:end);
    gc_byday(:,3:5,:) = gc_res(:,2:4,:);
end


function mvta_fbf2 = size_matrix(gc_res, mvta_fbf)
    % makes the size of mvta_fbf same as gc_res
    dim3 = size(gc_res,3);
    mvta_fbf2 = mvta_fbf(:,:,1:dim3);
end

function gc_res = resample_gcamp(mvta_gc, tones, Fs_numerator, Fs_denominator)
    % find when first gcamp ttl occurs, subtract tone(1,day)*Fs amount
    gc_temp = nan(size(mvta_gc,1),4,225700);
    gc_res = nan(size(mvta_gc,1),4,ceil(225700*Fs_numerator/Fs_denominator));
    Fs_gc = 100;
    for m = 1:size(mvta_gc,1)
        for d = 1:size(mvta_gc,2)
            ind = find(mvta_gc(m,d,2,:)==1);
            ts = (ind(1) - tones(1,d)*Fs_gc +1);
            if ts <= 0            % if gcamp recording started after freezing recording
                gc_temp(m,d,-ts+2:end) = mvta_gc(m,d,3,1:(ind(1) + (2257-tones(1,d))*Fs_gc)); 
            else
                gc_temp(m,d,:) = mvta_gc(m,d,3,(ind(1) - tones(1,d)*Fs_gc +1):(ind(1) + (2257-tones(1,d))*Fs_gc));        
            end
            % resample at X hz 
            gc_res(m,d,:) = resample(squeeze(gc_temp(m,d,:)), Fs_numerator, Fs_denominator);
        end
    end
end


function [h, p] = nancorr(X, Y)

ind = find(isnan(X));
X(ind) = [];
Y(ind) = []; 
ind = find(isnan(Y));
X(ind) = [];
Y(ind) = []; 

[h, p] = corr(X, Y);

end

function [h, p] = nanxcorr(X, Y, lag)

if nargin < 3
    lag = 10;
end

ind = find(isnan(X));
X(ind) = [];
Y(ind) = []; 
ind = find(isnan(Y));
X(ind) = [];
Y(ind) = []; 

[h, p] = xcorr(X, Y, lag, 'normalized');

end
