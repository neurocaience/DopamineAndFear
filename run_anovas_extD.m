function [SSQs, DFs, MSQs, Fs, Ps, name] = run_anovas_extD(tbl)

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

name = {'f_cs','f_light','f_postlight','f_iti','f_cs5','f_pre'};

for test = 1:size(t1,2)
    t = t1{test};
    
    t2 = tbl.group;
    [~,~,t2_num] = unique(t2);

    t3 = tbl.tN;

    t4 = tbl.mID;
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
    [SSQs{test}, DFs{test}, MSQs{test}, Fs{test}, Ps{test}]=mixed_between_within_anova(tbl_anova);
    
end

end
