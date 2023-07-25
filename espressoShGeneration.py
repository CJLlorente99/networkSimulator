import sys
import os

if __name__ == "__main__":
    inputPLAFolder = sys.argv[1]
    outputPLAFolder = sys.argv[2]

    if not os.path.exists(outputPLAFolder):
        os.makedirs(outputPLAFolder)

    dirs = os.scandir(inputPLAFolder)

    for dir in dirs:
        with open('espressoExe.sh', 'w') as f:
            f.write(f'ESPRESSOing {inputPLAFolder}/{dir.name}\n')
            f.write(f'./espresso -efast {inputPLAFolder}/{dir.name} > {outputPLAFolder}/{dir.name}.pla\n')
            f.write(f'ESPRESSOed {inputPLAFolder}/{dir.name}\n')
        f.close()