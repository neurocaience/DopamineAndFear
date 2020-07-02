function master_frz_tones = bytrial_sbs(dms_sbs, tones)

% Lili X. Cai, 3/4/2020
% Turns cnn_sbs equivalent by arranging the matrix to the tone start of
% each trial

% Save freezing in same format as gcamp --> for Gecia --> 5 s pre, 30 s post
tones_iti = tones(2:end,:) - tones(1:end-1,:);
tones_iti(21,:) = 2257-tones(21,:);  % last ITI is final number minus the tone start of final CS
tones_iti(isnan(tones_iti)==1) = 0;
tones_iti(20,1) = 162;
num_cs = 21;
tone_sec = 20;
num_pre = 5;  % 10 seconds pre CS
max_iti = max(max(tones_iti(:,1:4)));

frz_tones = nan(size(dms_sbs,1), 4, 21, num_pre + max_iti);
master_frz_tones = nan(size(dms_sbs,1), 4*21, num_pre + max_iti);

for m = 1:size(dms_sbs,1)
    for d = 1:4
        for cs =1:num_cs
            if isnan(tones(cs,d)) == 1
                % skip if it's a nan
            else
                ts = tones(cs,d);
                te = min(size(dms_sbs,3), ts+tones_iti(cs,d));
                length1 = size(ts-num_pre+1:te,2);
                frz_tones(m,d,cs,1:length1) = dms_sbs(m,d,(ts-num_pre+1):te);
                %error 
            end
        end
        temp = squeeze(frz_tones(m,d,:,:));
        master_frz_tones(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end

end