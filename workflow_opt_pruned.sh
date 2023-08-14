baseFolder=/media/carlosl/CHAR/data
modelName=bnn/bnn_prunedBT6_100ep_4096npl
neuronPerLayer=4096
#plasSubfolder=ABC
#plasSubfolder=ABCOptimizedPerClass
#plasSubfolder=ABCOptimizedPerEntry

#for plasSubfolder in ABC ABCOptimizedPerClass ABCOptimizedPerEntry
for modelName in bnn/bnn_prunedBT6_100ep_4096npl bnn/bnn_prunedBT8_100ep_4096npl bnn/bnn_prunedBT10_100ep_4096npl
do

printf "\n$modelName\n"

for plasSubfolder in ABC
do

printf "$plasSubfolder\n\n"

printf "CREATE FOLDERS\n\n"
python3 ./folderCreation.py ${baseFolder} ${modelName} ${plasSubfolder}

printf "DEALING WITH SECOND LAYER\n\n"

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer1 $baseFolder/aiger/$modelName/$plasSubfolder/layer2

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/${modelName}/trainlayer1.csv $baseFolder/savedModels/${modelName}_prunedInfol1.csv $baseFolder/auxFolder ¼neuro

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2

printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/${modelName}/testlayer1.csv $baseFolder/savedModels/${modelName}_prunedInfol1.csv $baseFolder/auxFolder

printf "Simulating outputs test\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2

################################################################################################################################################################################################

printf "DEALING WITH THIRD LAYER\n\n"

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer2 $baseFolder/aiger/$modelName/$plasSubfolder/layer3

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2 $baseFolder/savedModels/${modelName}_prunedInfol2.csv $baseFolder/auxFolder
 
printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2 $baseFolder/savedModels/${modelName}_prunedInfol2.csv $baseFolder/auxFolder

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3

################################################################################################################################################################################################

printf "DEALING WITH FOURTH LAYER\n\n"

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer3 $baseFolder/aiger/$modelName/$plasSubfolder/layer4

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3 $baseFolder/savedModels/${modelName}_prunedInfol3.csv $baseFolder/auxFolder
 
printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer4
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3 $baseFolder/savedModels/${modelName}_prunedInfol3.csv $baseFolder/auxFolder

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 $neuronPerLayer

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer4

done
done
