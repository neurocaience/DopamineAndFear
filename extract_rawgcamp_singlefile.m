function [master_gcamp, master_gcamp_tones] = extract_rawgcamp_singlefile(mID)
master_gcamp = nan(size(mID,1), 4,5,260000);

for m = 1:size(mID,1)
    %
    for expd = 0:2 %0:3
        
        fn = ['gcamp_' mID{m} '_0' num2str(expd) '.csv'];
        temp_gcamp = xlsread(fn);
        temp_gcamp(:,5) = temp_gcamp(:,4); %%%% CHANGE ME --> 1 channel gcamp doesn't require 2 channels
        temp_gcamp(:,4) = temp_gcamp(:,3); %%%% CHANGE ME --> 1 channel gcamp doesn't require 2 channels        
        temp_gcamp2 = polyfit_gcamp_dF_F(temp_gcamp,2,2,mID{m},expd+1);   % For all latVTA animals, TTLsign and chanel = 2 (might not be for mVTA animals)
              
        master_gcamp(m,expd+1,:,1:min(260000,length(temp_gcamp2))) = temp_gcamp2(1:min(260000,length(temp_gcamp2)),:)';   % incorporate gcamp into 1 master gcamp matrix
        disp(['Done_' mID{m} '_' num2str(expd)])
    end
    %
end

master_gcamp = zscore_acrossdays(master_gcamp);
 
% Gcamp tones
num_cs=21;
num_gcamp_trace_length = 5500;
gcamp_tones = nan(size(mID,1), 4, 21, num_gcamp_trace_length);
master_gcamp_tones = nan(size(mID,1), 4*21, num_gcamp_trace_length);
for m = 1:size(mID,1)
    for d = 1:3 %4
        j = 1;
        for k = 2:length(master_gcamp)-1
            if master_gcamp(m,d,2,k) == 1 && master_gcamp(m,d,2,k-1) <= .5
                gcamp_tones(m,d,j,:) = master_gcamp(m,d,6,k-499:k+5000);  % column 6 is z-score dF/F across 4 experiment days
                j = j+1;
            end
        end
        temp = squeeze(gcamp_tones(m,d,:,:));
        master_gcamp_tones(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end

disp('Gcamp extraction complete')

end