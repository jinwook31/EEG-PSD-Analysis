close all; clearvars;

filePth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\';
epochPth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\EEG (set format)\Epochs\';
fftPth = 'C:\Users\jinwook\Desktop\Vection Data Analysis\Experiment Data\fftResult\';

STIM = {'100' '102' '104' '106' '108' '110'};
SUB = {'P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29'};

eegPart = {[1:4 7 8 26 25 29 27],[6 9 11 12 14 24 28],[17:21],[10 13 15 16 22],[5 23]};
partName = {'Frontal', 'Central', 'Parietal', 'Occipital', 'Temporal'};

for i = 1:length(SUB)
    for j = 1:length(STIM)
        [ALLEEG EEG CURRENTSET ALLCOM] = eeglab;
        
        % Load EEG set
        EEG = pop_loadset('filename', [SUB{i} '_epoch_' STIM{j} '.set'], 'filepath', epochPth);
    
        for k = 1:length(eegPart)
            % for your epoched data
            [spectra,freqs] = spectopo(EEG.data(eegPart{k},:,:), 0, EEG.srate, 'winsize',EEG.srate*2, 'overlap',EEG.srate, 'plotmean', 'off', 'plot', 'off');
            
            % delta=1-4, theta=4-8, alpha=8-13, beta=13-30, gamma=30-50
            deltaIdx = find(freqs>1 & freqs<4);
            thetaIdx = find(freqs>4 & freqs<8);
            alphaIdx = find(freqs>8 & freqs<13);
            betaIdx  = find(freqs>13 & freqs<30);
            gammaIdx = find(freqs>30 & freqs<50);

            % compute absolute power
            deltaPower = mean(10.^(spectra(deltaIdx)/10));
            thetaPower = mean(10.^(spectra(thetaIdx)/10));
            alphaPower = mean(10.^(spectra(alphaIdx)/10));
            betaPower  = mean(10.^(spectra(betaIdx)/10));
            gammaPower = mean(10.^(spectra(gammaIdx)/10));
            
            res = [deltaPower, alphaPower, betaPower, thetaPower, gammaPower]
            writematrix(res, [fftPth SUB{i} '_' STIM{j} '_' partName{k} '.txt'])
        end
    end
end


