function   env=my_envelope(temp)
%function to calculate normalized envelopes 
%for each station
%--------------------------------------------------------------------------

trans=hilbert(temp); 
env=abs(trans);
env=env./max(env);
    
end
