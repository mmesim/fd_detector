%2-D color plot
%Amplitues Vs Easting-Northing 
%--------------------------------------------------------------------------
%% First find the best depth and origin time, then grab X-Y and the amplitudes
clear; clc;close all;

load figure_07.mat maxgrid all

%convert to utm
[xall,yall,~]=deg2utm(all(:,1),all(:,2));
[xwell,ywell,~]=deg2utm(38.5, -112.887);
all=[xall-xwell yall-ywell all(:,3:5)];

best_orig=all(maxgrid,4);
best_depth=all(maxgrid,3);

new_all=all(all(:,3)==best_depth & all(:,4)==best_orig,:);


%create a mesh plot
x=new_all(:,1); y=new_all(:,2); z=new_all(:,5);
[xx,yy]=meshgrid(min(x):1:max(x), min(y):1:max(y));
zz=griddata(x,y,z,xx,yy,'v4');

%% Start doing Figure
%-----------------------------------------------------
%Maximum Amplitude at X - Y
figure
surf(xx,yy,zz,'LineStyle','none')
view([0 90])
colormap(parula)
xlabel('Easting [m]')
ylabel('Northing [m]')
set(gca,'FontSize',14)
xlim([min(x) 400])
ylim([min(y) max(y)])
colorbar
hold on
%plot: Longitude, Latitude, amplitude, marker size, marker type, color, color
h=scatter3(all(maxgrid,1),all(maxgrid,2),all(maxgrid,5),150,'h','MarkerEdgeColor','k','MarkerFaceColor',[0.55 0.55 0.55]);
 

