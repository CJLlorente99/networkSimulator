#include "include/aiger/aiger.h"
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <assert.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <dirent.h>

char *strremove(char *str, const char *sub);

int main(int argc, char** argv){
    // Parse arguments
    char* aigerFolder = argv[1];
    char* inputFolder = argv[2];
    char* outputFolder = argv[3];
    int neuronsPerLayer = atoi(argv[4]);

    // Loop over all the files in the aiger folder
    DIR *d;
    char aigerFilename[1024];
    char outputFilename[1024];

    for (int i=0; i < neuronsPerLayer; i++){
        sprintf(aigerFilename, "%s/N%04d.aig", aigerFolder, i);
        sprintf(outputFilename, "%s/N%04d", outputFolder, i);

        printf("\nSimulating %s\n", aigerFilename);

        // Prepare to redirect terminal output to a file
        int out = open(outputFilename, O_RDWR|O_CREAT|O_APPEND, 0600);
        if (out == -1)
            return 1;

        int save_out = dup(fileno(stdout));

        if ( dup2(out, fileno(stdout)) == -1 )
            return 1;                

        // Simulate all inputs
        char command[4096];
        char inputFilename[1024];
        sprintf(inputFilename, "%s/N%04d", inputFolder, i);
        sprintf(command, "./include/aiger/aigsim %s %s", aigerFilename, inputFilename);
        system(command);

        // Back to normal terminal output
        fflush(stdout);
        close(out);

        dup2(save_out, fileno(stdout));

        close(save_out);

        // Delete the AIG file
//                remove(aigerFilename);
    }

    return 0;
}

char *strremove(char *str, const char *sub) {
    size_t len = strlen(sub);
    if (len > 0) {
        char *p = str;
        size_t size = 0;
        while ((p = strstr(p, sub)) != NULL) {
            size = (size == 0) ? (p - str) + strlen(p + len) + 1 : size - len;
            memmove(p, p + len, size - (p - str));
        }
    }
    return str;
}

