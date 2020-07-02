function [] = plotgcampforfigure(mvta_sbs, mvta_gctones, mvta_gc, ...
    mean_shuffle, std_shuffle, n_shuffles, sem_color, imagesc_color, axis_label)

if nargin <= 8
    axis_label(1) = -3;   % axis for mean gcamp trace plots
    axis_label(2) = 1;
end

%num_cs = 21; 
%mvta_tbt = frz_eval(mvta_sbs,0,19,tones, num_cs);  

%% Plot Gcamp traces by context ===========================================

% =========================================================================

% Plot Gcamp all in one figure, for each context --------------------------
plotGcampTraces(mvta_gctones, sem_color ,21)

figure(9), clf, set(gcf,'color','white')
mVTA_master_gcamp_tones_mean = squeeze(nanmean(mvta_gctones,1));
mVTA_master_gcamp_tones_mean(isnan(mVTA_master_gcamp_tones_mean)==1)=0;
a = [1 11 22 43 64]; b = [10 20 42 63 84];
ts = 1; te = 4000;

x1 = .1;
y1 = .2;
xd_gcamp = .8;
yd = .7;
xd_g = 0;

y2 = .1; 
y2_d = .1;


for k=1:5
    
    figure(10+k), clf, set(gcf,'color','white')
    subplot('position', [x1+xd_g y1 xd_gcamp yd])
    imagesc(mVTA_master_gcamp_tones_mean(a(k):b(k),ts:te)); colormap(imagesc_color)
    caxis([-1 1])
    axis off
    ylim([0 21.5])
    
    freezeColors;
    
    %subplot('position', [x1 y2 xd_gcamp y2_d])
    %length_mat = length(mVTA_master_gcamp_tones_mean(a(k):b(k),ts:te));
    %x = zeros(1,length_mat);  
    %plot([ts ts+2000], [1.8 1.8], 'b', 'linewidth',5)
    %xlim([1 length_mat]); ylim([1 2])
    %axis off
end


%%
% Plot Gcamp for each context ---------------------------------------------
a = [1  11 22 43 64];
b = [10 20 42 63 84];
n=4500;

% %figure(21), clf, hold on, set(gcf, 'color','white')
% for context=1:5
%     if context == 2
%         plotc = [2 3];
%     elseif context == 1
%         plotc = context;      
%     else 
%         plotc = context+1;
%     end
%     %subplot(6,1,plotc), hold on
%     figure(21+context), clf, hold on, set(gcf, 'color','white')
%     lvta_m = squeeze(nanmean(nanmean(mvta_gctones(:,a(context):b(context),1:n),2),1));
%     lvta_s = squeeze(nanstd(nanmean(mvta_gctones(:,a(context):b(context),1:n),2),[],1));
%     errorbar(lvta_m,lvta_s,'capsize',0,'color',sem_color )  %[198/255 226/255 238/255] rose [255/255 200/255 200/255]  [200/255 245/255 238/255]
%     plot(lvta_m,'k-','linewidth',1)
%     set(gca,'ytick',[-1 0 1 2])
%     plot([(500) (2499)], [(-.5) (-.5)],'b-','linewidth',1)
%     if context == 1
%         ylim([-1 2])
%     elseif context == 2
%         ylim([-1 3])    
%     else 
%         ylim([-1 2])
%     end
%     xlim([0 4000])
%     %axis off
%     set(gca, 'xcolor','none')
%     if context==2
%         plot([(2400) (2499)], [(-.6) (-.6)],'r-','linewidth',1)
%     end
% 
% end
% 


%%
% determining percentile
X = 100;  % number of seconds to compare for making percentile
percentile_ = .01/40;
len_mean = length(mean_shuffle)/X;  % size of new data array
p_high_value = 100 - percentile_;
p_low_value = 0 + percentile_;

context = 5;
temp = nan(context,len_mean,n_shuffles);
perct_low = nan(5,len_mean);
perct_high = nan(5,len_mean);

for context=1:5
    for k = 1:n_shuffles
        temp(context,:,k) = array_mean(mean_shuffle(k,context,:),X);
    end
    
    for len = 1:len_mean
        perct_low(context,len) = prctile(temp(context,len,:),p_low_value);
        perct_high(context,len) = prctile(temp(context,len,:),p_high_value);
    end
end

%% for paper figure
% plot the shuffled data
%figure(30), clf, hold on, 
set(gcf,'color','white')
n=4500;
ds = 10;  % downsample factor
a = [1  11 22 43 64];
b = [10 20 42 63 84];
bluebar_y = -.9;

