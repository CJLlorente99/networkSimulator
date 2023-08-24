/**
 * @brief This file leverages ABC get info about the number of ANDs and levels
 *
 * @param argc
 * @param argv [-opt] [Folder where all the PLA files are located] [Folder where the AIGER fiels are saved]
 * @return int
 */

#include <iostream>
#include <experimental/filesystem>
#include <string>
#include <sstream>
#include <fstream>
#include <vector>
#include <string.h>
#include <stdio.h>

#include "abcSynthesis.hpp"

using namespace std;

int main(int argc, char** argv){
    /* Parse arguments */
    string plaFolder = argv[1];

    /* ABC Interaction */
    Abc_Frame_t* pAbc;
    char command[1024];

    // Start framework
    Abc_Start();
    pAbc = Abc_FrameGetGlobalFrame();

    // Load aliases file
    sprintf(command, "source abc.rc");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error loading alias file %s\n", command);
        return 1;
    }

    // Iterate through all the PLA files
    vector<string> plaFiles;
    for(const auto& entry : std::experimental::filesystem::directory_iterator(plaFolder)){
        if(std::experimental::filesystem::is_regular_file(entry)){
            plaFiles.push_back(entry.path().string());
        }
    }

    vector<string> results;
    int i = 0;
    for (const auto& plaFile : plaFiles){
        const char* filename = plaFile.c_str();

        if (i == 0){
            // Read the AIG file
            sprintf(command, "read %s", filename);
            cout << command << endl;
            if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error reading PLA file %s\n", command);
                return 1;
                }

            // The first file must be strashed
            sprintf(command, "strash");
            if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error reading AIGER file %s\n", command);
                return 1;
                }
            } else {
                sprintf(command, "append %s", filename);
                cout << command << endl;
                if ( Cmd_CommandExecute(pAbc, command) ) {
                    fprintf(stdout, "Error appending file %s\n", command);
                    return 1;
                    }
            }
        i++;
    }
    // Minimize
    sprintf(command, "resyn2");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error resyn2 %s\n", command);
        return 1;
    }

    // Minimize
    plaFolder.pop_back();
    printf("%s", plaFolder.c_str());
    sprintf(command, "write_verilog %s.v", plaFolder.c_str());
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error verilog %s\n", command);
        return 1;
    }

    // Mapping
    sprintf(command, "if");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error mapping %s\n", command);
        return 1;
    }

    // Print stats
    sprintf(command, "print_stats");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error printing fanio %s\n", command);
        return 1;
    }

    sprintf(command, "print_fanio");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error printing fanio %s\n", command);
        return 1;
    }

    sprintf(command, "print_io");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error printing io %s\n", command);
        return 1;
    }

    sprintf(command, "print_level");
    // cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error printing level %s\n", command);
        return 1;
    }

    // End framework
    Abc_Stop();
    return 0;
}
