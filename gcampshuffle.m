function [mean_shuffle, std_shuffle] = gcampshuffle(n_shuffles, mvta_gc, mvta_mID)

% Shuffle gcamp data, 1000 shuffles of tone

%n_shuffles = 1000;   % number of shuffles. ie. 10 = shuffle data from all mice 10 times. (total = 10 x num_mice = 100 times)

%gcamp_shuffle_all = nan(n_shuffles, size(mID,1), 84, 5500);   % 84 trials, 5500 is length (can be adjusted in functions)
mean_shuffle = nan(n_shuffles, 5, 5500);
std_shuffle = nan(n_shuffles, 5, 5500);
for k = 1:n_shuffles
    [~, mean_shuffle(k,:,:), std_shuffle(k,:,:)] ...
        = gcampCircshift_shuffle(mvta_gc, mvta_mID);  % alternative: gcampCircshift_shift, gcampTTL_shift, which works but has basline difference
    disp(['done shuffle' num2str(k)])
end

end