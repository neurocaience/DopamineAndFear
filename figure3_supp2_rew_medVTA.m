%% latVTA

%% add paths
addpath('scripts')
addpath('..\data_reward')
[rose, darkrose, darkdarkrose, ...
    grey, darkgrey, ...
    blue, darkblue, darkdarkblue, ...
    r2b, b2b, p2b, g2b, lg2b, lavendar, lightgreen, limegreen] = colors();
% reward files
fn3 = 'm730_freemilknocue.csv';

% shock files
fn_sh3 = 'gcamp_m730_04.csv';

% GCAMP channels
% Channel 1-2: timestamps
% Channel 3: GCaMP  (Fs = 25 hz)
% Channel 4: nothing
% Channel 5: reward delivery TTL  (baseline = 3.7 V, 0 = rew delivery)
% Channel 6: lick meter

Fs_gcamp = 25;    % Sampling rate for GCaMP
Fs_gcamp_sh = 100;

gc3 = xlsread(fn3); 

gc_sh3 = xlsread(fn_sh3); 

% extract dF/F, rew_ttl, lick1_ttl, shock_ttl
[gc_dff3, rew_ttl3, lick_ttl3, lick_ttl3_all] = extract_gc_rew_lick_ttl(gc3);

[gc_dff3_sh, sh_ttl3] = extract_gc_sh_ttl(gc_sh3);

%%
% z-score: 
[gc_z_rew3, gc_z_sh3] = zscore(gc_dff3, gc_dff3_sh);

%% align with reward
gc_lick3 = align_gcampttl(gc_z_rew3, lick_ttl3, 5*Fs_gcamp, 5*Fs_gcamp);

gc_lick_comb = [gc_lick3];

%% align with shock 
gc_sh3 = align_gcampttl(gc_z_sh3, sh_ttl3, 5*Fs_gcamp_sh, 5*Fs_gcamp_sh); gc_sh3 = gc_sh3(1:5,:);

gc_sh_comb = [gc_sh3];

%% shuffled data 
n_shuffles = 1000;
gc_rew_shuffle_aligned = nan(n_shuffles,size(gc_lick_comb,1), size(gc_lick_comb,2));
gc_sh_shuffle_aligned = nan(n_shuffles,size(gc_sh_comb,1), size(gc_sh_comb,2));
for j = 1:n_shuffles
    disp(j)
    [gc_rew_shuffle_aligned(j,:,:), gc_sh_shuffle_aligned(j,:,:)]= shuffle_multiplemice( gc_dff3, gc_dff3_sh, ...
    lick_ttl3, sh_ttl3, ...
    Fs_gcamp, Fs_gcamp_sh);
end

% significant reward timebins

gc_shuffle_aligned_mean = squeeze(nanmean(gc_rew_shuffle_aligned,2));  % Take the mean of each 'shuffled' data
gc_lick_mean = nanmean(gc_lick_comb);

% determining percentile
X = round(size(gc_shuffle_aligned_mean,2)/Fs_gcamp);  % number of seconds to compare for making percentile
array_mean_val = size(gc_shuffle_aligned_mean,2)/X;
len_mean = round(size(gc_shuffle_aligned_mean,2)/Fs_gcamp);  % size of new data array

%X = 20;  % number of seconds to compare for making percentile
%array_mean_val = 13;
%len_mean = 19;

percentile_ = .01/X;
p_high_value = 100 - percentile_;
p_low_value = 0 + percentile_;

temp = [];
for k = 1:n_shuffles
    temp(k,:) = array_mean(gc_shuffle_aligned_mean(k,:),array_mean_val);
end

for len = 1:len_mean
    perct_low(len) = prctile(temp(:,len), p_low_value);
    perct_high(len) = prctile(temp(:,len), p_high_value);
end

gc_lick_mean_ = array_mean(gc_lick_mean, array_mean_val);

% find significant bins:
significant = nan(size(gc_lick_mean_));
for j = 1:length(gc_lick_mean_)
    if gc_lick_mean_(j) < perct_low(j) || gc_lick_mean_(j) > perct_high(j)
        significant(j) = 1;
    end
end

significant

% significance shock time bins

gc_shuffle_aligned_mean = squeeze(nanmean(gc_sh_shuffle_aligned,2));  % Take the mean of each 'shuffled' data
gc_lick_mean = nanmean(gc_sh_comb);

% determining percentile
X = round(size(gc_shuffle_aligned_mean,2)/Fs_gcamp_sh);  % number of seconds to compare for making percentile
array_mean_val = size(gc_shuffle_aligned_mean,2)/X;
len_mean = round(size(gc_shuffle_aligned_mean,2)/Fs_gcamp_sh);  % size of new data array

%X = 20;  % number of seconds to compare for making percentile
%array_mean_val = 13;
%len_mean = 19;

