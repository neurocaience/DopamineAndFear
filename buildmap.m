function [cmap]=buildmap(colors)
% [cmap]=buildcmap(colors)
%
% This function can be used to build your own custom colormaps. Imagine if
% you want to display rainfall distribution map. You want a colormap which
% ideally brings rainfall in mind, which is not achiveved by colormaps such
% as winter, cool or jet and such. A gradient of white to blue will do the
% task, but you might also use a more complex gradient (such as
% white+blue+red or colors='wbr'). This function can be use to build any
% colormap using main colors rgbcmyk. In image processing, w (white) can be
% used as the first color so that in the output, the background (usually
% with 0 values) appears white. In the example of rainfall map, 'wb' will
% produce a rainfall density map where the background (if its DN values are
% 0) will appear as white.
%
% Inputs:
%  colors: string (char) of color codes, any sequence of rgbcmywk
%  representing different colors (such as 'b' for blue) is acceptable. If a
%  gradient of white to blue is needed, colors would be 'wb'; a rainbow of
%  white+blue+red+green would be 'wbrg'.
%
% Example:
%  [cmap]=buildcmap('wygbr');
% %try the output cmap:
% im=imread('cameraman.tif');
% imshow(im), colorbar
% colormap(cmap) %will use the output colormap
%
% First version: 14 Feb. 2013
% sohrabinia.m@gmail.com
%--------------------------------------------------------------------------
if nargin<1
    colors='wrgbcmyk';
end
if ~ischar(colors)
    error(['Error! colors must be a variable of type char with '...
        'color-names, such as ''r'', ''g'', etc., '...
        'type ''help buildcmap'' for more info']);
end
ncolors=length(colors)-1;
bins=round(255/ncolors);
% diff1=255-bins*ncolors;
vec=zeros(300,3);
switch colors(1)
    case 'w'
        vec(1,:)=1;
    case 'r'
        vec(1,:)=[1 0 0];
    case 'g'
        vec(1,:)=[0 1 0];
    case 'b'
        %vec(1,:)=[0 0 1];
        vec(1,:) = [30/255 144/255 1];
    case 'p'
        vec(1,:)=[0 0 1];      
    case 'c'
        vec(1,:)=[0 1 1];
    case 'm'
        vec(1,:)=[1 0 1];
    case 'y'
        vec(1,:)=[1 1 0];
    case 'k'
        vec(1,:)=[0 0 0];
    case 'a'
        gr = .9;
        vec(1,:)=[gr gr gr];   %gray
    case 'd'
        vec(1,:)=[0 0 139/255]; %dark blue
    case '1'
        vec(1,:)=[30/255 144/255 255/255]; %dark blue  
    case '2'
        vec(1,:)=col(61, 89, 171); %dark blue         
    case '3'
        vec(1,:)=col(159, 182, 205); %slate blue   
    case '5'
        vec(1,:)=col(176, 23, 31); %dark red         
    case '4'
        vec(1,:)=col(255, 106, 106); %slate red           
    case 'e'
        vec(1,:)=col(139, 0, 0); %dark red            
end
for i=1:ncolors
 beG=(i-1)*bins+1;
 enD=i*bins+1; %beG,enD
 switch colors(i+1)
     case 'w'
         vec(beG:enD,1)=linspace(vec(beG,1),1,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),1,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),1,bins+1)';%colors(i+1),beG,enD,
     case 'r'
         vec(beG:enD,1)=linspace(vec(beG,1),1,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),0,bins+1)';%colors(i+1),beG,enD
     case 'g'
         vec(beG:enD,1)=linspace(vec(beG,1),0,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),1,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),0,bins+1)';%colors(i+1),beG,enD
     case 'b'         
         vec(beG:enD,1)=linspace(vec(beG,1),135/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),206/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),250/255,bins+1)';%colors(i+1),beG,enD
     case 'p'         
         vec(beG:enD,1)=linspace(vec(beG,1),0,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),1,bins+1)';%colors(i+1),beG,enD         
     case 'c'
         vec(beG:enD,1)=linspace(vec(beG,1),0,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),1,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),1,bins+1)';%colors(i+1),beG,enD
     case 'm'
         vec(beG:enD,1)=linspace(vec(beG,1),1,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),1,bins+1)';
     case 'y'
         vec(beG:enD,1)=linspace(vec(beG,1),1,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),1,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),0,bins+1)';
     case 'k'
         vec(beG:enD,1)=linspace(vec(beG,1),0,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),0,bins+1)';
     case 'a'
         gr = .9; % gray
         vec(beG:enD,1)=linspace(vec(beG,1),gr,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),gr,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),gr,bins+1)';     
     case 'd'
         % dark blue
         vec(beG:enD,1)=linspace(vec(beG,1),0,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),139/255,bins+1)';            
     case '1'
         vec(beG:enD,1)=linspace(vec(beG,1),30/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),144/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),255/255,bins+1)';         
     case '2'
         vec(beG:enD,1)=linspace(vec(beG,1),61/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),89/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),171/255,bins+1)';    
     case '3'
         vec(beG:enD,1)=linspace(vec(beG,1),159/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),182/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),205/255,bins+1)';   
     case '5'
         vec(beG:enD,1)=linspace(vec(beG,1),176/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),23/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),31/255,bins+1)';         
     case '4'
         vec(beG:enD,1)=linspace(vec(beG,1),205/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),193/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),197/255,bins+1)';    
     case 'e'
         vec(beG:enD,1)=linspace(vec(beG,1),139/255,bins+1)';
         vec(beG:enD,2)=linspace(vec(beG,2),0/255,bins+1)';
         vec(beG:enD,3)=linspace(vec(beG,3),0/255,bins+1)';            
 end
end
cmap=vec(1:bins*ncolors,:);

    function rgb = col(a,b,c)
        rgb = [a/255 b/255 c/255];
    end
end %end of buildcmap