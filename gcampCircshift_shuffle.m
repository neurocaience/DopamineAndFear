function [gcamp_tones_shuffle_reshape, mean_shuffle, std_shuffle] = gcampCircshift_shuffle(master_gcamp,mID)
% given a shuffled TTL, create a matrix of values 

% get the time locked 'tone' duration of the shuffle
num_cs=21;
num_gcamp_trace_length = 5500;
gcamp_tones_shuffle = nan(size(mID,1), 4, 21, num_gcamp_trace_length);
gcamp_tones_shuffle_reshape = nan(size(mID,1), 4*21, num_gcamp_trace_length);  % this is just a reshape of gcamp_tones_shuffle

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


for m = 1:size(mID,1)
    for d = 1:4
        j = 1;
        for k = 2:length(master_gcamp)-1
            if master_gcamp(m,d,2,k) == 1 && master_gcamp(m,d,2,k-1) <= .5               
                gcamp_tones_shuffle(m,d,j,:) = master_gcamp_circshift(m,d,3,k-499:k+5000);  % 3 in third position means z-score(dF/F), 4 means dF/F
                j = j+1;
            end
        end
        temp = squeeze(gcamp_tones_shuffle(m,d,:,:));
        gcamp_tones_shuffle_reshape(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end

a = [1  11 22 43 64];
b = [10 20 42 63 84];
mean_shuffle = nan(5,5500);
std_shuffle = nan(5,5500);
for context=1:5
    mean_shuffle(context,:) = squeeze(nanmean(nanmean(gcamp_tones_shuffle_reshape(:,a(context):b(context),:),2),1));
    std_shuffle(context,:) = squeeze(nanstd(nanmean(gcamp_tones_shuffle_reshape(:,a(context):b(context),:),2),[],1));
end

end