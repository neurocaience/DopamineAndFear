function lvta_trialsITI_1Hz = gcamp_to_1Hz(lvta_trialsITI)
Fs = 100; % Average every n values

for m=1:size(lvta_trialsITI,1)
    for t=1:84
        temp1 = squeeze(lvta_trialsITI(m,t,:));
        lvta_trialsITI_1Hz(m,t,:) = arrayfun(@(i) mean(temp1(i:i+Fs-1)),1:Fs:length(temp1)-Fs+1)';
    end
end

end