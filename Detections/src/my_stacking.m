function [trace,env1,env2]=my_stacking(amp1,amp2)
%function to stack envelopes
%returns stacked envelope trace 
%ready for sta/lta
%--------------------------------------------------------------------------

%preallocate memory
N=length(amp1);
env1=cell(1,N);
env2=cell(1,N);

parfor i=1:N  %change to parfor
%Vector 
temp1=amp1{1,i};
temp2=amp2{1,i};
%Remove mean
temp1=temp1-mean(temp1);
temp2=temp2-mean(temp2);
%Envelopes- return normalized envelope
env1{1,i}=my_envelope(temp1);
env2{1,i}=my_envelope(temp2);
end

%Stack envelopes and normalize
trace1=sum(cell2mat(env1'))./N;
trace2=sum(cell2mat(env2'))./N;

%Sum components and normalize
trace=(trace1+trace2)./2;
end
