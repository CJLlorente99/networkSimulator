#include <iostream>
#include <filesystem>
#include <string>
#include <vector>
#include <stdio.h>
#include <algorithm>
#include <fstream>
#include <iterator>

using namespace std;

int main(int argc, char *argv[]){
    // string simulatedOutputsFolder = "./data/simulatedOutputs";
    // string outputFilename = "./data/inputSimulated/L0";

    string simulatedOutputsFolder = argv[1];
    string outputFilename = argv[2];

    /* List all the SimulatedOutput files in the folder */
    vector<string> simFiles;
    for(const auto& entry : std::filesystem::directory_iterator(simulatedOutputsFolder)){
        if(entry.is_regular_file()){
            simFiles.push_back(entry.path().string());
        }
    }

    // Sort
    sort(simFiles.begin(), simFiles.end());

    // Get the number of simulations
    ifstream file(simFiles[0].c_str());
    file.unsetf(std::ios_base::skipws);

    unsigned numSims = std::count(
        istream_iterator<char>(file),
        istream_iterator<char>(), 
        '\n');

    // Loop over the ordered files and stack each output
    int matrix[numSims][simFiles.size()];
    string line;
    for ( int neuron = 0; neuron < simFiles.size(); neuron++ ){
        ifstream file(simFiles[neuron].c_str());
        for ( int sim = 0; sim < numSims; sim++ ){
            getline(file, line);
            reverse(line.begin(), line.end());
            matrix[sim][neuron] = int(line[1]) - 48;
        }
    }
    
    // Print the matrix into a file
    fstream outputFile;
    outputFile.open(outputFilename.c_str(), fstream::out);

    for ( int sim=0; sim < numSims; sim++ ){
        for ( int neuron=0; neuron < simFiles.size(); neuron++ ){
            outputFile << matrix[sim][neuron];
        }
        outputFile << endl;
    }
    return 0;
}