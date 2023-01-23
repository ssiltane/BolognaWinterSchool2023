% Plot example of tomosynthetic slices in limited-angle tomography.
% (Tomosynthesis is the same thing as unfiltered backprojection.)
%
% Samuli Siltanen July 2022

% Construct phantom with two disc targets
N = 1024;
ph = zeros(N,N);
[X,Y] = meshgrid(linspace(0,1,N));
R1 = .18;
x1 = .3;
y1 = .3;
ind1 = abs(X+1i*Y-(x1+1i*y1))<R1;
ph(ind1) = 1;
R2 = .14;
x2 = .75;
y2 = .8;
ind2 = abs(X+1i*Y-(x2+1i*y2))<R2;
ph(ind2) = 1;
R3 = .03;
x3 = .75;
y3 = .25;
ind3 = abs(X+1i*Y-(x3+1i*y3))<R3;
ph(ind3) = 1;
ph8 = uint8(255*ph);


% Calculate unfiltered back-projection
angle_of_view = 4;
angvec = linspace(-angle_of_view/2,angle_of_view/2,128);
sgram = radon(ph,angvec);
BP = iradon(sgram,angvec,'none');
BP = BP(2:(end-1),2:(end-1));
BP = BP/max(abs(BP(:)));
BP8 = uint8(255*BP);

% Take a look
figure(1)
clf
subplot(1,2,1)
imshow(ph8)
axis square
axis off
subplot(1,2,2)
imshow(BP8)
axis square
axis off


% 
% %% Plot selected rows of the phantoms
% 
% lwidth = 4;
% lwidth_ax = .5;
% 
% figure(2)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],ph(end/4,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 
% 
% figure(3)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],ph(end/2,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 
% 
% 
% figure(4)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],ph(3*end/4,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 
% 
% 
% 
% figure(5)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],BP(end/4,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 
% 
% figure(6)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],BP(end/2,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 
% 
% figure(7)
% clf
% % Horizontal axis
% plot([-300 -50],[0 0],'k','linewidth',lwidth_ax)
% hold on
% plot([0 1024],[0 0],'k','linewidth',lwidth_ax)
% plot([1:1024],BP(3*end/4,:),'k','linewidth',lwidth)
% axis off
% pbaspect([8 1 1])
% axis([-300 1024 -.1 1.1])
% 


