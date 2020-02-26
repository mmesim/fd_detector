function [K]=my_output(header,detections, R,env1,network_trace,t1,out_win)
%Output Figures for each detection
%(1) Image of envelopes 
%(2) Plot with waveforms
%(3) Plot with network trace
%Output asved_loc and save_wvf can be used later for beamforming
%--------------------------------------------------------------------------

%% Create Directories
mkdir WAVEFORMS
mkdir ENVELOPES
mkdir NETWORK_TRACE

stations=ones(length(header),1);
K=zeros(length(detections),1);
%% Sort Stations by station number
for i=1:length(header)
stations(i,1)=str2double(header(i).KSTNM);
end
[~,ind]=sort(stations);
%use ind to sort the waveforms by station number
y=R(1,ind);
env=env1(1,ind);
%% define arrays
env=cell2mat(env'); 
%y=cell2mat(y);
%% create plots : Processed waveforms,envelopes, and network trace
disp('Figures: Waveforms, Envelopes, and Network Trace..')
for k=1:length(detections)
fprintf('Figure: %03d out of %03d\n', k, length(detections)) 
if detections(k,1)-out_win >0 && detections(k,1)+out_win <t1(end)
ind=find(t1(1,:)>=floor(detections(k,1)-out_win) & t1(1,:)<=round(detections(k,1)+out_win));
env_new=env(:,ind);
%%--------     image envelopes --------------------------------------------
%--------------------------------------------------------------------------
f1=figure('visible','off');
filename1=sprintf('envelopes_%03d.eps',k);
image(env_new,'CDataMapping','scaled');
colormap(flipud(gray));
ticks=0:round(length(ind)/4):length(ind);
labels=ticks./100;
set(gca, 'XTick', ticks, 'XTickLabel', labels);
xlabel('Time [sec]','FontSize',16)
ylabel('Station ID','FontSize',16)
colorbar
set(gca,'YDir','normal')
saveas(f1,filename1,'eps');
movefile(filename1,'ENVELOPES/');
close all
%----------------------------------------------------------
% Plot waveforms -- loop through all available waveromfs
f2=figure('visible','off');
filename2=sprintf('waveforms_%03d.eps',k);
 for i=1:length(y(1,:))
temp=y{1,i}(floor((detections(k,1)-out_win)./header(1).DELTA):round((detections(k,1)+out_win)./header(1).DELTA),1);
wvf=temp./max(temp);
plot((1:length(wvf))*header(1).DELTA,wvf+i,'k');
hold on
end
hold off
xlim([0 length(wvf)*header(1).DELTA])
ylim([1 length(stations)])
xlabel('Time [sec]','FontSize',16)
ylabel('Station ID','FontSize',16)
saveas(f2,filename2,'eps');
movefile(filename2,'WAVEFORMS/');
close all
%-------------------------------------------------
% %% Network trace
f3=figure('visible','off');
filename3=sprintf('network_trace%03d.eps',k);
temp2=network_trace(ind);
K(k,1)=kurtosis(temp2);
plot((1:length(ind)), temp2,'k');
xlim([0 length(ind)])
ylim([min(temp2) max(temp2)])
ticks=0:round(length(ind)/4):length(ind);
labels=ticks./100;
set(gca, 'XTick', ticks, 'XTickLabel', labels);
xlabel('Time [sec]','FontSize',16)
ylabel('Stacked envelopes','FontSize',16)
%--------------------------------------------------
saveas(f3,filename3,'eps');
movefile(filename3,'NETWORK_TRACE/');
close all
clear env_new temp wvf temp2 ind
%------------------------------------------------
else
fprintf('Detection %03d out of bounds - Skip! \n', k )     
end % end of if
end %end N of detections

end