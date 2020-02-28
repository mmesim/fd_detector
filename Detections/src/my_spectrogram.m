function [amp,t1]=my_spectrogram(norm_win,win,overlap,header,y,f1,f2)
%function to 
%01. calculate spectrograms for each station
%02. do normalization
%03. do flattening (sums the power for given frequency range)
%04. returns time series (amp-t)
% Input :
% win: window for fft
% ovelap: overlaping window
% header: header of the selected component
% y: Radial or Tangential component 
% f1: lower cut off frequency
% f2: higher cut off frequncy
% Output:
%amp: summed normaziled power for each station
% t: time
%-------------------------------------------------------------------

%Parameters 
win=round(win./header(1).DELTA); %window from seconds to samples
overlap=round(overlap./header(1).DELTA); %overlap from seconds to samples
%normalization window 
time=norm_win/header(1).DELTA;
% length of parfor
N=length(y);
% sampling rate
sps=1./header(1).DELTA;
%------------------------------------------------------
parfor i=1:N  %change it to parfor
%01. do spectrograms
[~,w,t,ps]=spectrogram(y{1,i},hamming(win),overlap,256,sps);
%convert ps from power to db  
psdb=pow2db(ps);

%02. do normalization
%set step in samples
mstep=floor((2*time-win)./win);
[~,n]=size(psdb);

%grab indices for given frequency range
ind=find(w(:,1)>=f1 & w(:,1)<=f2);

%loop through each frequency and then time window
for ii=ind(1):ind(end)
    temp=psdb(ii,:);
    for j=1:n-mstep
    mnorm=median(temp(1,j:j+mstep)); %normalize by median
    psdb(ii,j)=temp(1,j)./mnorm; %replace the original array
    end
    % Fix last window
    mnorm=median(temp(1,j:end));
    psdb(ii,j:end)=temp(1,j:end)./mnorm;
end
%03. do flatening
amp{1,i}=sum(psdb(ind,:))./length(ind);
t1{1,i}=t;

end
t1=t1{1,1};
end
