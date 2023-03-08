#!/usr/bin/env python3
import os, csv
import pandas as pd
import numpy as np

path = 'C:/Users/jinwook/Desktop/Vection Data Analysis/Experiment Data/fftResult/'
resPath = 'C:/Users/jinwook/Desktop/Vection Data Analysis/Experiment Data/fftResult/Average/'

header = ['100F','102F','104F','106F','108F','110F', '100C','102C','104C','106C','108C','110C','100P','102P','104P','106P','108P','110P','100O','102O','104O','106O','108O','110O','100T','102T','104T','106T','108T','110T']
bandRes = [[],[],[],[],[]]
bandName = ['delta','alpha','beta','theta','gamma']

SUB = ['P01', 'P02', 'P04', 'P05', 'P06', 'P08', 'P09','P13','P14', 'P15','P17','P18','P19','P20','P21','P23', 'P26', 'P27', 'P28', 'P29']
#SUB = ['P01', 'P02', 'P04', 'P05', 'P06',  'P09','P13','P14', 'P15','P18','P21','P23', 'P26', 'P27', 'P28', 'P29']

eegPart = ['Frontal', 'Central', 'Parietal', 'Occipital', 'Temporal']
STIM = ['100', '102', '104', '106', '108', '110']


def readLine(p, s, b):
    fName = p + '_' + s + '_' + b
    f = open(path + fName + '.txt', 'r')
    line = f.readline()
    line = line.replace('\n', '')
    bandPw = line.split(',')
    bandPw = list(map(float, bandPw))
    f.close()
    return bandPw


def main():
    for p in SUB:
        partPw = [[], [], [], [], []]
        for b in eegPart:
            for s in STIM:
                powerSpec = readLine(p, s, b)
                idx = 0
                for power in powerSpec:
                    partPw[idx].append(power)
                    idx += 1
        
        idx = 0
        for res in partPw:
            bandRes[idx].append(res)
            idx += 1
    
    
    # Make CSV 
    idx = 0
    for band in bandRes:
        fName = bandName[idx] + '.csv'
        idx += 1

        with open(resPath + fName, 'w',newline='') as f: 
            write = csv.writer(f) 
            write.writerow(header)
            write.writerows(band)
            


if __name__ == "__main__":
	main()

