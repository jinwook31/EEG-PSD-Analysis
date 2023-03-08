import os

expMarkers = [11, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 56, 57]
dir = '../../Experiment Data/EEG Data/'


# Get VMRK File List & path
def getVMRKList():
    def isEndsWithVMRK(x):
        return x.endswith('.vmrk')

    fList = list(filter(isEndsWithVMRK, os.listdir(dir + 'original markers/')))
    return fList


# Filter out Error markers
def FilterOut(fList):
    for mf in fList:
        f = open(dir + 'original markers/' + mf, 'r', encoding='UTF8')
        filteredMarkers = []

        lines = f.readlines()
        err = False

        if '_' in mf:  # 파일이 2개로 나눠졌을 때
            firstLine = False
        else:
            firstLine = True
        
        for line in lines:
            if line.startswith('Mk'):
                if err:
                    err = False
                    continue

                else:
                    segments = line.split(',')
                    if int(segments[1]) not in expMarkers:
                        err = True
                        continue

                    else:
                        if firstLine and int(segments[1]) == 11:
                            firstLine = False
                            filteredMarkers.append(line)
                            continue
                        elif not firstLine:
                            if int(segments[1]) % 2 == 0:
                                stimStartTime = int(segments[2]) + 1040   # Marker 2s 미루기 (회전 시작 시점으로)
                                line = line.replace(segments[2], str(stimStartTime))
                            filteredMarkers.append(line)
                        else:
                            continue

            else:
                filteredMarkers.append(line)

        f.close()

        with open(dir + mf, "w") as file:
            file.writelines(filteredMarkers)


def main():
    mList = getVMRKList()
    FilterOut(mList)


if __name__ == "__main__":
	main()

