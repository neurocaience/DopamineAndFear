function [] = plot_firstShock(mvta_gc, mvta_mID, fignum, latblue)

%% Find + plot percentile for first shock tone ============================

% =========================================================================

n_shuffles = 100;   % number of shuffles. ie. 10 = shuffle data from all mice 10 times. (total = 10 x num_mice = 100 times)
%gcamp_shuffle_all = nan(n_shuffles, size(mvta_mID,1), 84, 5500);   % 84 trials, 5500 is length (can be adjusted in functions)
mean_shuffle_shock1 = nan(n_shuffles, 12500);
std_shuffle = nan(n_shuffles, 12500);
for k = 1:n_shuffles
    [~, mean_shuffle_shock1(k,:), std_shuffle(k,:)] ...
        = gcampCircshift_shuffle_shock1(mvta_gc, mvta_mID);  % alternative: gcampTTL_shift, which works but has basline difference
    disp(['done shuffle' num2str(k)])
end
%


%% determining percentile
X = 500;  % number of seconds to compare for making percentile
len_mean = length(mean_shuffle_shock1)/X;  % size of new data array
p_high_value = 100 - 1/2;
p_low_value = 0 + 1/2;

temp = nan(len_mean,n_shuffles);
perct_low = nan(len_mean,1);
perct_high = nan(len_mean,1);

    for k = 1:n_shuffles
        temp(:,k) = array_mean(mean_shuffle_shock1(k,:),X);
    end
    
    for len = 1:len_mean
        perct_low(len) = prctile(temp(len,:),p_low_value);
        perct_high(len) = prctile(temp(len,:),p_high_value);
    end

% plot shuffled along with real data

% actual data
samples_pre = 2499;   % samples before shock start -- match this with value in gcampCircshift_shuffle_shock1
samples_post = 10000;  % samples after shock start -- match this with value in gcampCircshift_shuffle_shock1
num_gcamp_trace_length = length(1-samples_pre:1+samples_post);  % -- match this with value in gcampCircshift_shuffle_shock1
gcamp_shock1 = nan(size(mvta_mID,1), num_gcamp_trace_length);
d = 1;  % only FC day
for m = 1:size(mvta_mID,1)
    j = 1;
    %disp(['first j' num2str(j)])
    for k = 2:length(mvta_gc) - 1
        if j == 1 
            if (mvta_gc(m,d,1,k) == 1 && mvta_gc(m,d,1,k-1) <= .5)
                gcamp_shock1(m,:) = mvta_gc(m,d,3,k-samples_pre:k+samples_post);
                %disp(j)
                j = j + 1;                
            end
        end
    end
end

%%

figure(fignum), clf, set(gcf, 'color', 'white'), hold on
% plot shuffled data
ds = 20;  % downsample
gcamp_shock1_ds = gcamp_shock1(:,1:ds:end);

% errorbar(nanmean(mean_shuffle_shock1), nanmean(std_shuffle), 'color', [.5 .5 .5], 'capsize',0), hold on
% plot(nanmean(mean_shuffle_shock1),'color','k')


% significance
X_ds = X/ds;
lvta_m = nanmean(gcamp_shock1_ds);
lvta_m_X = array_mean(lvta_m,X_ds);
yy2 = ones(1,length(lvta_m_X))-2;
xx2 = linspace(1+X_ds/2,length(lvta_m)-X_ds/2,length(lvta_m_X));
xx2
for len=1:length(lvta_m_X)  % for each 'unit of significance analyzed'
    if lvta_m_X(len) < perct_low(len) || lvta_m_X(len) > perct_high(len)
    else
        xx2(len) = NaN;
    end
    
end


lvta_m_X

perct_high
perct_low

    % plot significance in bars
    xx2_ind = find(isnan(xx2')==0);   % find all non-NaN values of xx2
    xx2_nonan = xx2(xx2_ind);         
    yy2_nonan = yy2(xx2_ind);
    
    for x1 = 1:length(xx2_nonan)      % for each bin that is significant
        area_x = [xx2_nonan(x1)-X_ds/2 xx2_nonan(x1)+X_ds/2];   % Area x values = equidistant from calculated values
        area_y = [5 5];                                   %%%% change y values as necessary
        area_y2 = [-3 -3];
        
        area(area_x, area_y, 'facecolor', [.7 .7 .7], 'linestyle', 'none')
        area(area_x, area_y2, 'facecolor', [.7 .7 .7], 'linestyle', 'none')
    end
    

ylim([-2.5 5])
xlim([0 500])
% plot actual data
a = errorbar(nanmean(gcamp_shock1_ds), nanstd(gcamp_shock1_ds), 'color', latblue, 'capsize',0);
plot(nanmean(gcamp_shock1_ds), 'color', 'b')
    
%plot(xx2,yy2,'r.')
set(gca,'xtick',[600/ds:2000/ds:10000/ds])
plot([600/ds 2600/ds], [-2 -2], 'b', 'linewidth', 1)
plot([2500/ds 2600/ds], [-2 -2], 'r', 'linewidth', 1)    

end
