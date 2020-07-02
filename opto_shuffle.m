function tbl_sh = opto_shuffle(tbl, num_opto, num_yfp, num_trials)
% shuffle opto / yfp mice
group = {'yfp','opto'};
tbl_sh = tbl;

    for k=1:num_opto+num_yfp
        tbl_sh.group(((k-1)*num_trials+1):((k-1)*num_trials+num_trials)) = group(round(rand)+1);
    end

end