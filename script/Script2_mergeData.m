close all; clearvars;
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\';
SUB = {'P14'}; 

% Merge vhdr data / 실험 중 중단된 경우에만
% Only for divided sets!!

for i = 1:length(SUB)
    EEG = pop_fileio(strcat(filePth, ['EEG Data\', SUB{i}, '.vhdr']));
    EEG.setname = SUB{i};
    EEG = eeg_checkset( EEG );

    EEG2 = pop_fileio(strcat(filePth, 'EEG Data\P14_2.vhdr'));
    EEG2.setname = [SUB{i},'_2'];
    EEG2 = eeg_checkset( EEG2 );

    % Merge Dataset
    OUTEEG = pop_mergeset( EEG, EEG2, 0);
    OUTEEG.setname=SUB{i};
    OUTEEG = eeg_checkset( OUTEEG );

    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, OUTEEG, 1, 'setname', SUB{i}, 'savenew', strcat(filePth, ['EEG (set format)\', SUB{i}, '.set']), 'gui', 'off');
end
