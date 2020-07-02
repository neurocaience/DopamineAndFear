%RED to blue colormap
function map = cmap_blue2black(varargin)
rmap = [0:.01:1]'; omap = ones(size(rmap)); 
map  = [rmap rmap rmap; flipud(rmap) flipud(rmap) flipud(omap)];

%Alternate map:

%rmap = [0:.01:1]'; omap = ones(size(rmap)); 
%bmap1 = linspace(.4, 1, 101)'; 
%bmap2 = linspace(.5, 1, 101)';
%bmap3 = linspace(.93, 1, 101)';
%map  = [rmap rmap rmap; flipud(bmap1) flipud(bmap2) flipud(bmap3)];

end
%map = colormap_helper(map, varargin{:});