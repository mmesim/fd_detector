%2-D color plot
%Amplitues Vs Easting-Northing 
%--------------------------------------------------------------------------
%% First find the best depth and origin time, then grab X-Y and the amplitudes
clear; clc;close all;

load figure_07.mat maxgrid all

best=all(maxgrid,:);

[xbest,ybest]=deg2utm(best(1,1),best(1,2));

all=all(all(:,1)==best(1,1) & all(:,4)==best(1,4),:);

%convert to utm
[xall,yall,~]=deg2utm(all(:,1),all(:,2));
[xwell,ywell,~]=deg2utm(38.5, -112.887);
 
new_all=[xall-xwell yall-ywell all(:,3:5)];

%% Start doing Figure
%------------------------------------
%create a mesh plot
x=new_all(:,1); y=new_all(:,3).*1000; z=new_all(:,5);
[xx,yy]=meshgrid(min(x):1:max(x), min(y):5:max(y));
zz=griddata(x,y,z,xx,yy,'v4');

%% Start doing Figure
%-----------------------------------------------------
%Maximum Amplitude at X - Y
figure
surf(xx,yy,zz,'LineStyle','none')
view([0 90])
colormap(parula)
xlabel('Easting [m]')
ylabel('Depth [m]')
set(gca,'FontSize',14,'YDir','Reverse')
xlim([min(x) 400])
ylim([min(y) max(y)])
colorbar
hold on
%plot: Longitude, Latitude, amplitude, marker size, marker type, color, color
h=scatter3(xbest-xwell,best(1,3).*1000,best(1,4),150,'h','MarkerEdgeColor','k','MarkerFaceColor',[0.55 0.55 0.55]);
 
%--------------------------------------
% %Maximum Amplitude at X - Z
% figure
% scatter3(new_all(:,1),new_all(:,2),new_all(:,3).*1000,500,new_all(:,5),'filled','Marker','s')
% 
% colormap(jet)
% xlabel('Easting [m]')
% zlabel('Depth [m]')
% set(gca,'FontSize',14,'ZDir','Reverse')
% % xlim([min(new_all(:,1)) max(new_all(:,1))])
% % ylim([min(new_all(:,3)).*1000 max(new_all(:,3)).*1000])
%colorbar
% hold on
% %plot: Longitude, Latitude, amplitude, marker size, marker type, color, color
% h=scatter3(all(maxgrid,1),all(maxgrid,2),all(maxgrid,3).*1000,150,'h','MarkerEdgeColor','k','MarkerFaceColor','y');
%  
% 
