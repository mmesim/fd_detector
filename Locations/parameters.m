% Parameter file  backprojection           %
%                                          %
% ---------- M. Mesimeri 02/2020 --------- %

%path to waveforms
mydata='example';
%-------------------------------------------------------------------------
% Parallel settings
%workers=12;                 %Set number of cores to work on a local machine
%--------------------------------------------------------------------------
%Cut waveforms [in seconds]
start=0;     %time before theoretical pick                     
stop=1;      %time after theoretical pick
%--------------------------------------------------------------------------
%Define grid points for plotting only
%travel times should be calculated using arrival_times.m
%Minimum  - Maximum - Latitude
minlat=38.495; maxlat=38.505;  inclat=0.001;
%Minimum  - Maximum - Longitude 
minlon=-112.89000; maxlon=-112.8800; inclon=0.001;
%Minimum - Maximum - Depth [km]
mindepth=0.0; maxdepth=3.0; incdepth=0.3;
%Minimum - Maximum - Origin time [sec] [time before the detection]
minorigin=0; maxorigin=1; incorigin=0.01;