function []=my_catalog_multiple(detections,headerE,loc,fout)
%Output catalog using header information and datetime function
%--------------------------------------------------------------------------
time=datetime(headerE(1).KZTIME,'Format','HH:mm:ss.SSS'); %header time
t=time+seconds(detections)-seconds(loc(:,4)); %time in seconds since the beginning 
%---------------------------------------------------------
%output catalog
fprintf(fout,'%s %s %7.4f %9.4f %6.2f %3.1f \n', headerE(1).KZDATE ,char(t), loc(:,1),loc(:,2),loc(:,3));
fprintf(fout,'\n');
end