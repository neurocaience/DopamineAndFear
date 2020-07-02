% Plot opto CNN
% cohort 15 and 16 - latVTA males, cue ON

% Bucket: 
addpath('Y:\Lili\Paper Anaysis')
addpath('Y:\Lili\ManualScoring\c16\c16_frames_cnn_res_gpu')
addpath('Y:\Lili\ManualScoring\c15\c15_frames_cnn_res_gpu')
addpath('Y:\Lili\ManualScoring\c14\c14_frames_cnn_res_gpu')
addpath('Y:\Lili\ManualScoring\c11\c11_frames_cnn_res_gpu')
addpath('Y:\Lili\ManualScoring\c7\c7_frames_cnn_res_gpu')
addpath('Y:\Lili\Paper Analysis\Gcamp\Raw_to_matrix')
addpath('Y:\Lili\Paper Analysis\Scripts')
addpath('Y:\Lili\ManualScoring\Cameron')
addpath('Y:\Lili\ManualScoring\Helen')
addpath('Y:\Lili\ManualScoring\')

% Lili's computer: 
addpath('helper_functions')
addpath('C:\Users\lxcai\Desktop\thesis\dopaminefearproj\scripts')

tones = load('tones.mat');
tones = tones.tones;
regionStim = 'SNc, CueOff Inhibition';
%% Load data

mID_opto = {
       'c7_m1075o';
       'c7_m1076o';
       'c7_m1077o';     
       'c7_m1080o';
       'c7_m1082o';       
       'c7_m1084o';
       'c7_m1085o';         
       };
   
mID_yfp = {
       'c7_m1078y';        
       'c7_m1079y';  
       'c7_m1081y';       
       'c7_m1083y';    
       'c7_m1086y';       
       'c7_m1087y';
};

num_opto = size(mID_opto,1);
num_yfp = size(mID_yfp,1);

opto = extractFrz(mID_opto);
yfp = extractFrz(mID_yfp);

%%
% From the raw cnn data, get bouts (bout size 11), get second-by-second
% data and trial by trial data

[opto_bouts, opto_sbs, opto_sbs_bouts, opto_tbt, opto_tbt_bouts] = boutsSbsTbt(opto);
[yfp_bouts, yfp_sbs, yfp_sbs_bouts, yfp_tbt, yfp_tbt_bouts] = boutsSbsTbt(yfp);

%%
% Make sure opto_sbs and yfp_sbs is only 2250 max length
max_s = 2250;
opto_sbs = opto_sbs(:,:,1:max_s);
yfp_sbs = yfp_sbs(:,:,1:max_s);

num_cs = 21;
d_opto = permute(opto_sbs, [2 1 3]);   % permute the data so it fits in the format for frz_eval()
d_yfp = permute(yfp_sbs, [2 1 3]);

[o, om, ostd, y, ym, ystd] = frz_eval2(d_opto,d_yfp,0,19,tones,num_cs);
[o1, om1, ostd1, y1, ym1, ystd1] = frz_eval2(d_opto,d_yfp,19+1,19+6,tones,num_cs);
[o2, om2, ostd2, y2, ym2, ystd2] = frz_eval2(d_opto,d_yfp,19+6+1,19+6+6,tones,num_cs);
[o3, om3, ostd3, y3, ym3, ystd3] = frz_eval2(d_opto,d_yfp,19+6+7,19+6+6+10,tones,num_cs);

[o_pre20, om_pre20, ostd_pre20, y_pre20, ym_pre20, ystd_pre20] = frz_eval2(d_opto,d_yfp,-20,-19,tones,num_cs);
[o_post20, om_post20, ostd_post20, y_post20, ym_post20, ystd_post20] = frz_eval2(d_opto,d_yfp,20,39,tones,num_cs);
% At this point, we can plot trial-by-trial data across 4 days

%% s-by-s across 3 extinction days
num_cs = 21;
len_cs = 20;   % CS is 20 s long
num_st = 10;
num_tail = 50+len_cs;

% Format data into the one used by sbs: 
o_00 = squeeze(opto_sbs(:,1,:))';
o_01 = squeeze(opto_sbs(:,2,:))';
o_02 = squeeze(opto_sbs(:,3,:))';
o_03 = squeeze(opto_sbs(:,4,:))';

y_00 = squeeze(yfp_sbs(:,1,:))';
y_01 = squeeze(yfp_sbs(:,2,:))';
y_02 = squeeze(yfp_sbs(:,3,:))';
y_03 = squeeze(yfp_sbs(:,4,:))';

% Calculate s-b-s freezing

[o1m, o1std, o1aam,oo1] = sbs(o_01, tones, 2, num_cs, len_cs, num_st,num_tail);   % extinction 1
[y1m, y1std, y1aam,yy1] = sbs(y_01, tones, 2, num_cs, len_cs, num_st,num_tail);

[o2m, o2std, o2aam,oo2] = sbs(o_02, tones, 3, num_cs, len_cs, num_st,num_tail);    % extinction 2
[y2m, y2std, y2aam,yy2] = sbs(y_02, tones, 3, num_cs, len_cs, num_st,num_tail);
 
[o3m, o3std, o3aam,oo3] = sbs(o_03, tones, 4, num_cs, len_cs, num_st,num_tail);    % extinction 3
[y3m, y3std, y3aam,yy3] = sbs(y_03, tones, 4, num_cs, len_cs, num_st,num_tail);

%%
plotOptoFig(oo1, oo2, oo3, yy1, yy2, yy3, ym, om, ystd, ostd, ...
    y1m, y1std, o1m, o1std, y2m, y2std, o2m, o2std, y3m, y3std, ...
    o3m, o3std, mID_opto, mID_yfp, regionStim)


%%
%% LME Formatting
d_opto_ext = d_opto(2:4,:,:);
d_yfp_ext = d_yfp(2:4,:,:);
tbl = totable(mID_opto, mID_yfp, d_opto_ext, d_yfp_ext, regionStim, tones);

%%
tbl1 = tbl;
tbl1(ismember(tbl1.extD,2),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');
tbl1(ismember(tbl1.extD,3),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');

tbl2 = tbl;
tbl2(ismember(tbl2.extD,1),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');
tbl2(ismember(tbl2.extD,3),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');

tbl3 = tbl;
tbl3(ismember(tbl3.extD,1),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');
tbl3(ismember(tbl3.extD,2),:)=[];    % get rid of rows where extD = 1lme1a = fitlme(tbl_latVTA, 'f_cs ~ 1 + ttN + group + (1|mID)');

res1 = run_lmes(tbl1);
res2 = run_lmes(tbl2);
res3 = run_lmes(tbl3);
resall = run_lmes(tbl);
%%
[SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas(tbl);
%run_anovas_shuffle(tbl, num_opto, num_yfp);
[SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas_extD(tbl1);
[SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas_extD(tbl2);
[SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas_extD(tbl3);

%%
d_opto_ext(:,:,2251:2270) = NaN;  %increase nan values at end so you can take the mean even if array ends
d_yfp_ext(:,:,2251:2270) = NaN;
tbl2 = totable2(mID_opto, mID_yfp, d_opto_ext, d_yfp_ext, regionStim, tones);
[SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas2(tbl2); 

%% posthoc tests
tbl1_mean = varfun(@mean, tbl1, 'InputVariables', 'f_cs', 'GroupingVariables', 'mID');
tbl1_opto = []; tbl1_yfp = [];
for m = 1:size(tbl1_mean)
    if strfind(tbl1_mean.mID{m}, 'y') >= 1
        tbl1_yfp = [tbl1_yfp tbl1_mean.mean_f_cs(m)]; 
    else
        tbl1_opto = [tbl1_opto tbl1_mean.mean_f_cs(m)];
    end
end

[h, p] = ttest2(tbl1_opto, tbl1_yfp)  % ttest2 is two-sample ttest (unpaired)



%%
nphr = 0;
cueon = 0;
plotOptoFigLme(oo1, oo2, oo3, yy1, yy2, yy3, ym, om, ystd, ostd, ...
    y1m, y1std, o1m, o1std, y2m, y2std, o2m, o2std, y3m, y3std, ...
    o3m, o3std, mID_opto, mID_yfp, regionStim, res1, res2, res3, resall, nphr, cueon, ...
    o, y);
