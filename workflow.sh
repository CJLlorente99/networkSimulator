baseFolder=./data

printf "DEALING WITH FIRST LAYER\n\n"

printf "Creating AIG files\n\n"
./abcSynthesis $baseFolder/plas/L0 $baseFolder/aiger/L1
printf "Simulating outputs\n\n"
./networkSimulatorAiger $baseFolder/aiger/L1 $baseFolder/inputs/trainInput $baseFolder/simulatedOutputs/L1
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/L1 $baseFolder/inputSimulated/L0

printf "DEALING WITH SECOND LAYER\n\n"

./abcSynthesis $baseFolder/plas/L1 $baseFolder/aiger/L2
printf "Simulating outputs\n\n"
./networkSimulatorAiger $baseFolder/aiger/L2 $baseFolder/inputSimulated/L0 $baseFolder/simulatedOutputs/L2
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/L2 $baseFolder/inputSimulated/L1

printf "DEALING WITH THIRD LAYER\n\n"

./abcSynthesis $baseFolder/plas/L2 $baseFolder/aiger/L3
printf "Simulating outputs\n\n"
./networkSimulatorAiger $baseFolder/aiger/L3 $baseFolder/inputSimulated/L1 $baseFolder/simulatedOutputs/L3
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/L3 $baseFolder/inputSimulated/L2

printf "DEALING WITH FOURTH LAYER\n\n"

./abcSynthesis $baseFolder/plas/L3 $baseFolder/aiger/L4
printf "Simulating outputs\n\n"
./networkSimulatorAiger $baseFolder/aiger/L4 $baseFolder/inputSimulated/L2 $baseFolder/simulatedOutputs/L4
printf "Joining outputs for next layer inputs\n\n"
./createInputsFromSimulated $baseFolder/simulatedOutputs/L4 $baseFolder/inputSimulated/L3