for context=1:5 %1:5
    figure(21+context), clf, hold on, set(gcf, 'color','white')
    set(gca,'ytick',[-1 0 1 2])
    ylim([-1 3])
    %ylim([axis_label(1) axis_label(2)])
    xlim([0 4500/ds])
    %axis off
    set(gca, 'xcolor','none')
    
    % significance
    lvta_m = squeeze(nanmean(nanmean(mvta_gctones(:,a(context):b(context),1:n),2),1));  
    lvta_m_X = array_mean(lvta_m(1:n),X);
    yy2 = ones(1,length(lvta_m_X))-1.8;
    xx2 = linspace(1+X/2,length(lvta_m)-X/2,length(lvta_m_X));
    
    for len=1:length(lvta_m_X)  % for each 'unit of significance analyzed'
        if lvta_m_X(len) < perct_low(context,len) || lvta_m_X(len) > perct_high(context,len)
        else
            xx2(len) = NaN;
        end
        
    end
    xx2 = xx2/ds;
    %plot(xx2,yy2,'k*')
    
    % plot significance in bars
    xx2_ind = find(isnan(xx2')==0);   % find all non-NaN values of xx2
    xx2_nonan = xx2(xx2_ind);         
    yy2_nonan = yy2(xx2_ind);
    
    for x1 = 1:length(xx2_nonan)      % for each bin that is significant
        area_x = [xx2_nonan(x1)-X/2/ds xx2_nonan(x1)+X/2/ds];   % Area x values = equidistant from calculated values
        area_y = [2 2];                                   %%%% change y values as necessary
        area_y2 = [-1 -1];        
        area(area_x, area_y, 'facecolor', [.7 .7 .7], 'linestyle', 'none')
        area(area_x, area_y2, 'facecolor', [.7 .7 .7], 'linestyle', 'none')
    end

    lvta_m = squeeze(nanmean(nanmean(mvta_gctones(:,a(context):b(context),1:ds:n),2),1));
    lvta_s = squeeze(nanstd(nanmean(mvta_gctones(:,a(context):b(context),1:ds:n),2),[],1));
    errorbar(lvta_m,lvta_s,'capsize',0,'color',sem_color)  %[198/255 226/255 238/255] rose [255/255 200/255 200/255]  [200/255 245/255 238/255]
    plot(lvta_m,'k-','linewidth',1)
    set(gca,'ytick',[-1 0 1 2])
    plot([(500/ds) (2499/ds)], [(bluebar_y) (bluebar_y)],'b-','linewidth',1)
    if context==2
        plot([(2400/ds) (2499/ds)], [(bluebar_y-.1) (bluebar_y-.1)],'r-','linewidth',2)
    end
    
    set(gca,'xtick', [500 1500 2500 3500 4500]/ds)
    set(gca, 'xticklabel', [0 10 20 30 40]/ds)
    set(gca, 'fontsize', 15)
    xlim([0 4000/ds])
    
    set(gca, 'xtick', [])
    set(gca, 'xcolor', 'white')
    
end



function [] = plotGcampTraces(mvta_gctones, l_color, fignum)
%% plotting
figure(fignum), clf, hold on
set(gcf,'color','white')
xlim([0 12000])
ylim([-1.5 13])

% plot traces
fi = mvta_gctones; y=0; x=200; % y is offset top down; x is left-right
pp(fi,1,10,2.7*x,11.5+y,0, l_color)
pp(fi,11,20,2.7*x,8.1+y,1, l_color)
pp(fi,22,42,2.7*x,5.1+y,0, l_color)
pp(fi,43,63,2.7*x,2.1+y,0, l_color)
pp(fi,64,84,2.7*x,0+y,0, l_color)


end

function [] = pp(mvta_gctones,a,b,x,y,fc, l_color)
n = 4000;  % length of trace
xx = 1:n; xx=xx+x;
hold on;
lvta_m = squeeze(nanmean(nanmean(mvta_gctones(:,a:b,1:n),2),1));
lvta_s = squeeze(nanmean(nanstd(mvta_gctones(:,a:b,1:n),[],2)./sqrt((b-a))));
errorbar(xx,lvta_m+y,lvta_s,'capsize',0,'color',l_color)
plot(xx,lvta_m+y,'k-','linewidth',2)
plot([(500+x) (2499+x)], [(-.5+y) (-.5+y)],'b-','linewidth',2)
xlim([0 5000])
axis off
if fc==1
    plot([(2400+x) (2499+x)], [(-.6+y) (-.6+y)],'r-','linewidth',5)
end

    
end

end