percentile_ = .01/X;
p_high_value = 100 - percentile_;
p_low_value = 0 + percentile_;

temp = [];
for k = 1:n_shuffles
    temp(k,:) = array_mean(gc_shuffle_aligned_mean(k,:),array_mean_val);
end

for len = 1:len_mean
    perct_low(len) = prctile(temp(:,len), p_low_value);
    perct_high(len) = prctile(temp(:,len), p_high_value);
end

gc_lick_mean_ = array_mean(gc_lick_mean, array_mean_val);

% find significant bins:
significant = nan(size(gc_lick_mean_));
for j = 1:length(gc_lick_mean_)
    if gc_lick_mean_(j) < perct_low(j) || gc_lick_mean_(j) > perct_high(j)
        significant(j) = 1;
    end
end

significant


%% plot mean signals
% reward
rose = [255/255 200/255 200/255];
blue = [198/255 226/255 238/255];
darkdarkblue = [100/255 100/255 238/255];
figure(1), clf, set(gcf, 'color','white'), hold on
shadedError(nanmean(gc_lick_comb)', nanstd(gc_lick_comb)'./sqrt(size(gc_lick_comb,1)), rose, 0.7)
plot(nanmean(gc_lick_comb), 'color', 'r')
plot([125 125], [-2 6], '--', 'color', [.7 .7 .7])
set(gca, 'xtick', 0:Fs_gcamp:250, 'xticklabel', -5:5)
ylim([-1 6])
xlim([0 250])

% shock

figure(2), clf, set(gcf, 'color','white'), hold on
shadedError(nanmean(gc_sh_comb)', nanstd(gc_sh_comb)'./sqrt(size(gc_sh_comb,1)), rose, 0.7)
plot(nanmean(gc_sh_comb), 'color', 'r')
plot([500 500], [-2 6], '--', 'color', [.7 .7 .7])
set(gca, 'xtick', 0:Fs_gcamp_sh:1000, 'xticklabel', -5:5)
ylim([-1 6])
xlim([0 1000])

%%

% reward
figure(1), clf, set(gcf, 'color','white'), hold on
%shadedError(squeeze(nanmean(nanmean(gc_lick_comb2))), squeeze(nanstd(nanmean(gc_lick_comb2,2)))./sqrt(3),blue,0.7)
plot(nanmean(gc_lick3), 'color', darkdarkrose)
%shadedError(nanmean(gc_lick_comb)', nanstd(gc_lick_comb)'./sqrt(size(gc_lick_comb,1)), blue, 0.7)
%plot(nanmean(gc_lick_comb), 'color', darkdarkblue)
plot([125 125], [-2 6], '--', 'color', [.7 .7 .7])
set(gca, 'xtick', 0:Fs_gcamp:250, 'xticklabel', -5:5)
ylim([-1 6])
xlim([0 250])

% example reward
figure(3), clf, set(gcf, 'color', 'white')
imagesc(gc_lick3), colormap(r2b), colorbar, caxis([-5 5]), hold on
%plot([125 125], [1 8], '--', 'color', 'g')
set(gca, 'xtick', 0:Fs_gcamp:250, 'xticklabel', -5:5)

% shock
rose = [255/255 200/255 200/255];
figure(2), clf, set(gcf, 'color','white'), hold on
%gc_sh_comb2 = gc_sh_comb2(1:2,:,:);
%shadedError(squeeze(nanmean(nanmean(gc_sh_comb2))), squeeze(nanstd(nanmean(gc_sh_comb2,2)))./sqrt(3),blue,0.7)
plot((nanmean(gc_sh3)), 'color', darkdarkrose)
plot([500 500], [-2 6], '--', 'color', [.7 .7 .7])
set(gca, 'xtick', 0:Fs_gcamp_sh:1000, 'xticklabel', -5:5)
ylim([-1 6])
xlim([0 1000])

% example shock
figure(4), clf, set(gcf, 'color', 'white')
imagesc(gc_sh3), colormap(r2b), colorbar, caxis([-5 5]), hold on
%plot([125 125], [1 8], '--', 'color', 'g')
set(gca, 'xtick', 0:Fs_gcamp_sh:1000, 'xticklabel', -5:5)

































%%
function [gc_lick_comb, gc_sh_comb] = shuffle_multiplemice(gc_dff3, gc_dff3_sh, ...
    lick_ttl3, sh_ttl3, ...
    Fs_gcamp, Fs_gcamp_sh)

    % shuffle data
    gc_dff3 = shuffle(gc_dff3, 1);
    gc_dff3_sh = shuffle(gc_dff3_sh, 1);
    
    % z-score: 
    [gc_z_rew3, gc_z_sh3] = zscore(gc_dff3, gc_dff3_sh);

    %% align with reward
    gc_lick3 = align_gcampttl(gc_z_rew3, lick_ttl3, 5*Fs_gcamp, 5*Fs_gcamp);

    gc_lick_comb = gc_lick3;
    
    %% align with shock 
    gc_sh3 = align_gcampttl(gc_z_sh3, sh_ttl3, 5*Fs_gcamp_sh, 5*Fs_gcamp_sh); gc_sh3 = gc_sh3(1:5,:);

    gc_sh_comb = gc_sh3;    


