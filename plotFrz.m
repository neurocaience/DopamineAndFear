function [] = plotFrz(sbs_bytrial, fignum)
sbs_bytrial_mean = squeeze(nanmean(sbs_bytrial,1));

a = [1  11 22 43 63];
b = [10 20 42 63 84];
ts = 1;
te = 40;

for k=1:5
    
    figure(fignum+k), clf, set(gcf,'color','white')    
    imagesc(sbs_bytrial_mean(a(k):b(k),ts:te)); colormap(gray), caxis([0 100]), %colorbar
    axis off
    %ylim([0 21.5])
end

end