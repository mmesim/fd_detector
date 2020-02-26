function []=my_figure(all,loc,k)
%2-D color plot for each detection
%Origin time is fixed
%--------------------------------------------------------------------------
mkdir OUTPUT
filename1=sprintf('event_%03d.fig',k);
%Fixed origin time
a=all(all(:,4)==loc(:,4),:);
%-----------------------------------------------------
f1=figure;
scatter3(a(:,1),a(:,2),a(:,3),500,a(:,5),'filled','Marker','s')
set(gca,'FontSize',14,'ZDir','Reverse')
colormap(jet)
grid on
ylabel('Longitude (E^o)')
xlabel('Latitude (N^o)')
zlabel('Depth km')
title('')
hold on
scatter3(loc(:,1),loc(:,2),loc(:,3),300,'h','MarkerEdgeColor','k','MarkerFaceColor','y');


saveas(f1,filename1,'fig');
movefile(filename1,'OUTPUT/');
close all
end