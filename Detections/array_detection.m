% Package to detect induced earthquakes using a large N-array             %
%                                                                         %
% --------------- M.Mesimeri 10/2019  -revised 02/2020 -------------------%
%               University of Utah seismograph Stations                   %
%                      maria.mesimeri@utah.edu                            %
%--------------------------------------------------------------------------
clear;clc;close all; tic %start timer

%% 00.Setup
parameters %load parameter file
parpool('local',workers); %Start parallel pool
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir)); %add all *.m scripts to path
%--------------------------------------------------------------------------
%% 01. Load data (Sac files)
disp('Loading files..')
[yN,yE,headerN,headerE]=my_loadfiles(mydata);

%% 02. Preprocess data 
disp('Preprocessing...')
[yN_proc,yE_proc]=my_preprocessing(yN,yE,headerE(1).DELTA,type,co);

%% 03. Rotate waveforms
disp('Rotate waveforms...')
[R,T]=my_rotation(headerE,rlat,rlon,yN_proc,yE_proc);

%% 04. Spectrograms
disp('Spectrograms ''R'' ...')
[amp1,t1]=my_spectrogram(norm_win,win,overlap,headerE,R,f1,f2);

disp('Spectrograms ''T'' ...')
[amp2,t2]=my_spectrogram(norm_win,win,overlap,headerE,T,f1,f2); 

%% 05. Stack Time Series
disp('Stacking..')
[trace,env1,env2]=my_stacking(amp1,amp2);

%% 06. Detections
disp('Detections..')
detections=my_detections(trace,det_win,thres,time_thres,overlap,t1);

%% 07. Output ##1 - Figures
K=my_output(headerE,detections, R,env1,trace,t1,out_win);

%% 08. Output ##2 - Catalog
disp('Output #2 - Catalog..')
my_catalog(detections,headerE,K)

%% 09. Shutdown parallel pool
delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer


