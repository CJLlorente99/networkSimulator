abcSynthesis:
    g++ -fdiagnostics-color=always -g -fpermissive ./abcSynthesis.cpp ./csvUtilities.cpp -I/include/ -I./ -L/opt/local/carlosl/abc -l:libabc.a -pthread -ldl -lstdc++fs -DFMT_HEADER_ONLY=1 -lreadline -o ./abcSynthesis
createInputsFromSimulated:
    g++ -fdiagnostics-color=always -g -fpermissive ./createInputsFromSimulated.cpp ./csvUtilities.cpp -I/include/ -I./ -L/opt/local/carlosl/abc -l:libabc.a -pthread -ldl -lstdc++fs -DFMT_HEADER_ONLY=1 -lreadline -o ./createInputsFromSimulated
networkSimulatorAiger:
    gcc -g ./include/aiger/aiger.c networkSimulatorAiger.c -o networkSimulatorAiger