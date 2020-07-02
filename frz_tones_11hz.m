function [master_frz_tones3] = frz_tones_11hz(mID, tones, master_frz)

%% Save freezing without downsampling to 1 s
% Save freezing in same format as gcamp --> for Gecia --> 5 s pre, 30 s post
tones_iti = tones(2:end,:) - tones(1:end-1,:);
tones_iti(21,:) = 2257-tones(21,:);  % last ITI is final number minus the tone start of final CS
tones_iti(isnan(tones_iti)==1) = 0;
tones_iti(20,1) = 162;
size_cnn = 2257;   % size of cnn
num_cs = 21;
tone_sec = 20;
num_pre = 10;  % 10 seconds pre CS
max_iti = max(max(tones_iti(:,1:4)));
Fs_vid = 11.23;

frz_tones2 = nan(size(mID,1), 4, 21, floor((num_pre + max_iti)*Fs_vid));
master_frz_tones3 = nan(size(mID,1), 4*21, floor((num_pre + max_iti)*Fs_vid));

for m = 1:size(mID,1)
    for d = 1:4 %:4
        for cs =1:num_cs
            if isnan(tones(cs,d)) == 1
                % skip if it's a nan
                disp(['skip day' num2str(d) 'cs' num2str(cs)])
            else
                ts = tones(cs,d);
                te = min(2257, ts+tones_iti(cs,d));
                disp(['day' num2str(d) 'cs' num2str(cs) 'te' num2str(te)])
                length1 = size(round((ts-num_pre+1)*Fs_vid):round(te*Fs_vid),2);
                frz_tones2(m,d,cs,1:length1) = master_frz(m,d,round((ts-num_pre+1)*Fs_vid):round(te*Fs_vid));
                %error               %error 
            end
        end
        temp = squeeze(frz_tones2(m,d,:,:));
        master_frz_tones3(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end
%master_frz_tones(:,:,56:end) = [];
figure(85), clf, 
imagesc(squeeze(master_frz_tones3(2,:,:)))

%%
max_amt = round(133*11.23);
master_frz_tones3 = master_frz_tones3(:,:,1:1494);
figure(85), clf, 
imagesc(squeeze(master_frz_tones3(2,:,:)))
title('Freezing, no downsampling')

end