import sys
import pandas as pd

if __name__ == "__main__":
    allInputsFile = sys.argv[1]
    pruneFilename = sys.argv[2]
    outputFolder = sys.argv[3]

    columns = [f'N{i:02d}' for i in range(100)]
    dfInputs = pd.read_csv(allInputsFile, sep='', header=None, names=columns, index_col=False)

    dfPrune = pd.read_csv(pruneFilename)

    for neuron in dfPrune.columns:
        df = dfInputs.drop(dfInputs.columns[dfPrune[neuron]], axis=1)

        with open(f'{outputFolder}/{neuron}', 'w') as f:
            for index, row in df.iterrows():
                f.write(''.join(row.to_string(header=False, index=False).split('\n')))
                f.write('\n')