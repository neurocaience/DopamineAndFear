function [cnn_sbs, master_frz] = extract_rawfrz(pre, mID, tones, num_days)

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
size_file = 25354;      % Length of the file
master_frz = nan(size(mID,1),num_days,size_file);

for m = 1:size(mID,1)
    for extd = 1:num_days
        temp_frz = xlsread([pre mID{m} '_0' num2str(extd-1) '.csv']);  %
        temp_frz = circshift(temp_frz, [-11, 0]);         % fix indexing issue in FreezeView by shifting everything by 1 s; so up 11 frames
        temp_frz((end-11):end) = nan;
        master_frz(m,extd,1:min(size_file,length(temp_frz))) = temp_frz(1:min(length(temp_frz),size_file));   % incorporate frz into 1 master frz matrix
        disp(['Done: '  pre mID{m} '_0' num2str(extd-1) '.csv'])
    end
end

% Invert the coding of freezing or no freeze: 
% Before:    1 = no freeze, 0 = freeze
% Now:       1 = freeze,    0 = no freeze
master_frz = 1-master_frz;

disp('Done: Extract Freezing files from CNN into 1 matrix')

% Extract sec-by-sec freezing (with and without bouts)
cnn_sbs = format1s(master_frz);
disp('Done: Downsample from 11.23 Hz to 1 s')

% Multiply by 100 to get % freezing
cnn_sbs = cnn_sbs*100;

% Check data
% imagesc(squeeze(master_frz(1,:,:)))
% imagesc(squeeze(master_frz_bout(1,:,:)))
% imagesc(squeeze(master_frz_1s(1,:,:)))
% imagesc(squeeze(master_frz_bout_1s(1,:,:)))


% Internal functions ---------------------------------------
function out_1s = format1s(out, args)
    if nargin <= 1
        args.Fs = 11.23;
        args.totSeconds = 2250;
    end
    
    % disp('2...')
    d = size(out);   % dimensions of input matrix
    dim = size(d,2);   % # of dimensions of input matrix
    
    % Create out matrix, based on dimensions of input dimensions
    if dim == 2
        out_1s = nan(d(1), args.totSeconds);
        for m = 1:d(1)
            for s = 1:(args.totSeconds+20)
                % ts = time_start (index)
                % te = time_end (index)
                if s == 1
                    ts = 1;                     % If s ('second') is 1, it's 1
                else
                    ts = ceil(s*args.Fs - args.Fs);    % If it's another second, round by sampling rate
                end
                te = floor((s+1)*args.Fs - args.Fs);
                
                try
                    % Take the mean between index time_start and time_end
                    out_1s(m,s) = nanmean(out(m,ts:te));
                catch
                    % If it doesn't work, it means it's the end of file.
                    % Print catch statement:
                    disp(['m' num2str(m) ', End of file s=' num2str(s) ', ts=' num2str(ts) ', te=' num2str(te)])
                    break;
                end
            end
        end
    end
    
    if dim == 3
        out_1s = nan(d(1), d(2), args.totSeconds);
        for m = 1:d(1)
            for expd = 1:d(2)
                for s = 1:(args.totSeconds+20)
                    % ts = time_start (index)
                    % te = time_end (index)
                    if s == 1
                        ts = 1;                     % If s ('second') is 1, it's 1
                    else
                        ts = ceil(s*args.Fs - args.Fs);    % If it's another second, round by sampling rate
                    end
                    te = floor((s+1)*args.Fs - args.Fs);
                    
                    try
                        % Take the mean between index time_start and time_end
                        out_1s(m,expd,s) = nanmean(out(m,expd,ts:te));
                    catch
                        % If it doesn't work, it means it's the end of file.
                        % Print catch statement:
                        disp(['m' num2str(m) ', expd' num2str(expd) ', End of file s=' num2str(s) ', ts=' num2str(ts) ', te=' num2str(te)])
                        break;
                    end
                end
            end
        end
    end
end


end