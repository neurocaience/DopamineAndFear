function [] = extract_rawfrz()

num_days=4;             % Number of experiment days
size_file = 25354;      % Length of the file
master_frz = nan(size(mID,1),num_days,size_file);

for m = 1:size(mID,1)
    for extd = 1:num_days
        temp_frz = xlsread([pre mID{m} '_0' num2str(extd-1) '.csv']);
        temp_frz = circshift(temp_frz, [-11, 0]);         % [1, 0], fix indexing issue in FreezeView by shifting everything by 1 s; so up 11 frames
        %temp_frz((end-1):end) = nan;
        master_frz(m,extd,1:min(size_file,length(temp_frz))) = temp_frz(1:min(length(temp_frz),size_file));   % incorporate frz into 1 master frz matrix
        disp(['Done: '  pre mID{m} '_0' num2str(extd-1) '.csv'])
    end
end

% Invert: 
% Before:    1 = no freeze, 0 = freeze
% Now:       1 = freeze,    0 = no freeze
master_frz = 1-master_frz;

disp('Done: Extract Freezing files from CNN into 1 matrix')

% Run bout analysis on freezing files
% --- master_frz_bouts = bouts(11,master_frz);

% Extract sec-by-sec freezing (with and without bouts)
cnn_sbs = format1s(master_frz);
% --- cnn_sbs_bouts = format1s(master_frz_bouts);

% Multiply by 100 to get % freezing
cnn_sbs = cnn_sbs*100;
% --- cnn_sbs_bouts = cnn_sbs_bouts*100;

% Get rid of m312_02, from 858 seconds onward, bc the napkin fell
if isLatVTA == 1   % If it's a latVTA animal
    cnn_sbs(7,3,858:end) = NaN;
    % --- cnn_sbs_bouts(7,3,858:end) = NaN;    
end

% Check data
% imagesc(squeeze(master_frz(1,:,:)))
% imagesc(squeeze(master_frz_bout(1,:,:)))
% imagesc(squeeze(master_frz_1s(1,:,:)))
% imagesc(squeeze(master_frz_bout_1s(1,:,:)))

% Extract trial-by-trial freezing (with and without bouts)
num_cs = 21; 
cnn_tbt = frz_eval(cnn_sbs,0,19,tones, num_cs);   % B= bouts, S = 1s