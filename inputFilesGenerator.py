import torch
from torchvision import datasets
from torchvision.transforms import ToTensor, Compose
from torch.utils.data import DataLoader
from modules.binaryEnergyEfficiency import BinaryNeuralNetwork
import pandas as pd
import numpy as np
from modelsCommon.auxTransformations import *
import sys

if __name__ == '__main__':
    modelFilename = sys.argv[1]
    outputFolder = sys.argv[2]

    if "BT" in modelFilename:
        prunedBT = True
    else:
        prunedBT = False

    batch_size = 1
    neuronPerLayer = 100
    outputFilenameTrain = f'{outputFolder}/trainlayer1'
    outputFilenameTest = f'{outputFolder}/testlayer1'


    # Check mps maybe if working in MacOS
    device = 'cuda' if torch.cuda.is_available() else 'cpu'

    '''
    Importing MNIST dataset
    '''
    print(f'IMPORT DATASET\n')

    training_data = datasets.MNIST(
        root='/srv/data/image_dataset/MNIST',
        train=True,
        download=False,
        transform=Compose([
                ToTensor(),
                ToBlackAndWhite(),
                ToSign()
            ])
        )

    test_data = datasets.MNIST(
        root='/srv/data/image_dataset/MNIST',
        train=False,
        download=False,
        transform=Compose([
                ToTensor(),
                ToBlackAndWhite(),
                ToSign()
            ])
        )

    '''
    Create DataLoader
    '''
    train_dataloader = DataLoader(training_data, batch_size=batch_size)
    test_dataloader = DataLoader(test_data, batch_size=batch_size)

    '''
    Instantiate NN models
    '''
    print(f'MODEL INSTANTIATION\n')

    model = BinaryNeuralNetwork(neuronPerLayer).to(device) if not prunedBT else BinaryNeuralNetwork(neuronPerLayer, 1).to(device)
    model.load_state_dict(torch.load(modelFilename, map_location=torch.device(device)))

    '''
    Load the simulated inputs to the last layer (provided by minimized network)
    '''

    model.eval()

    aux = []
    for X, y in train_dataloader:
        X = torch.flatten(X, start_dim=1)
        predL0 = model.forwardOneLayer(X , 0)
        x = predL0.detach().cpu().numpy()
        x[x < 0] = 0
        aux.append(x.astype(int)[0])

    columns = [f'N{i:04d}' for i in range(100)]
    df = pd.DataFrame(np.array(aux), columns=columns)
    df.to_csv(f'{outputFilenameTrain}.csv')

    aux = []
    for X, y in test_dataloader:
        X = torch.flatten(X, start_dim=1)
        predL0 = model.forwardOneLayer(X , 0)
        x = predL0.detach().cpu().numpy()
        x[x < 0] = 0
        aux.append(x.astype(int)[0])

    columns = [f'N{i:04d}' for i in range(100)]
    df = pd.DataFrame(np.array(aux), columns=columns)
    df.to_csv(f'{outputFilenameTest}.csv')