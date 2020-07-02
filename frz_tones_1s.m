function [master_frz_tones] = frz_tones_1s(tones, mID_opto, opto_sbs)

tones_iti = tones(2:end,:) - tones(1:end-1,:);
tones_iti(21,:) = 2257-tones(21,:);  % last ITI is final number minus the tone start of final CS
tones_iti(isnan(tones_iti)==1) = 0;
tones_iti(20,1) = 162;
num_cs = 21;
tone_sec = 20;
num_pre = 10;  % 10 seconds pre CS
max_iti = max(max(tones_iti(:,1:4)));

frz_tones = nan(size(mID_opto,1), 4, 21, num_pre + max_iti);
master_frz_tones = nan(size(mID_opto,1), 4*21, num_pre + max_iti);

for m = 1:size(mID_opto,1)
    for d = 1:4
        for cs =1:num_cs
            if isnan(tones(cs,d)) == 1
                % skip if it's a nan
            else
                ts = tones(cs,d);
                te = min(size(opto_sbs,3), ts+tones_iti(cs,d));
                length1 = size(ts-num_pre+1:te,2);
                frz_tones(m,d,cs,1:length1) = opto_sbs(m,d,(ts-num_pre+1):te);
                %error 
            end
        end
        temp = squeeze(frz_tones(m,d,:,:));
        master_frz_tones(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end

%%
max_amt = 133;
master_frz_tones = master_frz_tones(:,:,1:max_amt);
figure(85), clf, 
imagesc(squeeze(master_frz_tones(2,:,:)))
title('Freezing, no downsampling')


end