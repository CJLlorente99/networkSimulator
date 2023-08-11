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
    string modelAigerFolder = argv[1];

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

    // Load aliases file
    sprintf(command, "source abc.rc");
    cout << command << endl;
    if ( Cmd_CommandExecute(pAbc, command) ) {
        fprintf(stdout, "Error loading alias file %s\n", command);
        return 1;
    }

    // Open the output file
    fstream outputFileAnd;
    fstream outputFileLevel;
    string outputFilenameAnd;
    string outputFilenameLevel;
    sprintf(outputFilenameAnd, "aigerAndStats.csv");
    sprintf(outputFilenameLevel, "aigerLevelStats.csv");
    outputFileAnd.open(outputFilenameAnd, ios::app);
    outputFileLevel.open(outputFilenameLevel, ios::app);

    // Iterate through all the PLA files
    vector<int> andInfo;
    vector<int> levelInfo;
    int i = 0;
    for(const auto& aigFolder : aigerSubfolders){
        outputFileAnd << aigFolder;
        outputFileLevel << aigFolder;
        for (const auto& aigFile : std::experimental::filesystem::directory_iterator(aigFolder)){
            const char* filename = aigFile.path().string().c_str();

            // Read the AIG file
            sprintf(command, "read_aiger %s", filename);
            cout << command << endl;
            if ( Cmd_CommandExecute(pAbc, command) ) {
            fprintf(stdout, "Error reading AIGER file %s\n", command);
            return 1;
            }

            // Print stats
            sprintf(command, "print_stats");
            cout << command << endl;
            if ( Cmd_CommandExecute(pAbc, command) ) {
                fprintf(stdout, "Error printintg stats %s\n", command);
                return 1;
            }

            // Get result
            string line;
            stringstream ss;
            getline(cin, line);
            ss << line;

            int nInput;
            int nOutput;
            int nLat;
            int nAnd;
            int nLevels;

            string temp;
            int found;
            int count = 0;
            while (!ss.eof()) {
                ss >> temp;

                if (stringstream(temp) >> found) {
                    if (count == 0) {
                        nInput << found;
                    } else if (count == 1) {
                        nOutput << found;
                    } else if (count == 2) {
                        nLat << found;
                    } else if (count == 3) {
                        nAnd << found;
                    } else if (count == 4) {
                        nLevels << found;
                    }
                    count++;
                }
                temp = "";
            }

            printf("nAnd = %d nLevels = %d\n", nAnd, nLevels);

            // Append the figures to a new line in the output file
            outputFileAnd << "," << nAnd;
            outputFileLevel << "," << nLevels;
        }
        outputFileAnd << endl;
        outputFileLevel << endl;
    }
    // End framework
    Abc_Stop();
    return 0;
}
