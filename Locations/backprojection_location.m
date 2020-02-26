%          Backprojection to locate seismic events              %
%               Using envelopes of summed power                 % 
%                  Output from FD_detector                      %     
%---------------------------------------------------------------%
%               University of Utah seismograph Stations         %
%                      maria.mesimeri@utah.edu                  %
% ------------------------- M.Mesimeri 02/202  ---------------  %
clear;clc; close all ;tic %start timer

%% 00.Setup
parameters %load parameter file
%parpool('local',workers); %Start parallel pool
mydir=pwd; pdir=sprintf('%s/src/',pwd); % get working directory path
addpath(genpath(pdir));  %add src to path (includes taup and readsac)
%--------------------------------------------------------------------------
%% 01. Load data (Mat file -- output from FD_detector)
disp('Loading files..')
load(sprintf('%s/detections.mat',mydata)) % detections output
load daca.mat tt_table grid %travel times

k=1;

%% 02. Create beam for each grid point
disp('Beam for each Grid point..')
beam=my_beam(start,stop,tt_table,grid,env1,t1,detections(k,1));

%% 03. Measure amplitude and energy
disp('Amplitudes..')
[ampls, all, maxgrid]=my_ampls(beam,grid);

%% 04. Output: Best Location
disp('Catalog..')
my_catalog(detections(k,1),headerE,grid(maxgrid,:))

%% 05. Output #1 Figures
disp('Figures..')
my_figure(all,grid(maxgrid,:),k)

%% 06. Shutdown parallel pool
%delete(gcp)
fprintf('Elapsed time %6.2f minutes... \n',toc/60) %stop timer

