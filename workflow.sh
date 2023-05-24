./abcSynthesis ./data/plas/L0 ./data/aiger/L1
./networkSimulatorAiger ./data/aiger/L1 ./data/inputs/trainInput ./data/simulatedOutputs/L1
./createInputsFromSimulated ./data/simulatedOutputs/L1 ./data/inputSimulated/L0

./abcSynthesis ./data/plas/L1 ./data/aiger/L2
./networkSimulatorAiger ./data/aiger/L2 ./data/inputSimulated/L0 ./data/simulatedOutputs/L2
./createInputsFromSimulated ./data/simulatedOutputs/L2 ./data/inputSimulated/L1

./abcSynthesis ./data/plas/L2 ./data/aiger/L3
./networkSimulatorAiger ./data/aiger/L3 ./data/inputSimulated/L1 ./data/simulatedOutputs/L3
./createInputsFromSimulated ./data/simulatedOutputs/L3 ./data/inputSimulated/L2

./abcSynthesis ./data/plas/L3 ./data/aiger/L4
./networkSimulatorAiger ./data/aiger/L4 ./data/inputSimulated/L2 ./data/simulatedOutputs/L4
./createInputsFromSimulated ./data/simulatedOutputs/L4 ./data/inputSimulated/L3
