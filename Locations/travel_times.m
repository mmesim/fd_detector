clear;clc; tic %start timer
%% Paramaters
%path to waveforms
mydata='example';
%-------------------------------------------------------------------------
% Parallel settings
workers=24;                 %Set number of cores to work on a local machine
%Define grid points
%Minimum  - Maximum - Latitude
minlat=38.497; maxlat=38.503;  inclat=0.00025;
%Minimum  - Maximum - Longitude 
minlon=-112.8900; maxlon=-112.884; inclon=0.00025;
%Minimum - Maximum - Depth [km]
mindepth=0.0; maxdepth=3.0; incdepth=0.2;
%Minimum - Maximum - Origin time [sec]
minorig=0.0; maxorig=1.0; incorig=0.01;
%--------------------------------------------------------------------------
%Define phase 
pha='S';   %Case sensitive
%--------------------------------------------------------------------------
%% 00.Setup
parpool('local',workers); %Start parallel pool
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir));  %add src to path (includes ttbox and readsac)
%--------------------------------------------------------------------------
%% 01. Load data (.mat file output from FD_detector)
disp('Loading files..')
load(sprintf('%s/detections.mat',mydata))
%% Load Velocity model
load velocity_model.mat 

%% 02. Calculate travel times
disp('Calculate travel times...')
[tt_table,grid]=make_tt_table(pha,model,minlat, maxlat,inclat, minlon, maxlon,inclon, mindepth, maxdepth, incdepth,minorig,maxorig,incorig,headerE);

save  data.mat tt_table grid

delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer

