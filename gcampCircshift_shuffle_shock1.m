function [gcamp_shuffle_shock1, mean_gcamp_shuffle_shock1, ...
    std_gcamp_shuffle_shock1] = gcampCircshift_shuffle_shock1(master_gcamp, mID)

samples_pre = 2499;   % samples before shock start
samples_post = 10000;  % samples after shock start
num_gcamp_trace_length = length(1-samples_pre:1+samples_post);

% make matrix smaller to get rid of nans
% visualize the nans on day 1: 
%imagesc(squeeze(master_gcamp(:,1,3,:))) % --> note 219200 is around
%earliest trace with nans
mat_end = 219200;
master_gcamp2 = master_gcamp(:,:,:,1:mat_end);

% circshift the data
master_gcamp_circshift = nan(size(master_gcamp));
for m=1:size(mID,1)
    for d = 1:4
        temp = squeeze(master_gcamp(m,d,3,:));
        random_num = 1 + (260000-1)*randn;
        temp = circshift(temp, round(random_num));
        master_gcamp_circshift(m, d, 3, :) =  temp;
    end
end

% extract data just from the first shock
gcamp_shuffle_shock1 = nan(size(mID,1), num_gcamp_trace_length);
d = 1;  % only FC day
for m = 1:size(mID,1)
    j = 1;
    %disp(['first j' num2str(j)])
    for k = 2:length(master_gcamp2) - 1
        if j == 1 
            if (master_gcamp2(m,d,1,k) == 1 && master_gcamp2(m,d,1,k-1) <= .5)
                gcamp_shuffle_shock1(m,:) = master_gcamp_circshift(m,d,3,k-samples_pre:k+samples_post);
                %disp(j)
                j = j + 1;                
            end
        end
    end
end

mean_gcamp_shuffle_shock1 = nanmean(gcamp_shuffle_shock1);
std_gcamp_shuffle_shock1 = nanstd(gcamp_shuffle_shock1);

end