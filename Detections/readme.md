## Parameter File

**mydata**= string, full path to waveforms. The directory should contain all the waveforms in SAC format (2hr blocks). 

**workers**: integer, define the number of cores for parallel processing. 

**type**: string, choose between 'low', 'high', 'bandpass' for filtering, for high or low pass set the hcorner equal to lcorner and vice versa.

**co**: set lower and higher corner frequency.

**rlat,rlon**: Reference point, center of the array or whatever. This point is used to rotate the waveforms.

**norm_win**: Spectrogran normalization window        

**win**:Window for fft [in seconds]             

**overlap**: overlapping window for fft [in seconds] 

**f1, f2**: lower and higher cut off to sum power for each spectrogram             

**det_win**: Define the detection window [in seconds]; 

**thres**:Define the detection threshold (median+(thres X MAD))

**time_thres**: Define time threshold to group detections [in seconds]

**out_win**: Define Window around the detection [in seconds]. Used to plot waveforms. 

## Execute
Edit the parameter file. Double check that the path is correct. Type "array_detection" in the command window.

parameter.m, array_detection.m & src should be in the same directory. Waveforms can be anywhere.

Save output and use it for locating the detections. [To test use the waveforms in example directory, should work].
