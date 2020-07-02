function [TP, TN, FP, FN, FPR, FNR, tp_num, tn_num, fp_num, fn_num, Acc] = tp_tn_fp_fn(s1, s2)

% where s1 is "ground truth"

fn_num = find(s1==1 & s2 == 0);
tp_num = find(s1==1 & s2 == 1);
tn_num = find(s1==0 & s2 == 0);
fp_num = find(s1==0 & s2 == 1);

TP = length(tp_num) / length(s1);
FP = length(fp_num) / length(s1);
TN = length(tn_num) / length(s1);
FN = length(fn_num) / length(s1);


FPR = length(fp_num) / (length(fp_num) + length(tn_num));
FNR = length(fn_num) / (length(fn_num) + length(tp_num));

Acc = (length(tp_num) + length(tn_num)) / (length(tp_num) + length(tn_num) + length(fn_num) + length(fp_num));


end