end



function [] = shadedError(nac_mean, nac_sem, eb_color, alpha_val)
dy = nac_sem; 
y = nac_mean;
x = 1:length(nac_mean); x = x';
h = fill([x;flipud(x)],[y-dy;flipud(y+dy)],eb_color,'linestyle','none'); h.FaceAlpha = alpha_val;
end

function [gc_z_rew, gc_z_sh] = zscore(gc_dff1, gc_dff1_sh)
    gc = [gc_dff1 gc_dff1_sh];
    mean_gc = nanmean(gc);
    std_gc = nanstd(gc);
    
    gc_z_rew = (gc_dff1 - mean_gc) ./ std_gc;
    gc_z_sh = (gc_dff1_sh - mean_gc) ./ std_gc;
end

function rew_ttl2 = extract_shock_ttl(rew_ttl, val_below, thresh_val, ttl_val)

    % rew_ttl:        raw ttl signal
    % val_below:      1 = TTL pulse is BELOW threshhold value
    %                 0 = TTL pulse is ABOVE threshold value
    % thresh_val:     threshold value
    % ttl_val:        value that you want to assign new TTL output

    if nargin < 2
        val_below = 1;   % else val_below = 0
        thresh_val = 2; 
        ttl_val = 1;
    end

    if nargin < 3
        thresh_val = 2;
        ttl_val = 1;
    end

    rew_ttl2 = zeros(size(rew_ttl));

    if val_below == 1   % If TTL is extracted based on value below

        for j = 2:length(rew_ttl)
            if rew_ttl(j) >= thresh_val && rew_ttl(j-1) < thresh_val
                rew_ttl2(j) = ttl_val; 
            end        
        end        
    end

    if val_below == 0
        % nothing written here yet, placeholder
    end

end

function [gc_dff, sh_ttl2] = extract_gc_sh_ttl(gc)
    gc_trace = gc(:,4);
    [gc_dff, y1_polyval] = gc_dF_F(gc_trace);
    
    % Extract TTL pulse - shock delivery
    sh_ttl = gc(:,3);
    sh_ttl2 = extract_shock_ttl(sh_ttl, 1, 2, 1);

end


function [gc_dff, rew_ttl2, lickone_ttl, lick_ttl] = extract_gc_rew_lick_ttl(gc)

% Filter GCaMP activity
gc_trace = gc(:,3);
[gc_dff, y1_polyval] = gc_dF_F(gc_trace);

% check gcamp activity: 
% figure(2), clf, hold on
% yyaxis left
% plot(x,gc_trace)
% yyaxis right
% plot(x+0.01,gc_dff)
% legend('raw data', 'dF/F')

% Extract TTL pulse - reward delivery
rew_ttl = gc(:,5);
rew_ttl2 = extract_ttl(rew_ttl, 1, 2, 1);

% figure(3), clf, hold on
% yyaxis left
% plot(rew_ttl2)
% yyaxis right
% plot(rew_ttl)

% Extract TTL pulse - lick consumption
lick_ttl = gc(:,6);
[lick_ttl2] = extract_ttl_lick(lick_ttl, 1, 2, 1, 250, 0); % 5 s lick bout
[lickone_ttl] = extract_firstlick(lick_ttl2, rew_ttl2);
%
% figure(4), clf, hold on
% plot(lick_ttl)
% plot(lickone_ttl, 'g')

end


%%
function [lickone_ttl] = extract_firstlick(lick_ttl2, rew_ttl2)

    lickone_ttl = zeros(size(lick_ttl2));

    for r = 1:length(rew_ttl2)-1
        if rew_ttl2(r) >= .5 && rew_ttl2(r+1) < .5
            %r
            for r2 = r:length(rew_ttl2)-1
                if lick_ttl2(r2) >= .5 && lick_ttl2(r2+1) < .5
                    %r2
                    lickone_ttl(r2) = 1;
                    break;
                end
            end        
        end
    end

end




%%
function [gc_traces_shuffle] = shuffle(gc_trace, num_shuffle)
% given an array, circshift it by a random number

gc_traces_shuffle = nan(num_shuffle, length(gc_trace));

