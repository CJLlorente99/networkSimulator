baseFolder=/media/carlosl/CHAR/data
modelName=eeb_prunedBT6_100ep_100npl
plasSubfolder=ESPRESSO

printf "CREATE FOLDERS\n\n"
python3 ./folderCreation.py ${baseFolder} ${modelName} ${plasSubfolder}

printf "DEALING WITH SECOND LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer1 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer1_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer1_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer2

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/trainlayer1 $baseFolder/savedModels/${modelName}_prunedInfol1.csv $baseFolder/auxFolder

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2

printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/testlayer1 $baseFolder/savedModels/${modelName}_prunedInfol1.csv $baseFolder/auxFolder

printf "Simulating outputs test\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2

################################################################################################################################################################################################

printf "DEALING WITH THIRD LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer2 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer2_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer2_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer3

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2 $baseFolder/savedModels/${modelName}_prunedInfol2.csv $baseFolder/auxFolder
 
printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2 $baseFolder/savedModels/${modelName}_prunedInfol2.csv $baseFolder/auxFolder

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3

################################################################################################################################################################################################

printf "DEALING WITH FOURTH LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer3 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer3_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer3_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer4

printf "TRAIN\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3 $baseFolder/savedModels/${modelName}_prunedInfol3.csv $baseFolder/auxFolder
 
printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer4
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3 $baseFolder/savedModels/${modelName}_prunedInfol3.csv $baseFolder/auxFolder

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer4