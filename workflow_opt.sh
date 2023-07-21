baseFolder=/media/carlosl/CHAR/data
modelName=eeb_100ep_100npl
plasSubfolder=ABC

printf "DEALING WITH FIRST LAYER\n\n"

#printf "Creating AIG files\n\n"
#./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer0 $baseFolder/aiger/$modelName/$plasSubfolder/layer1

#printf "Simulating outputs train\n\n"
#./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer1 $baseFolder/inputs/trainInput $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer1
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer1 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer1

#printf "Simulating outputs test\n\n"
#./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer1 $baseFolder/inputs/testInput $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer1
#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer1 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer1

printf "DEALING WITH SECOND LAYER\n\n"

#./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer1 $baseFolder/aiger/$modelName/$plasSubfolder/layer2
 
printf "Simulating outputs train\n\n"
./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer1 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2
 
#printf "Simulating outputs test\n\n"
#./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer1 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2
#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer2 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2

printf "DEALING WITH THIRD LAYER\n\n"

#./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer2 $baseFolder/aiger/$modelName/$plasSubfolder/layer3
 
printf "Simulating outputs train\n\n"
./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer2 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3
 
#printf "Simulating outputs train\n\n"
#./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer2 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3
#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer3 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3

printf "DEALING WITH FOURTH LAYER\n\n"

#./abcSynthesis -opt $baseFolder/plas/$modelName/$plasSubfolder/layer3 $baseFolder/aiger/$modelName/$plasSubfolder/layer4
 
printf "Simulating outputs train\n\n"
./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer3 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/trainlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/trainlayer4
 
#printf "Simulating outputs train\n\n"
#./networkSimulatorAiger $baseFolder/aiger/$modelName/$plasSubfolder/layer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer3 $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4
#printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/$modelName/$plasSubfolder/testlayer4 $baseFolder/inputSimulated/$modelName/$plasSubfolder/testlayer4
