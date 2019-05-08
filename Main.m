%nainireddy@iisc.ac.in
%This code is for computing formant-Gap features for whisper speaker
%verification task, which is proposed in the below paper.

%  A. R. Naini, A. R. M. V, and P. K. Ghosh, “Formant-gaps features for speaker verification using whispered speech,” 
%  in IEEE International Conference on Acoustics, Speech and Signal Processing (ICASSP), 2019.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code uses formant extraction code proposed by Baris Bozkurt / Thomas Drugman thomas.drugman@umons.ac.be

%References
% B. BOZKURT, B. DOVAL, C. D'ALESSANDRO, T. DUTOIT, 2004, "Improved
% differential phase spectrum processing for formant tracking",
% Proc. Icslp 2004, Jeju Island (Korea).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%path where the algorithm searches for audio files and will save features
audio_data='./audio/';

%path where the algorithm saves the resulting features in hdf5 format, if
%the absolute path does not exist, the algorithm creates it

feats_data = './features/';
%% create a list with audio files path as shown in All_audio.lst
% just put in one column the name of the audio file and in front of it, in a second column, the name
% of the target feature file separated with tab ('\t' character). 
%See the estructure of Audio2Feats.list file.
[wav_list,feat_list,not_required]=textread('All_audio.lst','%s\t%s\t%s');

FS=16e3;

%add toolboxes
addpath('voicebox');

feat_extraction(audio_data,feats_data,wav_list,feat_list,FS)