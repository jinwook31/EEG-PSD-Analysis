close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\';
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'}; 

for i = 1:length(SUB)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    % Load EEG set
    EEG = pop_loadset( 'filename', [SUB{i} '.set'], 'filepath', filePth);
    
    % Drop Channel
    EEG = pop_chanedit(EEG, 'nochannel', [31:37] );
    
    % Channel loc mapping (10-20 size)
    EEG = pop_chanedit(EEG, 'lookup','C:\Users\jinwook\Desktop\Vection Data Analysis\32r Channel Locations.ced');
        
    % Average reference (A1 & A2 or [] (Avg))
    EEG = pop_reref( EEG , []);
    
    % Resample
    EEG = pop_resample( EEG, 256 );
    
    % High / Lowpass filter
    EEG = pop_eegfiltnew(EEG, 0.2, 50,[], 0,[], 0);
  
    % Remove DC
    EEG  = pop_basicfilter( EEG,  1:29 , 'Boundary', 'boundary', 'Cutoff',  0.1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2, 'RemoveDC', 'on' );
    
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', SUB{i}, 'savenew', strcat(filePth, [SUB{i}, '_preprocess.set']), 'gui', 'off');
end

