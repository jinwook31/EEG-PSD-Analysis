close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\';
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08','P09','P13','P14','P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'};  

for i = 1:length(SUB)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    % Load EEG set
    EEG = pop_loadset( 'filename', [SUB{i} '_preprocess_ICA.set'], 'filepath', filePth);   
    
    tmp = interface_ADJ(EEG, [filePth 'ADJUST result\' SUB{i} '_ADJUST Report.txt']);
    % Apply ADJUST
    fid = fopen([filePth 'ADJUST result\' SUB{i} '_ADJUST Report.txt']);
    tline = '';
    while ~feof(fid)
       prevline = tline;
       tline = fgetl(fid);
    end
    fclose(fid);
    
    Components = regexp(prevline, '  ', 'split');
    res = [];
    for j = 1:length(Components)
        res(end+1) = str2double(Components(j));
    end
    Components = res;
        
    %Perform ocular correction by removing the ICA component(s) specified above
    EEG = pop_subcomp( EEG, [Components], 0);
    
    % Save
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', SUB{i}, 'savenew', strcat(filePth, [SUB{i}, '_preprocess_ICA removed.set']), 'gui', 'off');
end


