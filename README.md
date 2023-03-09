# EEG-PSD-Analysis

The EEGLAB (MATLAB) time-Freq analysis code for Quick-32r (https://www.cgxsystems.com/quick-32r) data.
THis code is written based on the ERP Core (Kappenman et al., 2021) and EEGLAB tutorial.


Script Discription
-------------------

Script 1 : Modify vmrk file to adjust marker time or name. Also, it filter out some unnessasry markers. (Only for Q32r)

Script 2 : Merge data file that is divided due to stopped event during experiment.

Script 3 : (Normally Start from here) Convert vdhr format to set format.

Script 4 : Preprocess full data

Script 5 : run fastICA on epoch data (rest, non-trial data is removed)

Script 6 : Apply ICA weight on full data

Script 7 : Make epoch based on trial conditions

Script 8 : Make STUDY for data visualization

Script 9 : Extract each frequency band in brain area in to txt file.

Script 10 : Merge the txt file from previous result into one csv file.



Reference
-------------------
[1] https://eeglab.org/tutorials/02_Quickstart/quickstart.html

[2] https://wikidocs.net/32541

[3] https://www.sciencedirect.com/science/article/pii/S1053811920309502?via%3Dihub

