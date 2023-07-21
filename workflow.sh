baseFolder=/media/carlosl/CHAR/data

printf "DEALING WITH FIRST LAYER\n\n"

printf "Creating AIG files\n\n"
#./abcSynthesis $baseFolder/plas/eeb_100ep_100npl/ABC/layer0 $baseFolder/aiger/eeb_100ep_100npl/ABC/layer1
printf "Simulating outputs train\n\n"
#./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer1 $baseFolder/inputs/trainInput $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer1
printf "Joining outputs for next layer inputs\n\n"
#./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer1 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer0

printf "Simulating outputs test\n\n"
./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer1 $baseFolder/inputs/testInput $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer1
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer1 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer0

 printf "DEALING WITH SECOND LAYER\n\n"

 #./abcSynthesis $baseFolder/plas/eeb_100ep_100npl/ABC/layer1 $baseFolder/aiger/eeb_100ep_100npl/ABC/layer2
 printf "Simulating outputs train\n\n"
 #./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer2 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer0 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer2
 printf "Joining outputs for next layer inputs\n\n"
 #./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer2 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer1
 
  printf "Simulating outputs test\n\n"
 ./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer2 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer0 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer2
 printf "Joining outputs for next layer inputs\n\n"
 ./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer2 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer1

 printf "DEALING WITH THIRD LAYER\n\n"

 #./abcSynthesis $baseFolder/plas/eeb_100ep_100npl/ABC/layer2 $baseFolder/aiger/eeb_100ep_100npl/ABC/layer3
 printf "Simulating outputs train\n\n"
 #./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer3 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer1 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer3
 printf "Joining outputs for next layer inputs\n\n"
 #./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer3 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer2
 
  printf "Simulating outputs train\n\n"
 ./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer3 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer1 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer3
 printf "Joining outputs for next layer inputs\n\n"
 ./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer3 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer2

 printf "DEALING WITH FOURTH LAYER\n\n"

 #./abcSynthesis $baseFolder/plas/eeb_100ep_100npl/ABC/layer3 $baseFolder/aiger/eeb_100ep_100npl/ABC/layer4
 printf "Simulating outputs train\n\n"
 #./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer4 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer2 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer4
 printf "Joining outputs for next layer inputs\n\n"
 #./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer4 $baseFolder/inputSimulated/eeb_100ep_100npl/trainlayer3
 
  printf "Simulating outputs train\n\n"
 ./networkSimulatorAiger $baseFolder/aiger/eeb_100ep_100npl/ABC/layer4 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer2 $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer4
 printf "Joining outputs for next layer inputs\n\n"
 ./createInputsFromSimulated $baseFolder/simulatedOutputs/eeb_100ep_100npl/layer4 $baseFolder/inputSimulated/eeb_100ep_100npl/testlayer3
