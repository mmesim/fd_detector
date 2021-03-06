function clrout=mkwriteclr(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14);
% mkwriteclr.......write piecewise polynomial model into .clr file
%
% call: clrout=mkwriteclr(clrin,pfad);
%       clrout=mkwriteclr(name,year,planet,rp,z,vp,vs,rho,qp,qs,dz,dname,pfad);
%
%       clrin: CLR structure as returned by MKREADCLR (see there for definition)
%       pfad: complete path and file name to store file.
%
%       name: model name [string]
%       planet:name of planet for which model is valid [string]
%       rp: radius of planet [km]
%       z: layer depth matrix
%          z is a n-by-2 matrix containing minimum and maximum depth of n layers
%          z(i,1) is the depth to the top of the i-th layer [km]
%          z(i,2) is the bottom of the i-th layer [km]
%       vp: P velocity layer polkynomial matrix
%           vp is a n-by-m matrix containing the coefficients of layer polynomials
%           on f layers. The highest degree polynomial is of degree m-1.
%           vp(i,:) are the coefficients of the i-th layer in km/s.
%           vp(i,1) is the constant term, vp(i,2) the coefficient of the linear term,
%           vp(i,3) the coefficient of the qudratic term etc.
%       vs: as vp, but for S velocity
%       rho: as vp, but for density
%       qp: as vp, but for dimensionless Qp factor
%       qs: as vp, but for dimensionless Qs factor
%       dz: n elements vector containing depths of ALL discontinuities (standard
%           and non-standard discontinuities!) in km
%           dz(i) is the depth to the i-th discontinuity [km]
%       dname: string matrix containing the names of all discontinuities
%              dname(i,:) is the name of the discontinuity at depth dz(i).
%
% result: clrout: the stored CLR structure.
%                 Having this as output may be nice in the many-arguments-form.
%
% This routine stores a velocity model consisting of several layers defined by
% polynomials in a .clr file.
% All numerical values are written in format %1.15e, which means full numeric
% resolution - it's too difficult for a program to decide how many digits 
% are significant.
%
% Martin Knapmeyer, 03.09.2003

% well, yes, I could have used varargin, but in this case it's easier without!

%%% construct empty dummy
clrout.tag=[];
clrout.name=[];
clrout.year=[];
clrout.planet=[];
clrout.rp=[];
clrout.lyrcnt=0;
clrout.layers=[];
clrout.conr=NaN; %[];
clrout.moho=NaN; %[];
clrout.d410=NaN; %[];
clrout.d520=NaN; %[];
clrout.d660=NaN; %[];
clrout.cmb=NaN; %[];
clrout.icb=NaN; %[];
clrout.dz=[];
clrout.dname=[];

%%% understand input
nin=nargin;
switch nin
   case {2}
        clrout=p1;
        pfad=p2;
   case {14}
        %%% construct clr structure from input data
        clrout=mkmat2clr(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13);
        pfad=p14;
   otherwise
      error('MKWRITECLR: wrong number of input arguments!');
end; % switch nin


%%%%%% save file

%%% open file
[fid,msg]=fopen(pfad,'w+');
if fid==-1
   error(['MKWRITECLR: ' msg]);
end; % if fid==-1

%%% write some heading comments
fprintf(fid,'// CLR file generated by MKWRITECLR %s\n',date);
fprintf(fid,'//\n');
fprintf(fid,'//\n');
fprintf(fid,'\n'); % empty line

%%% write General Information
fprintf(fid,'// General Information\n');
fprintf(fid,'\n'); % empty line
fprintf(fid,'!usertag %s\n',clrout.tag);
fprintf(fid,'!name %s\n',clrout.name);
fprintf(fid,'!planet !name %s\n',clrout.planet);
fprintf(fid,'!planet !radius %1.15e\n',clrout.rp);
fprintf(fid,'\n'); % empty line

%%% write Layer Information
fprintf(fid,'// Layer Information\n');
fprintf(fid,'\n'); % empty line

for indy=1:clrout.lyrcnt
    fprintf(fid,'!layer !start %s\n',clrout.layers(indy).name);
    
    line=mkvector2line('!depth',clrout.layers(indy).depth);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    line=mkvector2line('!vp',clrout.layers(indy).vp);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    line=mkvector2line('!vs',clrout.layers(indy).vs);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    line=mkvector2line('!rho',clrout.layers(indy).rho);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    line=mkvector2line('!qp',clrout.layers(indy).qp);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    line=mkvector2line('!qs',clrout.layers(indy).qs);
    if ~isempty(line)
       fprintf(fid,'%s\n',line);
    end; % if ~isempty
    
    fprintf(fid,'!layer !end\n');
    fprintf(fid,'\n'); % empty line
end; % for indy

%%% write Discontinuity Information
fprintf(fid,'\n'); % empty line
%%% Standard discontinuities
fprintf(fid,'// Standard Discontinuities \n');
if ~isnan(clrout.conr)
   fprintf(fid,'!discon !depth %1.15e Conrad\n',clrout.conr);
end; % id ~isnan
if ~isnan(clrout.moho)
   fprintf(fid,'!discon !depth %1.15e Moho\n',clrout.moho);
end; % id ~isnan
if ~isnan(clrout.d410)
   fprintf(fid,'!discon !depth %1.15e Olivine Alpha Beta\n',clrout.d410);
end; % id ~isnan
if ~isnan(clrout.d520)
   fprintf(fid,'!discon !depth %1.15e Olivine Beta Gamma\n',clrout.d520);
end; % id ~isnan
if ~isnan(clrout.d660)
   fprintf(fid,'!discon !depth %1.15e Olivine Gamma Perovskite\n',clrout.d660);
end; % id ~isnan
if ~isnan(clrout.cmb)
   fprintf(fid,'!discon !depth %1.15e CMB\n',clrout.cmb);
end; % id ~isnan
if ~isnan(clrout.icb)
   fprintf(fid,'!discon !depth %1.15e ICB\n',clrout.icb);
end; % id ~isnan
fprintf(fid,'\n'); % empty line

%%% non-standard discontinuities
fprintf(fid,'// Non-Standard Discontinuities \n');
if ~isempty(clrout.dz)
   dzcnt=length(clrout.dz);
   for indy=1:dzcnt
       fprintf(fid,'!discon !depth %1.15e %s\n',clrout.dz(indy),deblank(clrout.dname(indy,:)));
   end; % for indy
end; % if ~isempty(dz)

%%% write an end-of file notice
fprintf(fid,'\n'); % empty line
fprintf(fid,'// file ends here');


%%% close file
fclose(fid);


return;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          HELPER ROTUINES                              %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function line=mkvector2line(modifier,vector);
% mkvector2str.......transforms a coerfficient vector into a output line for clr format
%
% call: line=mkvector2line(modifier,vector);
%
%            modifier: clr format modifier string
%            vector: a 1D vector of numbers
%
% result: line: a string which can directly be written to the file
%                This string contains keyword, modifier, and data
%               or is empty if data is NaN.
%
% Martin Knapmeyer, 03.09.2003

%%% init output
line='!layer ';

%%% add modifier
line=[line modifier ' '];

%%% add data vector
if ~isnan(vector)
   vector=vector(:);
   %%% delete trailing zeros from vector
   indy=find(vector);
   if ~isempty(indy)
      vector=vector(1:max(indy)); % vector(indy) would delete all zeros!
   else
      vector=0;
   end; % if ~isempty(indy)
   %%% format remaining vector
   anz=length(vector);
   for indy=1:anz
       line=[line sprintf('%1.15f ',vector(indy))];
   end; % for indy
else
   line='';
end; % if isnan(vector)


