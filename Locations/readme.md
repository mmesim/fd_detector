This is a two step process:

(1) Calculate travel times using an 1D velocity model

**travel_times** : travel_times.m

**input**: velocity model (similar to velocity.mat).

**output**: data.mat contains tt_table and grid arrays

TTBox : A MatLab Toolbox for the computation of 1D Teleseismic Travel Times https://doi.org/10.1785/gssrl.75.6.726

(2) **Backprojection**: backprojection_location.m

Input: 

data.mat (output from travel_times.m) 

detections.mat (should contain: detections, env1, env2, headerE, headerN, t1, t2, trace output variables from detection)

Output:

(i) Catalog with locations

(ii) 3D figure saved as .png (Latitude-Longitude-Depth)


Written in Matlab

Author: Maria Mesimeri
