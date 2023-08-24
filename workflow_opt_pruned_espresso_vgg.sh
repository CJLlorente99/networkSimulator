baseFolder=/media/carlosl/CHAR/data
modelName=binaryVggVerySmall/binaryVGGVerySmall_prunedBT6_4

#plasSubfolder=ESPRESSO
##plasSubfolder=ESPRESSOOptimizedPerClass
#plasSubfolder=ESPRESSOOptimizedPerClass_0
#plasSubfolder=ESPRESSOOptimizedPerClass_1
#plasSubfolder=ESPRESSOOptimizedPerClass_2
#plasSubfolder=ESPRESSOOptimizedPerEntry_0
#plasSubfolder=ESPRESSOOptimizedPerEntry_1
#plasSubfolder=ESPRESSOOptimizedPerEntry_2

printf "\n$modelName\n"

for plasSubfolder in ESPRESSO ESPRESSOOptimizedPerEntry_0 ESPRESSOOptimizedPerEntry_1 ESPRESSOOptimizedPerEntry_2
do

printf "$plasSubfolder\n\n"

printf "CREATE FOLDERS\n\n"
python3 ./folderCreation.py ${baseFolder} ${modelName} ${plasSubfolder}

printf "DEALING WITH SECOND LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer1 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer1_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer1_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer2

#printf "TRAIN\n\n"

#printf "Creating input files for pruned neurons\n\n"
#python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/${modelName}/trainlayer42.csv $baseFolder/savedModels/${modelName}_prunedInfo0.csv $baseFolder/auxFolder 20000

#printf "Simulating outputs train\n\n"
#./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 4096

#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2

printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputs/${modelName}/testlayer42.csv $baseFolder/savedModels/${modelName}_prunedInfo0.csv $baseFolder/auxFolder 20000

printf "Simulating outputs test\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 4096

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2

################################################################################################################################################################################################

printf "DEALING WITH THIRD LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer2 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer2_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer2_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer3

#printf "TRAIN\n\n"

#printf "Creating input files for pruned neurons\n\n"
#python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2 $baseFolder/savedModels/${modelName}_prunedInfo1.csv $baseFolder/auxFolder 20000
 
#printf "Simulating outputs train\n\n"
#./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 4096

#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2 $baseFolder/savedModels/${modelName}_prunedInfo1.csv $baseFolder/auxFolder 20000

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 4096

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3

################################################################################################################################################################################################

printf "DEALING WITH FOURTH LAYER\n\n"

printf "ESPRESSO\n\n"

python3 ./espressoShGeneration.py ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer3 ${baseFolder}/plas/${modelName}/${plasSubfolder}/layer3_espresso
./espressoExe.sh

./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer3_espresso $baseFolder/aiger/$modelName/$plasSubfolder/layer4

#printf "TRAIN\n\n"

#printf "Creating input files for pruned neurons\n\n"
#python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3 $baseFolder/savedModels/${modelName}_prunedInfo2.csv $baseFolder/auxFolder 20000
 
#printf "Simulating outputs train\n\n"
#./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 1000

#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer4
 
printf "TEST\n\n"

printf "Creating input files for pruned neurons\n\n"
python3 ./inputCreationForPrunedNeurons.py $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3 $baseFolder/savedModels/${modelName}_prunedInfo2.csv $baseFolder/auxFolder 20000

printf "Simulating outputs train\n\n"
./networkSimulatorAigerPruned $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/auxFolder $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 1000

printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer4

done
