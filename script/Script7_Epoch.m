close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\';
epochPth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\Epochs\';

STIM = {'100' '102' '104' '106' '108' '110'};
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'}; 

for i = 1:length(SUB)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    % Load EEG set
    EEG = pop_loadset( 'filename', [SUB{i} '_preprocess_ICA removed.set'], 'filepath', filePth);
    
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'setname', SUB{i}, 'savenew', strcat(epochPth, [SUB{i}, '_Full epoch.set']), 'gui', 'off');
    
    % Remove very noisy data segments (>250mV)
    %EEG = uf_continuousArtifactDetect(EEG,'amplitudeThreshold',250);
    
    % EEG = pop_epoch( EEG, { '100' '102' '104' '106' '108' '110' }, [0 10], 'newname', 'Vection Trial dataset epochs', 'epochinfo', 'yes');
    
    for j = 1:length(STIM)        
        % Make EventList & Epoch
        EEGSEL  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist', [epochPth SUB{i} '_Eventlist.txt'] ); 
        EEGSEL  = pop_binlister( EEGSEL , 'BDF', strcat(epochPth, ['BDF_' STIM{j} '.txt']), 'ExportEL', [epochPth SUB{i} '_' STIM{j} '_Eventlist_Bins.txt'], 'IndexEL',  1, 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Voutput', 'EEG' );

        % Baseline Correction (-1~0s)
        EEGSEL = pop_epochbin( EEGSEL , [0.0  10000.0],  [-2000.0  0.0]);
       
        EEGSEL = eeg_checkset( EEGSEL );
        [ALLEEG EEGSEL CURRENTSET] = pop_newset(ALLEEG, EEGSEL, 1, 'setname', SUB{i}, 'savenew', strcat(epochPth, [SUB{i}, '_epoch_' STIM{j} '.set']), 'gui', 'off');
    end
end



