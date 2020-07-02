function [master_frz] = extract_rawfrz_FF(pre, mID, tones, num_days)

% This function is the same as extract_rawfrz, except it takes as input 
% freezeframe data instead of CNN analyzed data and combines it into
% 1 matrix. It also downsamples the raw 11.23 Hz behavioral data 
% (analyzed by CNN) to 1 s.
% Input: 
% - mID: mouse IDs
% - tones: matrix of tone durations
% - num_days: number of experiments days

% Output: 
% cnn_sbs: (#mice, #experiment days (4), #seconds (2250))
% cnn_tbt: (#mice, #trials (84), %freezing during cue)

% num_days=4;             % Number of experiment days
size_file = 2250;      % Length of the file
master_frz = nan(size(mID,1),num_days,size_file);

for m = 1:size(mID,1)
    for extd = 1:num_days
        try
            temp_frz = xlsread(['freeze_formatted_' mID{m} '_0' num2str(extd-1) '.xlsx']);  %
            temp_frz = circshift(temp_frz, [-1, 0]);         % fix indexing issue in FreezeView by shifting everything by 1 s;
            temp_frz((end-11):end) = nan;
            master_frz(m,extd,1:min(size_file,length(temp_frz))) = temp_frz(1:min(length(temp_frz),size_file));   % incorporate frz into 1 master frz matrix
            disp(['Done: '  pre mID{m} '_0' num2str(extd-1) '.csv'])
        catch
            disp(['Skipped ' 'freeze_formatted_' mID{m} '_0' num2str(extd-1) '.xlsx : File did not open'])
        end
    end
end

disp('Done: Extract Freezing files from FreezeFrame')

end