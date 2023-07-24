import sys
import pandas as pd

if __name__ == "__main__":
    allInputsFile = sys.argv[1]
    pruneFilename = sys.argv[2]
    outputFolder = sys.argv[3]

    columns = [f'N{i:02d}' for i in range(100)]
    dfInputs = pd.DataFrame(columns=columns)
    with open(allInputsFile, 'r') as f:
        count = 0
        while True:
            line = f.readline()

            if not line:
                break

            line = list(map(int, list(line)[:-1]))
            dfInputs = pd.concat([dfInputs, pd.DataFrame(line, index=columns, columns=[0]).transpose()], axis=0)
            count += 1
            if count % 5000 == 0:
                print(f'{count} lines read')
                break
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