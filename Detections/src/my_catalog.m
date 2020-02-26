function []=my_catalog(detections,headerE,K)
%Output catalog using header information and datetime function
%--------------------------------------------------------------------------
time=datetime(headerE(1).KZTIME,'Format','HH:mm:ss.SSS'); %header time
t=time+seconds(detections(:,1)); %time in seconds since the beginning 
%---------------------------------------------------------
%output catalog
fout=fopen('detections.txt','w');
for i=1:length(t)
    
fprintf(fout,'%s %s %6.3f \n', headerE(1).KZDATE ,char(t(i)), K(i,1));
end
fclose(fout);

end