function []=feat_extraction(audio_data,dest_data,wav_list,feat_path,FS)
% read list of files and start processing
for r= 1:length(wav_list)    
    
    name_wav    =[audio_data wav_list{r}]; disp(name_wav)
    [s,fs]      =audioread(name_wav);         
    
    if FS~=fs
        [b,a]   = cheby2(9,20,FS/(2*fs));
        s       =filter(b,a,s);
        s       =resample(s, FS, fs); %remuestrear              
    end    
   
   s=s/max(abs(s));
   [formantPeaks,t_analysis]=formant_CGDZP(s,FS);
   indices = find((abs(formantPeaks(:,1)))>900 |(abs(formantPeaks(:,1))<80)); % This removes the noise frames
   formantPeaks(indices,:) = [];
   form = transpose(formantPeaks);
  % form1 = zeros(size(form));
   form1 = form./(FS/4);
%    for f = 1:size(formantPeaks,1)
%       form1(:,f) = form(:,f)./max(form(:,f));
%    end
   z3 = zeros(12,size(form1,2));
   z3(1:5,:) = form1;
   for i = 1:4
       z3((i+5),:) = (form1(i+1,:) - form1(i,:));
   end
   for h = 1:3
       z3((h+9),:) = (z3(h+6,:) - z3(h+5,:));
   end
    %% In-case required %%
    d = deltas(z3, 3);
    d1 = deltas(d,3);
    d_f1 = vertcat(z3,d,d1);
    d_f = transpose(d_f1);
 %%                        %%  
   %save features to a hdf5 file
   z = transpose(z3);
   
   feat_file=[dest_data feat_path{r},'.h5']; disp(feat_file) 
   path_file = fileparts(feat_file);
   if ~(exist(path_file,'dir')==7), unix(['mkdir -p ' path_file]); end  
   
   
        
   h5create(feat_file,'/fdd',size(z)); 
   h5write(feat_file, '/fdd', z);        
   
        
        
   
         
end

