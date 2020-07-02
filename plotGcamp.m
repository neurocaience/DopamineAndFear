function [] = plotGcamp(master_gcamp_tones, fign, colorm)
% Lili X. Cai, 3/5/2020

%l = length you want matrix

fig14 = figure(fign); clf, set(gcf, 'color', 'white'), axis off; hold on;
%%
clf
x1 = .05; 
y1 = .87; 
xd = .08; %.025;
yd = .1;
yd_ext = .21; 
xd_gcamp = .8; %.35;
xd_g = x1 + xd - .04; %.035; 
%c1 = -1; ch = 1;
cl = -2; ch = 2;

%
%l = 60;
subplot('position', [x1+xd_g y1 xd_gcamp yd])
imagesc(master_gcamp_tones(1:10,:)); axis off, colormap(colorm); caxis([cl ch])
freezeColors;
hold on; 
    %plot([500 500], [0 84], 'k--','linewidth', 2)
    %plot([2500 2500], [0 84], 'k--', 'linewidth',2)

subplot('position', [x1+xd_g y1-.12 xd_gcamp yd])
imagesc(master_gcamp_tones(11:20,:)); axis off, colormap(colorm); caxis([cl ch])
freezeColors;
hold on; 
   %plot([500 500], [0 84], 'k--','linewidth', 2)
    %plot([2500 2500], [0 84], 'k--', 'linewidth',2)
    %plot([2400 2500], [0 84], 'r-', 'linewidth',1)


subplot('position', [x1+xd_g y1-.35 xd_gcamp yd_ext])
imagesc(master_gcamp_tones(22:42,:)); axis off, colormap(colorm); caxis([cl ch])
freezeColors;
hold on; 
    %plot([500 500], [0 84], 'k--','linewidth', 2)
    %plot([2500 2500], [0 84], 'k--', 'linewidth',2)

subplot('position', [x1+xd_g y1-.58 xd_gcamp yd_ext])
imagesc(master_gcamp_tones(43:63,:)); axis off, colormap(colorm); caxis([cl ch])
freezeColors;
hold on; 
    %plot([500 500], [0 84], 'k--','linewidth', 2)
    %plot([2500 2500], [0 84], 'k--', 'linewidth',2)

subplot('position', [x1+xd_g y1-.81 xd_gcamp yd_ext])
imagesc(master_gcamp_tones(64:84,:)); axis off, colormap(colorm); caxis([cl ch])
freezeColors;
hold on; 

% plot tone duration -------------------------------------
length_mat = length(master_gcamp_tones);
yloc = [-.01 -.13 -.36 -.59 -.82]; yloc = yloc + y1;
x = zeros(1,length_mat);
x(1000:3000) = 1;

for yy = 1:length(yloc)
    subplot('position', [x1+xd_g yloc(yy) xd_gcamp .01])

    imagesc(x); axis off; hold on
    newmap = buildmap('wp');  % a45e
    colormap(newmap)
    freezeColors;
end

    subplot('position', [x1+xd_g yloc(2)-.01 xd_gcamp .01])
    x = zeros(1, length_mat);
    x(2900:3000) = 1;
    imagesc(x); axis off, hold on
    newmap = buildmap('wr');  % a45e
    colormap(newmap)    
    freezeColors;

%     subplot('position', [x1+xd_g y1-.13 xd_gcamp .005])
%     x = zeros(1,132);
%     x(10:30) = 1;
%     imagesc(x); axis off, colormap(parula); hold on
%     freezeColors;

%%
end