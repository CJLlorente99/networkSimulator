/**
 * @brief This file leverages ABC to minimize the ISF defined in the PLA files. Depending on the arguments provided by the user the result is
 * minimized or just translated into AIGER format. This AIGER files are meant to be evaluated followingly to check the accuracy
 * 
 * @param argc 
 * @param argv [-opt] [Folder where all the PLA files are located] [Folder where the AIGER fiels are saved]
 * @return int 
 */

#include <iostream>
#include <filesystem>
#include <string>
#include <vector>
#include <stdio.h>
#include <fstream>

#include "abcSynthesis.hpp"

using namespace std;

int main(int argc, char** argv){
    /* Parse arguments */
    bool optimize = false;
    string folderName = "/home/carlos/Documents/networkSimulator/data/plas/L0";
    string outFolderName = "/home/carlos/Documents/networkSimulator/data/aiger/L1";

    // if(argv[1] == "-opt"){
    //     optimize = true;
    //     folderName = argv[2];
    //     outFolderName = argv[3];
    // } else {
    //     folderName = argv[1];
    //     outFolderName = argv[2];
    // }

    /* List all the PLA files in the folder */
    vector<string> plaFiles;
    for(const auto& entry : std::filesystem::directory_iterator(folderName)){
        if(entry.is_regular_file()){
            plaFiles.push_back(entry.path().string());
        }
    }

    // Print the matrix into a file
    fstream outputFile;
    outputFile.open("exe.rc", fstream::out);

    // Iterate through all the PLA files
    int i = 0;
    char command[1024];
    for(const auto& plaFile : plaFiles){
        const char* filename = plaFile.c_str();
        // Read the PLA file
        sprintf(command, "read_pla %s", filename);
        outputFile << command << endl;
        
        // Print stats
        sprintf(command, "print_stats");
        outputFile << command << endl;

        if (optimize) {
            // Logic minimization step
            // sprintf(command, "resyn");
            sprintf(command, "resyn2");
            outputFile << command << endl;
        }else{
            // Structurally hash into AIGs
            sprintf(command, "strash");
            outputFile << command << endl;
        }

        // Write the AIG file
        unsigned first = plaFile.find("output");
        unsigned last = plaFile.find(".pla");
        string outFilename = outFolderName + '/' + plaFile.substr(first, last - first) + ".aig";
        sprintf(command, "write_aiger %s", outFilename.c_str());
        outputFile << command << endl;

        // Free possible use of memory
        sprintf(command, "empty");
        outputFile << command << endl;
    }
}