for j=1:size(gc_traces_shuffle,1)
    random_num = 1 + (length(gc_trace)-1)*randn;
    gc_trace_shuffle = gc_trace;
    gc_trace_shuffle = circshift(gc_trace, round(random_num));  
    gc_traces_shuffle(j,:) = gc_trace_shuffle; 
    %disp(['done shuffle ' num2str(j)])
end

end



function [gc_aligned] = align_gcampttl(gc_trace, rew_ttl, samples_pre, samples_post)

% Align GCaMP by TTL pulse
% gc_trace:       gcamp trace (1D vector)
% rew_ttl:        ttl trace (1D vector) --> assumes '1' is TTL pulse, else
% 0
% samples_pre:    number of values pre (scalar)
% samples_post:   numbers of values post (scalar)
num_values = samples_pre + samples_post ;
ind = find(rew_ttl == 1);
num_ind = sum(rew_ttl);     % assumes each TTL pulse is value = 1, else 0
gc_aligned = nan(num_ind, num_values);

for j = 1:num_ind
    gc_aligned(j,:) = gc_trace( (ind(j) - samples_pre +1) : (ind(j) + samples_post) );
    
    %plot(gc_trace( (ind - samples_pre) : (ind + samples_post) )); pause(.1)
end

end


function [lick_ttl3, lick_ttl2] = extract_ttl_lick(lick_ttl, val_below, thresh_val, ttl_val, ttl_bout, ttl_dur)
% lick_ttl:      raw lick signal
% val_below:     1 = TTL pulse is BELOW threshhold value
%                0 = TTL pulse is ABOVE threshold value
% thresh_val:    threshold value
% ttl_val:       value that you want to assign new TTL output
% ttl_bout:      number of values in between ttls to be considered part of the
%                same ttl pulse (lick bout) 

if nargin < 2
    val_below = 1;   % else val_below = 0
    thresh_val = 2; 
    ttl_val = 1;
    ttl_bout = 125;  % 25 hz * 5 s = 125 samples per bout. Consider a 5 s lick bout
    ttl_dur = 250; % minimum duration of lick bout
end

if nargin < 3
    thresh_val = 2;
    ttl_val = 1;
    ttl_bout = 125; 
    ttl_dur = 250; % minimum duration of lick bout
end

lick_ttl2 = zeros(size(lick_ttl));  % binary version of lick_ttl
lick_ttl3 = zeros(size(lick_ttl));  % bout consideration of ttl

if val_below == 1   % If TTL is extracted based on value below
    
    for j = 2:length(lick_ttl)
        if lick_ttl(j) < thresh_val 
            lick_ttl2(j) = ttl_val; 
        end        
    end    
    
    for j = ttl_bout+1:length(lick_ttl)-ttl_dur
        %if sum(lick_ttl2(j-ttl_bout:j-1)) == 0 && sum(lick_ttl2(j:j+ttl_dur)) >= 5 && lick_ttl2(j) == 1 
        if sum(lick_ttl2(j-ttl_bout:j-1)) == 0 && lick_ttl2(j) == 1 
            lick_ttl3(j) = ttl_val;
        end
    end
end

end


function rew_ttl2 = extract_ttl(rew_ttl, val_below, thresh_val, ttl_val)

% rew_ttl:        raw ttl signal
% val_below:      1 = TTL pulse is BELOW threshhold value
%                 0 = TTL pulse is ABOVE threshold value
% thresh_val:     threshold value
% ttl_val:        value that you want to assign new TTL output

if nargin < 2
    val_below = 1;   % else val_below = 0
    thresh_val = 2; 
    ttl_val = 1;
end

if nargin < 3
    thresh_val = 2;
    ttl_val = 1;
end

rew_ttl2 = zeros(size(rew_ttl));

if val_below == 1   % If TTL is extracted based on value below
    
    for j = 2:length(rew_ttl)
        if rew_ttl(j) <= thresh_val && rew_ttl(j-1) > thresh_val
            rew_ttl2(j) = ttl_val; 
        end        
    end        
end

if val_below == 0
    % nothing written here yet, placeholder
end

end



function [gc_dff, y1_polyval] = gc_dF_F(gc_trace)

% polyfit
x2 = 1:length(gc_trace);      % create x vector
y1 = gc_trace;                % assign y vector

validdata = ~isnan(gc_trace); % When Y (Gcamp signal) is NaN, make X also NaN
x1_valid = x2(validdata);
y1_valid = y1(validdata);

p = polyfit(x1_valid, y1_valid',2); 
y1_polyval = polyval(p,x2);

for t=1:length(y1_polyval)
    new(t) = (gc_trace(t) - y1_polyval(t)) / y1_polyval(t);
end
xmean = nanmean(new)           % before 6/29/2017: xmean = nanmean(gcamp(:,5));
                                % here, we should get xmean = 0
%A = new - xmean;
gc_dff = new;            %%% gcamp column 7 = dF/F
end

