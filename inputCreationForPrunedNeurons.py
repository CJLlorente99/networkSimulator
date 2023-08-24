import sys
import pandas as pd
import numpy as np
import os
from itertools import islice

if __name__ == "__main__":
    allInputsFile = sys.argv[1]
    pruneFilename = sys.argv[2]
    outputFolder = sys.argv[3]
    chunksize = int(sys.argv[4])

    files = os.listdir(outputFolder)
    for file in files:
        file_path = os.path.join(outputFolder, file)
        os.remove(file_path)

    if allInputsFile.endswith('.csv'):
        chunkNum = 0
        
        for dfInputs in pd.read_csv(allInputsFile, index_col=0, chunksize=chunksize, dtype=int):
            print(f'{allInputsFile} read. Shape {dfInputs.shape}')
            
            totalNeurons = len(dfPrune.columns)
            count = 0
            for neuron in dfPrune.columns:
                df = dfInputs.drop(dfInputs.columns[dfPrune[neuron]], axis=1)
                dfNp = df.to_numpy()

                with open(f'{outputFolder}/{neuron}', 'a') as f:
                    np.savetxt(f,
                                dfNp,
                                delimiter='',
                                fmt='%i',
                                newline='\n')
                    f.close()
                if (count % 100) == 0:
                    print(f'Chunk [{chunkNum}] [{count:4d}/{totalNeurons:4d}] created successfully')
                count += 1
            print(f'Chunk [{chunkNum}] [{count:4d}/{totalNeurons:4d}] created successfully')
            chunkNum += 1
    else:
        with open(allInputsFile, 'r') as f_inputs:
            chunkNum = 0

            while True:
                gen = islice(f_inputs, chunksize)
                dfInputs = np.genfromtxt(gen, delimiter=1, dtype=int)
                
                if dfInputs.shape[0] == 0:
                    break

                columns = [f'N{i:04d}' for i in range(dfInputs.shape[1])]
                dfInputs = pd.DataFrame(dfInputs, columns=columns)
                dfInputs.astype(int)
                print(f'{allInputsFile} read. Shape {dfInputs.shape}')
                
                totalNeurons = len(dfPrune.columns)
                count = 0
                for neuron in dfPrune.columns:
                    df = dfInputs.drop(dfInputs.columns[dfPrune[neuron]], axis=1)
                    dfNp = df.to_numpy()

                    with open(f'{outputFolder}/{neuron}', 'a') as f:
                        np.savetxt(f,
                                dfNp,
                                delimiter='',
                                fmt='%i',
                                newline='\n')
                    f.close()
                    if (count % 100) == 0:
                        print(f'Chunk [{chunkNum}] [{count:4d}/{totalNeurons:4d}] created successfully')
                    count += 1
                print(f'Chunk [{chunkNum}] [{count:4d}/{totalNeurons:4d}] created successfully')
                chunkNum += 1
