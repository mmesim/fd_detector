function  [ynew,tnew]=my_precut_waveforms(y,t,det)
%Cut waveforms around detection time to shorten array
start=det-4;
stop=det+4;  
ind=find(t(1,:)>=start & t(1,:)<=stop);    

%Save to an array
ynew=cell2mat(y');
ynew=ynew(:,ind);
tnew=t(ind);
end % end of function