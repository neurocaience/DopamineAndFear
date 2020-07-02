%% extractFrz() This function extracts the freezing matrices
function master_frz = extractFrz(mID)

    num_frames = 25354;
    num_days = 4;
    num_mice = size(mID,1);
    master_frz = nan(num_mice, num_days, num_frames);

    for m = 1:num_mice
        for extd = 1:num_days
            temp_frz = xlsread([mID{m} '_0' num2str(extd-1) '.csv']);
            temp_frz = circshift(temp_frz, [-11, 0]);         % [1, 0], fix indexing issue in FreezeView by shifting everything by 2 frames
            %temp_frz((end-1):end) = nan;
            master_frz(m,extd,1:min(num_frames,length(temp_frz))) = temp_frz(1:min(length(temp_frz),num_frames));   % incorporate frz into 1 master frz matrix
            disp(['Done: '  mID{m} '_0' num2str(extd-1) '.csv'])
        end
    end
    master_frz = 1-master_frz;
    disp('Done: Extract Freezing files from CNN into 1 matrix')
    
end