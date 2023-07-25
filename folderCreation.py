import os
import sys

if __name__ == '__main__':
	baseFolder = sys.argv[1]
	modelName = sys.argv[2]
	plasSubfolder = sys.argv[3]

	# Create folder for plas (if espresso)
	if 'ESPRESSO' in plasSubfolder:
		if not os.path.exists(f'{baseFolder}/plas/{modelName}/{plasSubfolder}/layer1_espresso'):
			os.makedirs(f'{baseFolder}/plas/{modelName}/{plasSubfolder}/layer1_espresso')
			os.makedirs(f'{baseFolder}/plas/{modelName}/{plasSubfolder}/layer2_espresso')
			os.makedirs(f'{baseFolder}/plas/{modelName}/{plasSubfolder}/layer3_espresso')
	
	# Create folder for aiger
	if not os.path.exists(f'{baseFolder}/aiger/{modelName}/{plasSubfolder}'):
		os.makedirs(f'{baseFolder}/aiger/{modelName}/{plasSubfolder}/layer2')
		os.makedirs(f'{baseFolder}/aiger/{modelName}/{plasSubfolder}/layer3')
		os.makedirs(f'{baseFolder}/aiger/{modelName}/{plasSubfolder}/layer4')
		
	# Create folder for simulated outputs
	if not os.path.exists(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}'):
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/trainlayer2')
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/trainlayer3')
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/trainlayer4')
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/testlayer2')
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/testlayer3')
		os.makedirs(f'{baseFolder}/simulatedOutputs/{modelName}/{plasSubfolder}/testlayer4')
		
	# Create folder for input simulated
	if not os.path.exists(f'{baseFolder}/inputSimulated/{modelName}/{plasSubfolder}'):
		os.makedirs(f'{baseFolder}/inputSimulated/{modelName}/{plasSubfolder}')

