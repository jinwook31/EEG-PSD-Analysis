close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\';
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'}; 

for i = 1:length(SUB)
    [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
    
    % Load EEG set
    EEGica = pop_loadset( 'filename', [SUB{i} '_preprocess.set'], 'filepath', filePth);
    
    %Remove segments of EEG during the break periods in between trial blocks (defined as 10 seconds or longer in between successive stimulus event codes)
    EEGica  = pop_erplabDeleteTimeSegments( EEGica , 'displayEEG', 0, 'ignoreUseEventcodes', [100, 102, 104, 106, 108, 110], 'ignoreUseType', 'Use', 'startEventcodeBufferMS', 2000, 'endEventcodeBufferMS',  12000 );
        
    % Run ICA
    %EEG = pop_runica(EEG, 'extended',1,'interupt','off');
    EEGica = pop_tesa_fastica( EEGica, 'g', 'gauss', 'stabilization', 'on' );
    
    
    %Load the continuous EEG data file outputted from Script #1 in .set EEGLAB file format
    EEG = pop_loadset( 'filename', [SUB{i} '_preprocess.set'], 'filepath', filePth);

    %Transfer ICA weights to the continuous EEG data file (e.g., without the break periods and noisy segments of data removed)
    EEG = pop_editset(EEG, 'icachansind', 'EEGica.icachansind', 'icaweights', 'EEGica.icaweights', 'icasphere', 'EEGica.icasphere');
    
    %Save a pdf of the topographic maps of the ICA weights for later review
    %set(groot,'DefaultFigureColormap',jet)
    %pop_topoplot(EEG, 0, [1:31],[SUB{i} '_ICA'], [6 6] ,0,'electrodes','on');
    %save2pdf([Subject_Path 'graphs' filesep SUB{i} '_ICA_Weights.pdf']);
    %close all
        
        
    % Save
    EEG = eeg_checkset( EEG );
    [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1, 'setname', SUB{i}, 'savenew', strcat(filePth, [SUB{i}, '_preprocess_ICA.set']), 'gui', 'off');
end
