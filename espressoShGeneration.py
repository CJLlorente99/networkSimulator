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
            f.write(f'printf "ESPRESSOing {inputPLAFolder}/{dir.name}"\n')
            f.write(f'../espresso-logic/bin/espresso -efast -o fr {inputPLAFolder}/{dir.name} > {outputPLAFolder}/{dir.name}.pla\n')
            f.write(f'printf "ESPRESSOed {inputPLAFolder}/{dir.name}"\n')
        f.close()
    os.chmod("espressoExe.sh", 0o777)
	
