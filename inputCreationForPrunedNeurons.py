import sys
import pandas as pd

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

        with open(f'{outputFolder}/{neuron}', 'w') as f:
            for index, row in df.iterrows():
                f.write(''.join(row.to_string(header=False, index=False).replace('\n', '')))
                f.write('\n')
            print(f'{outputFolder}/{neuron} created successfully')
