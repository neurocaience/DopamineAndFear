function [SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas_shuffle(tbl,num_opto,num_yfp)

p = nan(1,100);

% tbl = table of variables
% f_cs = dependent variable (from tbl.f_cs)

t1{1} = tbl.f_cs;
t1{2} = tbl.f_light;
t1{3} = tbl.f_postlight;
t1{4} = tbl.f_iti;
t1{5} = tbl.f_cs5;
t1{6} = tbl.f_pre;

Ps = {};
SSQs = {};
DFs = {};
MSQs = {};
Fs = {};

num_sh = 100;
num_trials = 63;

name = {'f_cs','f_light','f_postlight','f_iti','f_cs5','f_pre'};

for test=1:size(t1,2)

    for e=1:num_sh
    tbl_sh = opto_shuffle(tbl, num_opto, num_yfp, num_trials);

    t = t1{test};

    t2 = tbl_sh.group;
    [~,~,t2_num] = unique(t2);

    t3 = tbl_sh.ttN;

    t4 = tbl_sh.mID;
    [~,~,t4_num] = unique(t4);

    tbl_anova = [t t2_num t3 t4_num];   %  col 2 = mID

        [row, ~] = find(isnan(tbl_anova));

        if length(row)>1  % If there is a nan value
            disp('NaN values in these rows:')
            %disp(tbl_anova(row,:));
            tbl_anova(row,:) = [];              % remove rows that are nan
            rows_mouse = tbl_anova(:,4) == 25;  % remove mice that don't have all data
            tbl_anova(rows_mouse,:) = [];       
            disp('Removed mouse 25')

            [~,~,t4b] = unique(tbl_anova(:,4)); % recode unique values for mice so they are in order
            tbl_anova(:,4) = t4b;
        end

        disp(name{test})
        [SSQs{test,e}, DFs{test,e}, MSQs{test,e}, Fs{test,e}, Ps{test,e}]=mixed_between_within_anova(tbl_anova);
        p(test,e) = cell2mat(Ps{test,e}(4));
    end
    
    figure(test), clf, set(gcf,'color','white')
    bins = 0:.001:1;
    h=histogram(p(test,:),'binedges',bins,...
        'edgecolor','b', 'facecolor','b', 'Normalization','probability','facealpha',.3);
    xlabel('p-value')
    ylabel('Histogram probability')
    title([name{test} ': 100 shuffled experiments'])


end

end