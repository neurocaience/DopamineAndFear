function [tabl] = extract_tbl(mID, gc_tones, frz, tones, random_perm, ...
    frz_st, frz_end, gc_st, gc_end)
    
    gc = nanmean(gc_tones(:,22:84,gc_st:gc_end),3);
    % put gc in 1 column in terms of mouse
    gc2 = reshape(gc',[size(gc,1)*size(gc,2) 1]);  % Checked to make sure it was right
    
    % extract frz 
    if random_perm == 1   % If it's a random permutation of mouse freezing for control
        %rand_order = randperm(size(mID,1));
        rand_order = [4 2 3 8 7 6 9 1 5 10];
        master_frz_random = frz(rand_order,:,:);
        disp(rand_order)
    else 
        master_frz_random = frz;   % no change to data
    end

    % frz =
    % frz_extract(master_frz_latvta_nn,bins2(fval,1),bins2(fval,2),tones,21);
    % % checked that it matches, original code
    
    frz = frz_eval_extinctiononly(master_frz_random,frz_st,frz_end,tones,21);  % checked that it matches
    % put frz in a column 
    frz2 = permute(frz,[1 3 2]);
    % check: 
    %disp('size') 
    %size(frz2)
    %size(master_gcamp_tones_latVTA)    
    %size(gc2)
    frz2 = reshape(frz2,[size(gc_tones,1) 63]);

    frz2 = reshape(frz2',[size(gc_tones,1)*63 1]);  % checked that it's correct
    
    % change in frz 
    frz3 = circshift(frz2,-1);
    frz3(63:63:end) = NaN;
    frzdiff = frz3-frz2;
    frzdiffperc = nan(size(frz2));
        frzdiffperc = frzdiff./frz2;
        frzdiffperc(frz2==0) = 1;
        frzdiffperc(frz3==0) = -1;
        frzdiffperc(frzdiff==0) = 0; 
        
    
    % create frz in next timepoints
    frz4 = circshift(frz3,-1); frz4(63:63:end) = NaN;
    frz5 = circshift(frz4,-1); frz5(63:63:end) = NaN;
    
    % create frz in previous timepoints
    frz_3 = circshift(frz2,1); frz_3(1:63:end) = NaN;
    frz_4 = circshift(frz_3,1); frz_4(1:63:end) = NaN;
    frz_5 = circshift(frz_4,1); frz_5(1:63:end) = NaN;
    
    % create a column of mIDs
    mIDs = repmat(mID,[1 63]);
    mIDs = reshape(mIDs',[size(gc_tones,1)*63 1]);
    
    % create a column of trial numbers
    tn = 1:63;
    tn2 = repmat(tn,[1 size(gc_tones,1)]);
    ttN = tn2';
    
    tabl = table(mIDs, ttN, gc2, frz2, frzdiff, frzdiffperc, ...
        frz3, frz4, frz5, ...
        frz_3, frz_4, frz_5, ...
        'VariableNames',{'mID','ttN','gc','frz','frzd','frzdperc', ...
            'frz_t1', 'frz_t2','frz_t3', ...
            'frz_minus1', 'frz_minus2', 'frz_minus3'});
   
end
