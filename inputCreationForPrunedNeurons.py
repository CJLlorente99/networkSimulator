import sys
import pandas as pd
import numpy as np

if __name__ == "__main__":
    allInputsFile = sys.argv[1]
    pruneFilename = sys.argv[2]
    outputFolder = sys.argv[3]

    dfInputs = pd.read_csv(allInputsFile)
    print(f'{allInputsFile} read')

    dfPrune = pd.read_csv(pruneFilename)
    print(f'{pruneFilename} read')

    for neuron in dfPrune.columns:
        df = dfInputs.drop(dfInputs.columns[dfPrune[neuron]], axis=1)
        dfNp = df.to_numpy()

        np.savetxt(f'{outputFolder}/{neuron}',
                    dfNp,
                    delimiter='',
                    fmt='%i',
                    newline='\r\n')
        print(f'{outputFolder}/{neuron} created successfully')
