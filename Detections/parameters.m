%Parameter file for array_detetion code                                   %
%                                                                         % 
% --------------- M.Mesimeri 10/2019  finalized 01/2020 -------------------
%               University of Utah seismograph Stations                   %
%                      maria.mesimeri@utah.edu                            %
%--------------------------------------------------------------------------
%path to waveforms
mydata='example'; 
%--------------------------------------------------------------------------
% Parallel settings
workers=2;         %Set number of cores to work on a local machine
%-------------- Filtering parameters --------------------------------------
type='high';        %'low', 'high', 'bandpass'
co=1;               %low or high corner frequency (high or low pass)
%co=[1;10];         %low-high corner frequency for bandpass
%--------------------------------------------------------------------------
%Reference point 
rlat=38.5; rlon=-112.887;
%--------------------------------------------------------------------------
%Spectrogram parameters 
norm_win=10;       %set window for normalization
win=0.2;            %set window for fft in sec 
overlap=0.19;       %set overlaping window in sec
f1=10;              %lower frequency cut off to sum power
f2=30;              %higher frequency cut off to sum power
%--------------------------------------------------------------------------
%Detection parameters
det_win=10;
thres=10;
time_thres=1;
%Output file : Define window around the detection
out_win=2;          %Window around the detection in sec 