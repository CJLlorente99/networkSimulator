import sys
import pandas as pd
import numpy as np

if __name__ == "__main__":
    allInputsFile = sys.argv[1]
    pruneFilename = sys.argv[2]
    outputFolder = sys.argv[3]

    if allInputsFile.endswith('.csv'):
        dfInputs = pd.read_csv(allInputsFile, index_col=0)
        print(f'{allInputsFile} read. Shape {dfInputs.shape}')
    else:
        dfInputs = np.genfromtxt(allInputsFile, delimiter=1)
        columns = [f'N{i:04d}' for i in range(dfInputs.shape[1])]
        dfInputs = pd.DataFrame(dfInputs, columns=columns)
        dfInputs.astype(int)
        print(f'{allInputsFile} read. Shape {dfInputs.shape}')

    dfPrune = pd.read_csv(pruneFilename)
    print(f'{pruneFilename} read')
    
    totalNeurons = len(dfPrune.columns)
    count = 0
    for neuron in dfPrune.columns:
        df = dfInputs.drop(dfInputs.columns[dfPrune[neuron]], axis=1)
        dfNp = df.to_numpy()

        np.savetxt(f'{outputFolder}/{neuron}',
                    dfNp,
                    delimiter='',
                    fmt='%i',
                    newline='\n')
        #if (count % 100) == 0:
            #print(f'{count:4d}/{totalNeurons:04d} created successfully')
        count += 1
    print(f'{count:4d}/{totalNeurons:04d} created successfully')

