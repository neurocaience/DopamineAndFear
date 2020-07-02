function [] = plotShockOnly(mID, fignum, colorval)

latVTA_shock = nan(size(mID,1),3,150000);
for m = 1:size(mID,1)
    
        temp = f_gcamp_polyfit_shockonly2(mID{m},'04',1,2,2);
        latVTA_shock(m,:,1:length(temp)) = temp';
   
    disp(['done' mID(m,:)]);
end
max_length = 131800;
latVTA_shock = latVTA_shock(:,:,1:max_length);

plot(squeeze(latVTA_shock(2,1,:)));
% for some reason there's some addition of 'tone' channel, probably from
% copying old code? 


%%

gcamp_shock = nan(size(mID,1),5,5500);    
d = 1;

for m = 1:size(mID,1)
j=1;
        for k = 2:length(latVTA_shock)-1
            if latVTA_shock(m,1,k) == 1 && latVTA_shock(m,1,k-1) <= .5
                min_length = min(max_length, k+3100);
                temp = latVTA_shock(m,3,k-2399:min_length);
                gcamp_shock(m,j,1:length(temp)) = temp;
                j = j+1;
                j
            end
        end

end   

%% plot figures
figure(fignum), clf, hold on
ts = 2000;
te = 4000;
gcamp_shock_section = gcamp_shock(:,:,ts:te);
set(gcf,'color','white')
gcamp_shock_mean = squeeze(nanmean(nanmean(gcamp_shock_section,1),2));
gcamp_shock_sem = squeeze(std(nanmean(gcamp_shock_section,1),[],2)./sqrt(size(gcamp_shock_section,2)));
errorbar(gcamp_shock_mean, gcamp_shock_sem, 'capsize',0,'color',colorval) %[198/255 226/255 238/255]) %
plot(gcamp_shock_mean,'color','k','linewidth',1)
plot([2400-ts 2500-ts],[-.5 -.5], 'color','r','linewidth',1)
plot([4400-ts 4500-ts],[-.5 -.5], 'color','k','linewidth',1)
plot([4400-ts 4400-ts],[-.5 0], 'color','k','linewidth',1)
axis off

end