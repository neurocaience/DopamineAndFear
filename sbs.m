%% sbs() from c6_plotall.m 4/25/2019
function [o1_mean, o1_std, o1_aamean,o_1] = sbs(data2, tones, expd, num_cs, len_cs, num_st,num_tail)

%expd = 2;    % extinction 1 = experiment day 2
%num_cs = 21;
%len_cs = 20;   % CS is 20 s long
%num_st = 10;
%num_tail = 50+len_cs;
o_1 = nan(size(data2,2),num_cs, num_st+num_tail); 

for cs=1:num_cs     % for every CS, collect sec-by-sec data
    t = tones(cs,expd);
    if cs == 21 % if it's the last CS, 
        minval = min(t+num_tail,size(data2,1));
        o_1(:,cs,1:(minval-t-num_st+len_cs)) = data2((t-num_st):(minval-1),:)';
    else
        o_1(:,cs,:) = data2((t-num_st):(t+num_tail-1),:)';
    end
end

% check: 
% plot(squeeze(mean(o_1,2))')

o1_aamean = squeeze(nanmean(o_1,2))';   % mean per animal
o1_mean = nanmean(o1_aamean,2);   % mean across animals
o1_std = squeeze(nanstd(o1_aamean,[],2))./sqrt(size(data2,2));  % std across animals

disp('sbs done')
end