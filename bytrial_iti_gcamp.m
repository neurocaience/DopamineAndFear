function master_gcamp_tones2 = bytrial_iti_gcamp(mvta_gc, tones, samples_pre)
%% Takes Gcamp actvity, aligns it by trial and includes ITI
% Lili X. Cai, 3/5/2020

if nargin < 3
    samples_pre = 999;
end

tones_iti = tones(2:end,:) - tones(1:end-1,:);
tones_iti(21,:) = 2257-tones(21,:);  % last ITI is final number minus the tone start of final CS
tones_iti(isnan(tones_iti)==1) = 0;
tones_iti(20,1) = 62;  % arbitary
Fs_gcamp = 100;   % gcamp sampling rate
tones_iti_gcamp = tones_iti*Fs_gcamp; 

% Gcamp tones
num_cs=21;
num_gcamp_trace_length = 14300;
gcamp_tones = nan(size(mvta_gc,1), 4, 21, num_gcamp_trace_length);
master_gcamp_tones2 = nan(size(mvta_gc,1), 4*21, num_gcamp_trace_length);

master_gcamp_tones2 = nan(size(mvta_gc,1), 4*21, num_gcamp_trace_length);
for m = 1:size(mvta_gc,1)
    for d = 1:4
        j = 1;
        for k = 2:length(mvta_gc)-1
            if mvta_gc(m,d,2,k) == 1 && mvta_gc(m,d,2,k-1) <= .5
                
                te = tones_iti_gcamp(j,d);
                length1 = size(k-samples_pre+1:k+te,2);               
                disp([num2str(length1) ' ,' num2str(j) ', ' num2str(d) ', ' num2str(k)])
                gcamp_tones(m,d,j,1:length1) = mvta_gc(m,d,3,k-samples_pre+1:k+te);
                j = j+1;
            end
        end
        temp = squeeze(gcamp_tones(m,d,:,:));
        master_gcamp_tones2(m,1+num_cs*(d-1):num_cs+num_cs*(d-1),:) = temp;         
    end
end

end