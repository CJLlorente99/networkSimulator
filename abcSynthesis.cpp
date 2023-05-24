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

#include "abcSynthesis.hpp"

using namespace std;

int main(int argc, char** argv){
    /* Parse arguments */
    bool optimize = false;
    string folderName = "data/plas";
    string outFolderName = "data/x";

    if(argv[1] == "-opt"){
        optimize = true;
        folderName = argv[2];
        outFolderName = argv[3];
    } else {
        folderName = argv[1];
        outFolderName = argv[2];
    }

    /* List all the PLA files in the folder */
    vector<string> plaFiles;
    for(const auto& entry : std::filesystem::directory_iterator(folderName)){
        if(entry.is_regular_file()){
            plaFiles.push_back(entry.path().string());
        }
    }

    /* ABC Interaction */
    Abc_Frame_t* pAbc;
    char command[1024];

    // Start framework
    Abc_Start();
    pAbc = Abc_FrameGetGlobalFrame();

    // Iterate through all the PLA files
    int i = 0;
    for(const auto& plaFile : plaFiles){
        const char* filename = plaFile.c_str();
        // Read the PLA file
        sprintf(command, "read_pla %s", filename);
        cout << command << endl;
        if ( Cmd_CommandExecute(pAbc, command) ) {
            fprintf(stdout, "Error reading PLA file %s\n", command);
            return 1;
        }

        // Print stats
        sprintf(command, "print_stats");
        cout << command << endl;
        if ( Cmd_CommandExecute(pAbc, command) ) {
            fprintf(stdout, "Error printintg stats %s\n", command);
            return 1;
        }

        if (optimize) {
            // Logic minimization step
            // sprintf(command, "resyn");
            sprintf(command, "resyn2");
            cout << command << endl;
            if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error minimizing PLA file %s\n", command);
                return 1;
            }
        }else{
            // Structurally hash into AIGs
            sprintf(command, "strash");
            cout << command << endl;
            if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error hashing PLA file %s\n", command);
                return 1;
            }
        }

        // Write the AIG file
        unsigned first = plaFile.find("output");
        unsigned last = plaFile.find(".pla");
        string outFilename = outFolderName + '/' + plaFile.substr(first, last - first) + ".aig";
        sprintf(command, "write_aiger %s", outFilename.c_str());
        cout << command << endl;
        if ( Cmd_CommandExecute(pAbc, command) ) {
            fprintf(stdout, "Error writing AIG file %s\n", command);
            return 1;
        }
        string msg = to_string(++i) + " / " + to_string(plaFiles.size()); 
        cout << msg << endl;
    }
    // End framework
    Abc_Stop();
    return 0;
}