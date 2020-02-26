function  [detections]=my_detections(trace,det_win,thres,time_thres,overlap,t) 
%Declare detections when amlitude>MD+(thres*MAD)

network_trace=trace';
my_win=floor(det_win/overlap);
%Preallocate memory
N=length(network_trace(:,1))-my_win;
ind=cell(N,1);
%------- Start Detections -------------------------------------------------
for i=1:N  %change to parfor
my_window=network_trace(i:my_win+i,1);
MAD=mad(my_window,1); % Median absolute deviation
MD=median(my_window); % median 

threshold=MD+(thres*MAD); % detection threshold (amplitude)

index=find(my_window(:,1)>=threshold); % Apply detection threshold  

ind{i,1}=[index+i ones(length(index),1)*MAD ones(length(index),1)*MD my_window(index)];

end
%--------------------------------------------------------------------------
% Group detections -- time threshold defined by user
% See time_thres variable in parameter.m
%---------- If there are no detectios exit the program----------------------
table=cell2mat(ind);
if length(table)<1 
    delete(gcp)
    fprintf('Shutting down - Elapsed time %6.2f minutes... \n',toc/60) %stop timer
     msg='No detections! Change threshold or adjust sliding window!';
     error(msg)
end
%--------------------------------------------------------------------------
%find unique values and calculate N time MAD
table=[table (table(:,4)-table(:,3))./table(:,2)];
[unq,~]=unique(table(:,1));
%------------------------------------------------------------
%convert to sec and group detections
det=unq(1:end-1);
det=t(det);
j=1;
for ii=1:length(det)-1
if det(ii+1)-det(ii)<=time_thres
    temp(j)=ii+1;
    j=j+1;
end
end
ind2=setdiff(1:length(det)-1,temp);

%Final vector with detections in seconds
detections=det(ind2)';


end