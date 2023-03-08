close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\';
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'};  % Only for non-divided sets


for i = 1:length(SUB)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    EEG = pop_fileio(strcat(filePth, ['EEG Data\', SUB{i}, '.vhdr']));
    EEG.setname = SUB{i};
    EEG = eeg_checkset( EEG );
    
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', SUB{i}, 'savenew', strcat(filePth, ['EEG (set format)\', SUB{i}, '.set']), 'gui', 'off');
end