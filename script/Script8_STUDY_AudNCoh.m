close all; clearvars;

[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
pop_editoptions( 'option_storedisk', 1);

filepath = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\Epochs\';

STIM = {'100' '102' '104' '106' '108' '110'};
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'};
commands = {}; % initialize STUDY dataset list


% Loop through all of the subjects in the study to create the dataset
for loopnum = 1:length(SUB) %for each subject
    stim20 = fullfile(filepath, [SUB{loopnum} '_epoch_104.set']);
    stim80 = fullfile(filepath, [SUB{loopnum} '_epoch_110.set']);
    commands = {commands{:} ...
        {'index' 2*loopnum-1 'load' stim20 'subject' SUB{loopnum} 'condition' 'stim20'} ...
        {'index' 2*loopnum 'load' stim80 'subject' SUB{loopnum} 'condition' 'stim80'}};
end

% Uncomment the line below to select ICA components with less than 15% residual variance
% commands = {commands{:} {'dipselect', 0.15}};

[STUDY, ALLEEG] = std_editset(STUDY, ALLEEG, 'name','VECTION','commands',commands,'updatedat','on');

% Update workspace variables and redraw EEGLAB
CURRENTSTUDY = 1; EEG = ALLEEG; CURRENTSET = [1:length(EEG)];
[STUDY, ALLEEG] = std_checkset(STUDY, ALLEEG);
eeglab redraw


% All Channel Plot

% Compare Pz Cz Oz


