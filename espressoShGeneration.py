import sys
import os

if __name__ == "__main__":
    inputPLAFolder = sys.argv[1]
    outputPLAFolder = sys.argv[2]

    if not os.path.exists(outputPLAFolder):
        os.makedirs(outputPLAFolder)

    files = os.scandir(inputPLAFolder)

    with open('espressoExe.sh', 'w') as f:
        for file in files:
            f.write(f'printf "ESPRESSOing {inputPLAFolder}/{dir.name}\n"\n')
            f.write(f'../espresso-logic/bin/espresso -efast -o fr {inputPLAFolder}/{file.name} > {outputPLAFolder}/{file.name}.pla\n')
            f.write(f'printf "ESPRESSOed {inputPLAFolder}/{file.name}\n"\n\n')
    f.close()
    os.chmod("espressoExe.sh", 0o777)
	