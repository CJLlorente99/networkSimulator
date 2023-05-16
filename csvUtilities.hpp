#pragma once

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <sstream>

namespace csvUtilities {
    class CSVReader {
        public:
            std::ifstream file;
            char delimiter;
            CSVReader(std::string filename, char delimiter);
            int readNextLine(std::vector<bool> *inputs);
    };

    class CSVWriter {
        public:
            std::ofstream file;
            char delimiter;
            CSVWriter(std::string filename, char delimiter);
            int writeHeader(std::vector<std::string> columnHeaders);
            int writeNextLine(std::vector<bool> outputs);
    };
}