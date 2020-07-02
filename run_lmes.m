%%
% This function runs LMEs
% Input: a Matlab table format, output of 'totable' function

function [coefs] = run_lmes(tbl)

lmes{1} = 'f_cs ~ 1 + ttN + group + (1|mID)';
lmes{2} = 'f_light ~ 1 + ttN + group + (1|mID)';
lmes{3} = 'f_postlight ~ 1 + ttN + group + (1|mID)';
lmes{4} = 'f_iti ~ 1 + ttN + group + (1|mID)';
lmes{5} = 'f_cs ~ 1 + ttN*group + (1|mID)';
lmes{6} = 'f_light ~ 1 + ttN*group + (1|mID)';
lmes{7} = 'f_postlight ~ 1 + ttN*group + (1|mID)';
lmes{8} = 'f_iti ~ 1 + ttN*group + (1|mID)';
lmes{9} = 'f_cs5 ~ 1 + ttN + group + (1|mID)';
lmes{10} = 'f_cs5 ~ 1 + ttN*group + (1|mID)';
lmes{11} = 'f_pre ~ 1 + ttN + group + (1|mID)';
lmes{12} = 'f_pre ~ 1 + ttN*group + (1|mID)';
lmes{13} = 'f_cs ~ 1 + ttN*group + (1|mID) + (ttN|mID)';
lmes{14} = 'f_light ~ 1 + ttN*group + (1|mID) + (ttN|mID)';
lmes{15} = 'f_postlight ~ 1 + ttN*group + (1|mID) + (ttN|mID)';
lmes{16} = 'f_iti ~ 1 + ttN*group + (1|mID) + (ttN|mID)';
lmes{17} = 'f_cs5 ~ 1 + ttN*group + (1|mID) + (ttN|mID)';
lmes{18} = 'f_pre ~ 1 + ttN*group + (1|mID) + (ttN|mID)';

% lmes{1} = 'f_cs ~ 1 + ttN + group';
% lmes{2} = 'f_light ~ 1 + ttN + group ';
% lmes{3} = 'f_postlight ~ 1 + ttN + group ';
% lmes{4} = 'f_iti ~ 1 + ttN + group ';
% lmes{5} = 'f_cs ~ 1 + ttN*group ';
% lmes{6} = 'f_light ~ 1 + ttN*group';
% lmes{7} = 'f_postlight ~ 1 + ttN*group ';
% lmes{8} = 'f_iti ~ 1 + ttN*group ';
% lmes{9} = 'f_cs5 ~ 1 + ttN + group';
% lmes{10} = 'f_cs5 ~ 1 + ttN*group ';

for L = 1:size(lmes,2)
    lme = fitlme(tbl, lmes{L});
    coefs(L).model = lme; 
    coefs(L).lme = lmes{L};
    coefs(L).name = lme.Coefficients.Name;    
    coefs(L).estimate = lme.Coefficients.Estimate;
    coefs(L).pvalue = lme.Coefficients.pValue;
    coefs(L).logpvalue = log(lme.Coefficients.pValue);
end

end