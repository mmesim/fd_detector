function   beam=my_beam(start,stop,tt_table,grid,y,t,det)
%Create a beam for each grid point using linear stacking
%--------------------------------------------------------------------------
%define window in samples
mwindow=stop-start;
%length of parfor
N=length(grid);
%N of stations to loop through
Nsta=length(y);


%Cut waveforms around detection
[ynew,tnew]=my_precut_waveforms(y,t,det);

%Loop through grid points and get beam
parfor i=1:N  %change it to parfor
%function to cut waveforms in time
y_cut=my_cut_waveforms(mwindow,tt_table(i,:),grid(i,4),ynew,tnew,det); 

%beam using Linear Stacking
beam(i,:)=sum(y_cut)./Nsta;
 
end%end of parfor 

end %end of function
