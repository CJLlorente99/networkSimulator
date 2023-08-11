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
    string modelFolder = argv[1];
    /* List all the Subfolders files in the folder */
    vector<string> subfolders;
    for(const auto& entry : std::experimental::filesystem::directory_iterator(modelFolder)){
        if(std::experimental::filesystem::is_directory(entry)){
            subfolders.push_back(entry.path().string());
        }
    }

    for(const auto& modelAigerFolder : subfolders){

        /* List all the Subfolders files in the folder */
        vector<string> aigerSubfolders;
        for(const auto& entry : std::experimental::filesystem::directory_iterator(modelAigerFolder)){
            if(std::experimental::filesystem::is_directory(entry)){
                aigerSubfolders.push_back(entry.path().string());
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
        for(const auto& aigFolder : aigerSubfolders){
            /* List all the AIGER files in the folder */
            vector<string> aigerFiles;
            for(const auto& entry : std::experimental::filesystem::directory_iterator(aigFolder)){
                if(std::experimental::filesystem::is_regular_file(entry)){
                    aigerFiles.push_back(entry.path().string());
                }
            }

            vector<string> results;
            for (const auto& aigFile : aigerFiles){
                const char* filename = aigFile.c_str();

                // Read the AIG file
                sprintf(command, "read_aiger %s", filename);
                // cout << command << endl;
                if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error reading AIGER file %s\n", command);
                return 1;
                }

                // Print stats
                sprintf(command, "print_stats");
                // cout << command << endl;
                if ( Cmd_CommandExecute(pAbc, command) ) {
                    fprintf(stdout, "Error printintg stats %s\n", command);
                    return 1;
                }
            }
        }
    }
    // End framework
    Abc_Stop();
    return 0;
}
