function  y_cut=my_cut_waveforms(mwindow,tt_time,origin,y,t,det)
%cut waverforms at arrival time
Nsta=length(y(:,1));
%Nsta=length(y);

for k=1:Nsta
    if isnan(tt_time(1,k))==1 
    ind=1:99;
    else 
    %Cut waveforms at theoretical P-arrival times
    start=det-origin+tt_time(1,k);
    stop=start+mwindow;  
    ind=find(t(1,:)>=start & t(1,:)<=stop);    
    end
%Save to an array
%y_cut(:,k)=y{1,k}(ind(1:99));
y_cut(k,:)=y(k,ind(1:99));

end % end of for loop
end % end of function